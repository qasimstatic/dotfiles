float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b)
{
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

// Based on Inigo Quilez's 2D distance functions article: https://iquilezles.org/articles/distfunctions2d/
// Potencially optimized by eliminating conditionals and loops to enhance performance and reduce branching

float seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    float segd = dot(p - proj, p - proj);
    d = min(d, segd);

    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allCond = c0 * c1 * c2;
    float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    float flip = mix(1.0, -1.0, step(0.5, allCond + noneCond));
    s *= flip;
    return d;
}

float getSdfParallelogram(in vec2 p, in vec2 v0, in vec2 v1, in vec2 v2, in vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);

    d = seg(p, v0, v3, s, d);
    d = seg(p, v1, v0, s, d);
    d = seg(p, v2, v1, s, d);
    d = seg(p, v3, v2, s, d);

    return s * sqrt(d);
}

vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float antialising(float distance) {
    return 1. - smoothstep(0., normalize(vec2(2., 2.), 0.).x, distance);
}

float determineStartVertexFactor(vec2 a, vec2 b) {
    // Conditions using step
    float condition1 = step(b.x, a.x) * step(a.y, b.y); // a.x < b.x && a.y > b.y
    float condition2 = step(a.x, b.x) * step(b.y, a.y); // a.x > b.x && a.y < b.y

    // If neither condition is met, return 1 (else case)
    return 1.0 - max(condition1, condition2);
}

vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + (rectangle.z / 2.), rectangle.y - (rectangle.w / 2.));
}
float ease(float x) {
    return pow(1.0 - x, 3.0);
}

// Use this site to convert from HEX to vec4
// https://enchanted.games/app/colour-converter/
// const vec4 TRAIL_COLOR = vec4(1., 1., 0., 1.0); // yellow
// const vec4 TRAIL_COLOR = vec4(0.537, 0.706, 0.980, 1.0); // catppuccin blue
// const vec4 TRAIL_COLOR = vec4(0.914, 0.702, 0.992, 1.0); // light cursor
const vec4 TRAIL_COLOR = vec4(1.0, 0.2, 0.0, 1.0); // Legacy variable, not used directly anymore
const float OPACITY = 1.0;
const float DURATION = 0.08; // Restored to the snappy fast duration

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    vec2 vu = normalize(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);

    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 rawPreviousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));

    // SHORTEN THE TRAIL: Pull the previous cursor position much closer to the current cursor
    // 0.2 means the trail will only be 20% of the actual distance traveled.
    vec4 previousCursor = mix(currentCursor, rawPreviousCursor, 0.2);

    // Determine trail vertices (straight parallelogram)
    float vertexFactor = determineStartVertexFactor(currentCursor.xy, previousCursor.xy);
    float invertedVertexFactor = 1.0 - vertexFactor;

    vec2 v0 = vec2(currentCursor.x + currentCursor.z * vertexFactor, currentCursor.y - currentCursor.w);
    vec2 v1 = vec2(currentCursor.x + currentCursor.z * invertedVertexFactor, currentCursor.y);
    vec2 v2 = vec2(previousCursor.x + currentCursor.z * invertedVertexFactor, previousCursor.y);
    vec2 v3 = vec2(previousCursor.x + currentCursor.z * vertexFactor, previousCursor.y - previousCursor.w);

    float sdfCurrentCursor = getSdfRectangle(vu, currentCursor.xy - (currentCursor.zw * offsetFactor), currentCursor.zw * 0.5);
    float sdfTrail = getSdfParallelogram(vu, v0, v1, v2, v3);

    // Calculate projection of current pixel onto the motion path to create a gradient
    vec2 centerCC = getRectangleCenter(currentCursor);
    vec2 centerCP = getRectangleCenter(previousCursor);
    vec2 dir = centerCC - centerCP;
    float len2 = dot(dir, dir);
    float t = 1.0;
    if (len2 > 0.00001) {
        t = clamp(dot(vu - centerCP, dir) / len2, 0.0, 1.0);
    }
    
    // Delayed fadeout: Instead of immediately dimming linearly, it stays near 100% opaque 
    // for most of the duration, then sharply drops to 0 at the very end.
    float progress = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    float currentOpacity = (1.0 - pow(progress, 4.0)) * OPACITY;

    // Catppuccin Green Theme
    vec4 c_head  = vec4(0.651, 0.890, 0.631, 1.0); // Green (#a6e3a1)
    vec4 c_mid   = vec4(0.651, 0.890, 0.631, 1.0); // Green (#a6e3a1)
    vec4 c_tail  = vec4(0.651, 0.890, 0.631, 1.0); // Green (#a6e3a1)
    vec4 c_spark = vec4(0.937, 0.894, 0.961, 1.0); // Text / Spark

    // Electric Spark Effect (Lowered frequency for smoother, wider flowing arcs)
    float spark = pow(max(0.0, sin(t * 20.0 - iTime * 60.0) * cos(t * 30.0 + iTime * 50.0)), 2.0);

    // Flowing gradient: Tail -> Mid -> Head (prevents color banding/blockiness)
    vec4 trailColor = mix(mix(c_tail, c_mid, clamp(t * 2.0, 0.0, 1.0)), c_head, clamp((t - 0.5) * 2.0, 0.0, 1.0));
    
    // Add smooth electrical arcs on top
    trailColor = mix(trailColor, c_spark, spark * 0.5); 
    
    // Spatial fade: Removed the '* t' multiplication here so the trail is SOLID instead of mostly transparent at the tail
    float trailAlpha = antialising(sdfTrail) * currentOpacity;

    // Cursor head starts hot and cools down to the tail color over time
    vec4 headColor = mix(c_head, c_tail, progress);
    float headAlpha = antialising(sdfCurrentCursor) * currentOpacity;

    // Smoothly mix everything
    vec4 newColor = vec4(fragColor);
    newColor = mix(newColor, trailColor, trailAlpha); // Draw the gradient comet trail
    newColor = mix(newColor, headColor, headAlpha);   // Draw the head on top

    fragColor = newColor;
}

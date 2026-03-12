; extends

; C++20 module support
"import" @keyword.import
"export" @keyword.import
"module" @keyword.import

(module_name
  (identifier) @module)

(import_declaration
  (module_name) @module)

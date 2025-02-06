; Identifier

(type_identifier) @type
(lowercase_identifier) @property

; Assume all-caps names are constants
((uppercase_identifier) @constant
 (#match? @constant "^[A-Z][A-Z\\d_]+$'"))

; Function

(function_identifier (lowercase_identifier) @function)
(apply_expression
  method: (simple_expression
    (qualified_identifier
      (lowercase_identifier) @function.method)))
(constructor_expression (uppercase_identifier) @constructor)

; Comments

(comment) @comment
(docstring) @comment.documentation


(qualified_identifier
  ; (package_identifier) @a
  (dot_identifier (inner_dot_identifier) @attribute))

(type_parameters) @variable.parameter
(parameters) @variable.parameter

[
  (boolean_literal)
  (float_literal)
  (integer_literal)
] @constant.builtin

[
  (byte_literal)
  (char_literal)
  (string_literal)
  (multiline_string_literal)
] @string

[
  ";"
  ","
  "=>"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
 (visibility)
 "let"
 (mutability)
 "type"
 "struct"
 "fn"
 "break"
 "continue"
 "if"
 "else"
 "while"
 "loop"
 "for"
 "as"
 "impl"
 "trait"
 "test"
] @keyword

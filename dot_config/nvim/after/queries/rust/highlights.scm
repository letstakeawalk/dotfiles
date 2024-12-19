;; extends

([
  (unit_expression)
  (unit_type)
 ]
 @unit
 (#set! priority 130)
) 

([
  (raw_string_literal)
  (string_literal)
 ] 
 @string
 (#set! priority 50)
)

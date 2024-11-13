CLASS zcl_reverse_string DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_reverse_string IMPLEMENTATION.

  METHOD reverse_string.

    DATA(input_length) = strlen( input ).

    DO input_length TIMES.

      DATA(offset) = input_length - sy-index.
      DATA(letters_iterator) = input+offset(1).
      result = |{ result }{ letters_iterator }|.

    ENDDO.

    "Or
    "result = reverse( input ).

  ENDMETHOD.

ENDCLASS.


CLASS zcl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_two_fer IMPLEMENTATION.

  METHOD two_fer.

    DATA(variable) = COND string( WHEN input IS INITIAL THEN 'you' ELSE input ).

    result = |{ 'One for' } { variable }, { 'one for me.' }|.

  ENDMETHOD.

ENDCLASS.


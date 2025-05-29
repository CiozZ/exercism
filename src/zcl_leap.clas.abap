CLASS zcl_leap DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS leap
      IMPORTING
        year          TYPE i
      RETURNING
        VALUE(result) TYPE abap_bool.
ENDCLASS.

CLASS zcl_leap IMPLEMENTATION.

  METHOD leap.

    result = COND #( WHEN year MOD 4 = 0 AND ( year MOD 100 <> 0 OR year MOD 400 = 0 )
                     THEN abap_true
                     ELSE abap_false
                    ).

  ENDMETHOD.

ENDCLASS.


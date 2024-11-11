CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.

  METHOD score.

    DO strlen( input ) TIMES.

      DATA(offset) = sy-index - 1.

      DATA(letter_to_assess) = input+offset(1).

      DATA(letter_score) = COND #(
                            WHEN letter_to_assess CA 'AEIOULNRSTaeioulnrst'  THEN 1
                            WHEN letter_to_assess CA 'DGdg'                  THEN 2
                            WHEN letter_to_assess CA 'BCMPbcmp'              THEN 3
                            WHEN letter_to_assess CA 'FHVWYfhvwy'            THEN 4
                            WHEN letter_to_assess CA 'Kk'                    THEN 5
                            WHEN letter_to_assess CA 'JXjx'                  THEN 8
                            WHEN letter_to_assess CA 'QZqz'                  THEN 10
                            ELSE 0
       ).

      result = result + letter_score.

    ENDDO.

*    result = count( val = input regex = '[aeioulnrst]' case = abap_false ) * 1 +
*                 count( val = input regex = '[dg]' case = abap_false ) * 2 +
*                 count( val = input regex = '[bcmp]' case = abap_false ) * 3 +
*                 count( val = input regex = '[fhvwy]' case = abap_false ) * 4 +
*                 count( val = input regex = '[k]' case = abap_false ) * 5 +
*                 count( val = input regex = '[jx]' case = abap_false ) * 8 +
*                 count( val = input regex = '[qz]' case = abap_false ) * 10.

*result =
*  REDUCE string( INIT s = 0
*                 FOR  i = 0 WHILE i < strlen( input )
*                 NEXT s += COND i( LET current_val = to_upper( input+i(1) ) IN
*                 WHEN contains( val = 'AEIOULNRST' sub = current_val ) THEN 1
*                 WHEN contains( val = 'DG' sub = current_val ) THEN 2
*                 WHEN contains( val = 'BCMP' sub = current_val ) THEN 3
*                 WHEN contains( val = 'FHVWY' sub = current_val ) THEN 4
*                 WHEN contains( val = 'K' sub = current_val ) THEN 5
*                 WHEN contains( val = 'JX' sub = current_val ) THEN 8
*                 WHEN contains( val = 'QZ' sub = current_val ) THEN 10
*                 ELSE 0
*                 ) ).

  ENDMETHOD.

ENDCLASS.


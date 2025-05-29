CLASS zcl_atbash_cipher DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    CONSTANTS mc_plain  TYPE string VALUE 'abcdefghijklmnopqrstuvwxyz'.
    CONSTANTS mc_cipher TYPE string VALUE 'zyxwvutsrqponmlkjihgfedcba'.

    METHODS decode
      IMPORTING
        cipher_text       TYPE string
      RETURNING
        VALUE(plain_text) TYPE string .

    METHODS encode
      IMPORTING
        plain_text         TYPE string
      RETURNING
        VALUE(cipher_text) TYPE string .


  PRIVATE SECTION.
    METHODS determine_letter_position
      IMPORTING letter        TYPE string
                search_here   TYPE string
      RETURNING VALUE(result) TYPE i.

    METHODS determine_letter
      IMPORTING
        position      TYPE i
        search_here   TYPE string
      RETURNING
        VALUE(result) TYPE string.

ENDCLASS.

CLASS zcl_atbash_cipher IMPLEMENTATION.

  METHOD decode.

    DATA(string_length) = strlen( cipher_text ).

    DO string_length TIMES.

      DATA(letter_iterator) = substring( val = cipher_text off = sy-index - 1 len = 1 ).

      IF  letter_iterator CA '1234567890'.
        DATA(plain_letter) = letter_iterator.
      ELSE.
        DATA(position) = determine_letter_position( letter = letter_iterator search_here = mc_cipher ).
        plain_letter = determine_letter( position = position search_here = mc_plain ).
      ENDIF.

      plain_text = |{ plain_text }{ plain_letter }|.

    ENDDO.

  ENDMETHOD.

  METHOD encode.

    DATA(condensed_plain_text) = plain_text.

    REPLACE ALL OCCURRENCES OF REGEX '[^a-zA-Z0-9]' IN condensed_plain_text WITH ''.
    CONDENSE condensed_plain_text NO-GAPS.

    DATA(string_length) = strlen( condensed_plain_text ).

    DATA(encoded_counter) = 0.

    DO string_length TIMES.

      DATA(letter_iterator) = substring( val = condensed_plain_text off = sy-index - 1 len = 1 ).

      IF  letter_iterator CA '1234567890'.
        DATA(cipher_letter) = letter_iterator.
      ELSE.
        DATA(position) = determine_letter_position( letter = to_lower( letter_iterator ) search_here = mc_plain ).
        cipher_letter = determine_letter( position = position search_here = mc_cipher ).
      ENDIF.

      cipher_text = |{ cipher_text }{ cipher_letter }|.
      encoded_counter += 1.

      IF encoded_counter = 5.
        cipher_text = |{ cipher_text }{ ` ` }|.
        CLEAR encoded_counter.
      ENDIF.

    ENDDO.

    SHIFT cipher_text RIGHT DELETING TRAILING space.
    SHIFT cipher_text LEFT DELETING LEADING space.

  ENDMETHOD.

  METHOD determine_letter_position.

    result = find( val = search_here sub = letter off = result ).
    result += 1.

  ENDMETHOD.

  METHOD determine_letter.

    DO position TIMES.
      result = substring( val = search_here off = sy-index - 1 len = 1 ).
    ENDDO.

  ENDMETHOD.

ENDCLASS.


CLASS zcl_resistor_color DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string
      RETURNING
        VALUE(value) TYPE i.
ENDCLASS.

CLASS zcl_resistor_color IMPLEMENTATION.

  METHOD resistor_color.

    value = SWITCH i( color_code

    WHEN 'black' THEN 0
    WHEN 'brown' THEN 1
    WHEN 'red' THEN 2
    WHEN 'orange' THEN 3
    WHEN 'yellow' THEN 4
    WHEN 'green' THEN 5
    WHEN 'blue' THEN 6
    WHEN 'violet' THEN 7
    WHEN 'grey' THEN 8
    WHEN 'white' THEN 9

     ).


  ENDMETHOD.

ENDCLASS.


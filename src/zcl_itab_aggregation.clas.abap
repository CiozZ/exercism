CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.

  PRIVATE SECTION.

    METHODS compute_count
      IMPORTING initial_numbers TYPE initial_numbers
                group           TYPE csequence
      RETURNING VALUE(result)   TYPE i.

    METHODS compute_sum
      IMPORTING initial_numbers TYPE initial_numbers
                group           TYPE csequence
      RETURNING VALUE(result)   TYPE i.

    METHODS compute_minimum
      IMPORTING initial_numbers TYPE initial_numbers
                group           TYPE csequence
      RETURNING VALUE(result)   TYPE i.

    METHODS compute_maximum
      IMPORTING initial_numbers TYPE initial_numbers
                group           TYPE csequence
      RETURNING VALUE(result)   TYPE i.

ENDCLASS.

CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.

    LOOP AT initial_numbers REFERENCE INTO DATA(initial_number)
       GROUP BY ( key = initial_number->group  count = GROUP SIZE )
       ASCENDING
       REFERENCE INTO DATA(group_key).

      DATA(count) = compute_count( initial_numbers = initial_numbers group = group_key->key ).
      DATA(sum) = compute_sum( initial_numbers = initial_numbers group = group_key->key ).
      DATA(min) = compute_minimum( initial_numbers = initial_numbers group = group_key->key ).
      DATA(max) = compute_maximum( initial_numbers = initial_numbers group = group_key->key ).
      DATA(avg) = VALUE f( ).
      avg = sum / count.

      APPEND VALUE aggregated_data_type(
                      group = group_key->key
                      count = count
                      sum = sum
                      min = min
                      max = max
                      average = avg ) TO aggregated_data.

    ENDLOOP.

  ENDMETHOD.

  METHOD compute_count.
    result = REDUCE #( INIT counter = 0
                       FOR line IN initial_numbers
                       WHERE ( group = group )
                       NEXT counter = counter + 1 ).
  ENDMETHOD.

  METHOD compute_sum.
    result = REDUCE #( INIT summer = 0 FOR line IN initial_numbers
                                       WHERE ( group = group )
                                       NEXT summer = summer + line-number ).
  ENDMETHOD.

  METHOD compute_minimum.
    result = REDUCE #( INIT minimum = initial_numbers[ group = group ]-number
                             FOR line IN initial_numbers
                             WHERE ( group = group )
                             NEXT minimum = COND #( WHEN minimum > line-number
                                                    THEN line-number ELSE minimum ) ).
  ENDMETHOD.

  METHOD compute_maximum.
    result = REDUCE #( INIT maximum = initial_numbers[ group = group ]-number
                             FOR line IN initial_numbers
                             WHERE ( group = group )
                             NEXT maximum = COND #( WHEN maximum < line-number
                             THEN line-number ELSE maximum ) ).
  ENDMETHOD.

ENDCLASS.


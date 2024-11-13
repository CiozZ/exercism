CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    result = me->scores_list.
  ENDMETHOD.

  METHOD latest.
    result = VALUE #( me->scores_list[ lines( me->scores_list ) ] DEFAULT 0 ).
  ENDMETHOD.

  METHOD personalbest.
    result = REDUCE #( INIT best = 0 FOR scores_iterator IN me->scores_list
                       NEXT best = COND #( WHEN scores_iterator > best
                                           THEN scores_iterator
                                           ELSE best ) ).
  ENDMETHOD.

  METHOD personaltopthree.
    SORT me->scores_list BY table_line DESCENDING.

    result = VALUE #( FOR score_iterator IN me->scores_list
                      FROM 1 TO 3 ( score_iterator ) ).

  ENDMETHOD.

ENDCLASS.


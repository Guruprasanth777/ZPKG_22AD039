CLASS zcl_gaming_tournament_22ad039 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.

    TYPES: BEGIN OF ty_player,
             player_id TYPE i,
             username  TYPE string,
             score     TYPE i,
           END OF ty_player.

    DATA gt_players TYPE STANDARD TABLE OF ty_player.

    METHODS add_player
      IMPORTING
        iv_id    TYPE i
        iv_name  TYPE string
        iv_score TYPE i.

    METHODS display_leaderboard
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS zcl_gaming_tournament_22ad039 IMPLEMENTATION.

  METHOD add_player.

    DATA(ls_player) = VALUE ty_player(
        player_id = iv_id
        username  = iv_name
        score     = iv_score ).

    APPEND ls_player TO gt_players.

  ENDMETHOD.



  METHOD display_leaderboard.

    SORT gt_players BY score DESCENDING.

    out->write( '--- Tournament Leaderboard ---' ).

    LOOP AT gt_players INTO DATA(ls_player).

      DATA(rank) = sy-tabix.

      DATA(result) =
      |Rank { rank } { ls_player-username } { ls_player-score }|.

      IF ls_player-score > 120.
        result = result && ' Elite'.
      ELSEIF ls_player-score > 80.
        result = result && ' Pro'.
      ELSE.
        result = result && ' Beginner'.
      ENDIF.

      out->write( result ).

    ENDLOOP.

  ENDMETHOD.



  METHOD if_oo_adt_classrun~main.

  add_player(
    iv_id = 1
    iv_name = 'ShadowNinja'
    iv_score = 130 ).

  add_player(
    iv_id = 2
    iv_name = 'PixelWarrior'
    iv_score = 90 ).

  add_player(
    iv_id = 3
    iv_name = 'DragonSlayer'
    iv_score = 150 ).

  add_player(
    iv_id = 4
    iv_name = 'CyberKnight'
    iv_score = 70 ).

  display_leaderboard( out ).

ENDMETHOD.

ENDCLASS.

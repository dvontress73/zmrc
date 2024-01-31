CLASS lhc_zz_r1_mrcbuild DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zz_r1_mrcbuild RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zz_r1_mrcbuild RESULT result.

    METHODS relateMRC FOR MODIFY
      IMPORTING keys FOR ACTION zz_r1_mrcbuild~relateMRC RESULT result.

ENDCLASS.

CLASS lhc_zz_r1_mrcbuild IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD relateMRC.
    IF 0 = 0.

    ENDIF.



*    READ ENTITIES OF ZZ_R_ReplyTable IN LOCAL MODE
*    ENTITY ZZ_R_ReplyTable
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(replytables).
*
*    result = VALUE #( FOR replytable IN replytables
*                        ( %tky = replytable-%tky
*                          %param = '' )
*                    ).

  ENDMETHOD.

ENDCLASS.

CLASS lhc_zz_r_replycode DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE ZZ_R_ReplyCode.

ENDCLASS.

CLASS lhc_zz_r_replycode IMPLEMENTATION.

  METHOD precheck_update.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZZ_R_ReplyTable DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZZ_R_ReplyTable RESULT result.


    METHODS assignMRC FOR MODIFY
      IMPORTING keys FOR ACTION ZZ_R_ReplyTable~assignMRC RESULT result.
    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE ZZ_R_ReplyTable.

    METHODS checkReplyTable FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZZ_R_ReplyTable~checkReplyTable.
    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE ZZ_R_ReplyTable.
    METHODS precheck_cba_Replycode FOR PRECHECK
      IMPORTING entities FOR CREATE ZZ_R_ReplyTable\_Replycode.
    METHODS createReplytable FOR MODIFY
      IMPORTING keys FOR ACTION ZZ_R_ReplyTable~createReplytable RESULT result.

ENDCLASS.

CLASS lhc_ZZ_R_ReplyTable IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.



  METHOD assignMRC.
    TYPES: BEGIN OF ty_params,
             "parameter type za_assign_mrc_popup,
             mrccode TYPE sysuuid_x16,
           END OF ty_params,
           t_params TYPE TABLE OF ty_params.

    DATA: update_build TYPE TABLE FOR UPDATE ZZ_R_ReplyTable,
          lt_params    TYPE t_params.

    DATA(lt_keys) = keys.


    CHECK lt_keys IS NOT INITIAL.

    TRY.
        DATA(ls_keys) = keys[ 1 ].
      CATCH cx_sy_itab_line_not_found.
        RETURN.
    ENDTRY.

    APPEND VALUE #( mrccode = ls_keys-%param-mrcCode ) TO lt_params.

    READ ENTITIES OF ZZ_R_ReplyTable IN LOCAL MODE
    ENTITY ZZ_R_ReplyTable
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(replytables).

    CHECK replytables IS NOT INITIAL.

    LOOP AT replytables INTO DATA(replytable).

*      "ready build entity ...
      READ ENTITIES OF ZZ_R_ReplyTable IN LOCAL MODE
          ENTITY ZZ_R_ReplyTable BY \_mrc_build
          FIELDS ( ReplyTableUUID MRCBuildUUID mrcuuid )
          WITH VALUE #( ( %tky = replytable-%tky ) )
          RESULT DATA(r_mrc_build).

      IF r_mrc_build IS NOT INITIAL.
        LOOP AT r_mrc_build ASSIGNING FIELD-SYMBOL(<fs_build>).
          <fs_build>-mrcuuid = ls_keys-%param-mrcCode.

        ENDLOOP.
      ELSE.
        APPEND VALUE #( mrcuuid = ls_keys-%param-mrcCode ) TO r_mrc_build.
      ENDIF.

      "modify build entity
      MODIFY ENTITIES OF ZZ_R_ReplyTable IN LOCAL MODE
          ENTITY zz_r1_mrcbuild
          UPDATE FIELDS ( mrcuuid )
          WITH CORRESPONDING #( r_mrc_build ).

      "result = value #( for <fs_test> in r_mrc_build (  ) )
    ENDLOOP.


  ENDMETHOD.

  METHOD precheck_create.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).
      CHECK <fs_entity>-%control-ReplyTable EQ '01'.


      SELECT SINGLE @abap_true
          FROM  zzreplytable
          WHERE replytable = @<fs_entity>-ReplyTable
          INTO @DATA(exists).
      IF sy-subrc EQ 0.
        APPEND VALUE #( %key = <fs_entity>-%key ) TO failed-replytable.
        APPEND VALUE #( %key = <fs_entity>-%key
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = |Reply Table '| & |{ <fs_entity>-ReplyTable }| & |' Exists, Please use new Reply Table|
                        )
                       ) TO reported-replytable.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD checkReplyTable.
  ENDMETHOD.

  METHOD precheck_update.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

    ENDLOOP.
  ENDMETHOD.

  METHOD precheck_cba_Replycode.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).
      IF <fs_entity>-%is_draft EQ '01'.
        SELECT  SINGLE FROM zzreplytabled FIELDS replycodesize
           WHERE replytableuuid = @<fs_entity>-ReplyTableUUID
           INTO @DATA(ls_replyCodeSize).
        IF sy-subrc EQ 0.
          LOOP AT <fs_entity>-%target ASSIGNING FIELD-SYMBOL(<fs_target>).
            IF strlen( <fs_target>-ReplyCode ) NE ls_replycodesize.
              APPEND VALUE #( %key = <fs_target>-%key ) TO failed-replycode.
              APPEND VALUE #( %key = <fs_target>-%key
                            %msg = new_message_with_text(
                            severity = if_abap_behv_message=>severity-error
                            text = |Reply Code must be '| & |{ ls_replycodesize }| & |' length|
                            )
                           ) TO reported-replycode.

            ENDIF.
          ENDLOOP.
*    IF STRLEN( <fs_entity>-%targ )
*   APPEND VALUE #( %key = <fs_entity>-%key ) TO failed-zz_r_replytable.
*   APPEND VALUE #( %key = <fs_entity>-%key
*                   %msg = new_message_with_text(
*                   severity = if_abap_behv_message=>severity-error
*                   text = |Reply Table '| & |{ <fs_entity>-ReplyTable }| & |' Exists, Please use new Reply Table|
*                   )
*                  ) TO reported-zz_r_replytable.

        ENDIF.


      ELSE.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD createReplytable.
    DATA create_replytable TYPE TABLE FOR CREATE ZZ_R_ReplyTable.
    DATA: create_replytable_line TYPE STRUCTURE FOR CREATE ZZ_R_ReplyTable.

    "Check if replytable already exists
    LOOP AT keys INTO DATA(ls_key).
      SELECT SINGLE @abap_true
          FROM zzreplytable
          WHERE replytable = @ls_key-%param-ReplyTable
          INTO @DATA(exists).


      IF exists = abap_true. "Send message to UI
        APPEND VALUE #( replytableuuid = ls_key-%param-ReplyTable ) TO failed-replytable.
        APPEND VALUE #( replytableuuid = ls_key-%param-ReplyTable
                        %msg = new_message_with_text(
                            severity = if_abap_behv_message=>severity-error
                            text = |Reply Table '| & |{ ls_key-%param-ReplyTable } | & |' Already Exists|
                         )
                      ) TO reported-replytable.
        RETURN.
      ENDIF.

      "All is good, let try to create the reply table record
      create_replytable_line = VALUE #(   %is_draft = if_abap_behv=>mk-on
                                          %cid = ls_key-%cid
                                          ReplyTable = ls_key-%param-ReplyTable
                                          Description = ls_key-%param-Description
                                          ISACRelevant = ls_key-%param-isac
                                          IsTemporary = ls_key-%param-IsTemporary
                                          ReplyCodeSize = ls_key-%param-ReplyCodeSize
                                       ).
      APPEND create_replytable_line TO create_replytable.

    ENDLOOP.

    "Update the replytable entity and display on UI
    MODIFY ENTITIES OF ZZ_R_ReplyTable IN LOCAL MODE
     ENTITY Replytable
     CREATE FIELDS ( ReplyTable Description ISACRelevant IsTemporary ReplyCodeSize )
     WITH create_replytable
     MAPPED mapped
     FAILED failed
     REPORTED reported.

    CHECK mapped-replytable IS NOT INITIAL.

    LOOP AT mapped-replytable INTO DATA(mapped_reply).
      APPEND VALUE #(
                      %cid = ls_key-%cid
                      %param = VALUE #( %is_draft = mapped_reply-%is_draft
                                        %key = mapped_reply-%key
                                      )
                    ) TO result.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZZ_R_REPLYTABLE DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZZ_R_REPLYTABLE IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

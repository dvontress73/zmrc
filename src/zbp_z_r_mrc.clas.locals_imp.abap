CLASS lhc_ZZ_R_MRC DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR mrc RESULT result.
    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE mrc.

    METHODS validatemrccode FOR VALIDATE ON SAVE
      IMPORTING keys FOR mrc~validatemrccode.
    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE mrc.
    METHODS createmrc FOR MODIFY
      IMPORTING keys FOR ACTION mrc~createmrc RESULT result.

ENDCLASS.

CLASS lhc_ZZ_R_MRC IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD precheck_create.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).
      CHECK <fs_entity>-%control-MRCCode EQ '01'.


      SELECT SINGLE @abap_true
          FROM  zzmrc
          WHERE mrc_code = @<fs_entity>-MRCCode
          INTO @DATA(exists).
      IF sy-subrc EQ 0.
        APPEND VALUE #( %key = <fs_entity>-%key ) TO failed-mrc.
        APPEND VALUE #( %key = <fs_entity>-%key
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = |MRC Code '| & |{ <fs_entity>-MRCCode }| & |' Exists, Please use new MRC Code|
                        )
                       ) TO reported-mrc.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateMRCCode.
  ENDMETHOD.

  METHOD precheck_update.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).
      CHECK <fs_entity>-%control-MRCCode EQ '01'.


      SELECT SINGLE @abap_true
          FROM  zzmrc
          WHERE mrc_code = @<fs_entity>-MRCCode
          INTO @DATA(exists).
      IF sy-subrc EQ 0.
        APPEND VALUE #( %key = <fs_entity>-%key ) TO failed-mrc.
        APPEND VALUE #( %key = <fs_entity>-%key
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = |MRC Code '| & |{ <fs_entity>-MRCCode }| & |' Exists, Please use new MRC Code|
                        )
                       ) TO reported-mrc.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD createMRC.
    DATA create_mrc TYPE TABLE FOR CREATE zz_r_mrc.
    DATA create_mrc_line TYPE STRUCTURE FOR CREATE zz_r_mrc.

    LOOP AT keys INTO DATA(ls_key).
      "check for existing MRC...
      SELECT SINGLE @abap_true
        FROM zzmrc
        WHERE  mrc_code = @ls_key-%param-MRCCode
        INTO @DATA(exists).

      IF exists = abap_true. "MRC exist, so send error msg
        APPEND VALUE #( mrcuuid = ls_key-%param-MRCCode  ) TO failed-mrc.
        APPEND VALUE #( mrcuuid = ls_key-%param-MRCCode
                        %msg = new_message_with_text(
                            severity = if_abap_behv_message=>severity-error
                            text = |MRC Code '| & |{ ls_key-%param-MRCCode }| & |' Already exists|
                            )
                         ) TO reported-mrc.
        RETURN.

      ENDIF.

      create_mrc_line = VALUE #(
                                  %is_draft = if_abap_behv=>mk-on
                                  %cid = ls_key-%cid
                                  MRCCode = ls_key-%param-MRCCode
                                  Description = ls_key-%param-Description
                                  LongDescription = ls_key-%param-LongDescription
                                  ModeCode = ls_key-%param-ModeCode
                                  FFFRelated = ls_key-%param-FFFRelated
                                  MultipleIterations = ls_key-%param-MultipleIterations
                                  IsTemporary = ls_key-%param-IsTemporary
                                ).
      APPEND create_mrc_line TO create_mrc.

    ENDLOOP.

    "update the entity
    MODIFY ENTITIES OF zz_r_mrc IN LOCAL MODE
        ENTITY mrc
        CREATE FIELDS ( MRCCode Description LongDescription FFFRelated IsTemporary ModeCode MultipleIterations )
        WITH create_mrc
        MAPPED mapped
        FAILED failed
        REPORTED reported.

    CHECK mapped-mrc IS NOT INITIAL.

    LOOP AT mapped-mrc INTO DATA(mapped_mrcs).
      APPEND VALUE #( %cid = ls_key-%cid
                      %param = VALUE #(
                          %is_draft = mapped_mrcs-%is_draft
                          %key = mapped_mrcs-%key
                       ) ) TO result.
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.

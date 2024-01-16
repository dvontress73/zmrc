CLASS lhc_ZZ_R_MRC DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zz_r_mrc RESULT result.
    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE zz_r_mrc.

    METHODS validatemrccode FOR VALIDATE ON SAVE
      IMPORTING keys FOR zz_r_mrc~validatemrccode.

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
   APPEND VALUE #( %key = <fs_entity>-%key ) TO failed-zz_r_mrc.
   APPEND VALUE #( %key = <fs_entity>-%key
                   %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text = |MRC Code '| & |{ <fs_entity>-MRCCode }| & |' Exists, Please use new MRC Code|
                   )
                  ) TO reported-zz_r_mrc.

   ENDIF.

  ENDLOOP.
  ENDMETHOD.

  METHOD validateMRCCode.
  ENDMETHOD.

ENDCLASS.

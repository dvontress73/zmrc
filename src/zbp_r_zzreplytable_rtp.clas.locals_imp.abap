CLASS lhc_zzreplytable_r DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR zzreplytable_r
        RESULT result,
      calculatereplytable FOR DETERMINE ON SAVE
        IMPORTING
          keys FOR  zzreplytable_r~CalculateReplytable .
ENDCLASS.

CLASS lhc_zzreplytable_r IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD calculatereplytable.
    READ ENTITIES OF zr_zzreplytable_rtp IN LOCAL MODE
      ENTITY zzreplytable_r
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(entities).
    DELETE entities WHERE Replytable IS NOT INITIAL.
    CHECK entities IS NOT INITIAL.
    "Dummy logic to determine object_id
    SELECT MAX( replytable ) FROM zzreplytable INTO @DATA(max_object_id).
    "Add support for draft if used in modify
    "SELECT SINGLE FROM FROM ZZZREPLYTABLE00D FIELDS MAX( Replytable ) INTO @DATA(max_orderid_draft). "draft table
    "if max_orderid_draft > max_object_id
    " max_object_id = max_orderid_draft.
    "ENDIF.
    MODIFY ENTITIES OF zr_zzreplytable_rtp IN LOCAL MODE
      ENTITY zzreplytable_r
        UPDATE FIELDS ( Replytable )
          WITH VALUE #( FOR entity IN entities INDEX INTO i (
          %tky          = entity-%tky
          Replytable     = max_object_id + i
    ) ).
  ENDMETHOD.
ENDCLASS.

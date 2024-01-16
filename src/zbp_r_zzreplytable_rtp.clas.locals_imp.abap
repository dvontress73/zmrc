CLASS LHC_ZZREPLYTABLE_R DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZZREPLYTABLE_R
        RESULT result,
      CALCULATEREPLYTABLE FOR DETERMINE ON SAVE
        IMPORTING
          KEYS FOR  ZZREPLYTABLE_R~CalculateReplytable .
ENDCLASS.

CLASS LHC_ZZREPLYTABLE_R IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD CALCULATEREPLYTABLE.
  READ ENTITIES OF ZR_ZZREPLYTABLE_RTP IN LOCAL MODE
    ENTITY ZZREPLYTABLE_R
      ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(entities).
  DELETE entities WHERE Replytable IS NOT INITIAL.
  Check entities is not initial.
  "Dummy logic to determine object_id
  SELECT MAX( REPLYTABLE ) FROM ZZREPLYTABLE INTO @DATA(max_object_id).
  "Add support for draft if used in modify
  "SELECT SINGLE FROM FROM ZZZREPLYTABLE00D FIELDS MAX( Replytable ) INTO @DATA(max_orderid_draft). "draft table
  "if max_orderid_draft > max_object_id
  " max_object_id = max_orderid_draft.
  "ENDIF.
  MODIFY ENTITIES OF ZR_ZZREPLYTABLE_RTP IN LOCAL MODE
    ENTITY ZZREPLYTABLE_R
      UPDATE FIELDS ( Replytable )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
        %tky          = entity-%tky
        Replytable     = max_object_id + i
  ) ).
  ENDMETHOD.
ENDCLASS.

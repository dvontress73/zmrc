CLASS zcl_generate_reply_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_replytable TYPE STANDARD TABLE OF zzreplytable WITH KEY replytable_uuid,
           ty_replycode  TYPE STANDARD TABLE OF zzreplycode WITH KEY reply_code_uuid,
           ty_mrc_header TYPE STANDARD TABLE OF zzmrc WITH KEY mrc_uuid.

    INTERFACES if_oo_adt_classrun.

    METHODS:
      generate_data.  "Not needed right now

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: t_replytable TYPE ty_replytable,
          t_replycode  TYPE ty_replycode,
          t_mrc_header TYPE ty_mrc_header.

    METHODS:
      fill_mrc_table,
      fill_replytable,
      fill_replycode
        IMPORTING
          replytable_data       TYPE ty_replytable.
        "RETURNING
        "  VALUE(replycode_data) TYPE ty_replycode.
ENDCLASS.



CLASS zcl_generate_reply_table IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
   "clear the data
    DELETE FROM zzmrc.
    DELETE FROM zzreplytable.
    DELETE FROM zzreplycode.

    fill_replytable(  ).
    INSERT zzreplytable FROM TABLE @t_replytable.
    COMMIT WORK.
    out->write( |Replytable data created| ).

    fill_replycode( t_replytable ).
    INSERT zzreplycode FROM TABLE @t_replycode.
    COMMIT WORK.
    out->write( |Replycode data created| ).

    fill_mrc_table(  ).
    INSERT zzmrc FROM TABLE @t_mrc_header.
    COMMIT WORK.
    out->write( |MRC Header data created!| ).
  ENDMETHOD.

  METHOD fill_mrc_table.
    GET TIME STAMP FIELD DATA(ts).

    DATA(timestamp) = ts.

    APPEND VALUE #( client = sy-mandt
                    mrc_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  )
                    mrc_code = 'MATT'
                    description = 'Material'
                    long_description = 'The Chemical compound or mechanical...'
                    multiple_iterations = 'X'
                    fff_related = 'X'
                    mode_code = ''
                    is_temporary = ''
                    created_by = sy-uname
                    created_at = timestamp
                    last_changed_by = sy-uname
                    last_changed_at = timestamp
                    local_last_changed = timestamp ) TO t_mrc_header.

    APPEND VALUE #( client = sy-mandt
                            mrc_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  )
                            mrc_code = 'BGTB'
                            description = 'Storage Facility'
                            long_description = 'The storage facility standards...'
                            multiple_iterations = 'X'
                            fff_related = ''
                            mode_code = ''
                            is_temporary = ''
                            created_by = sy-uname
                            created_at = timestamp
                            last_changed_by = sy-uname
                            last_changed_at = timestamp
                            local_last_changed = timestamp ) TO t_mrc_header.

    APPEND VALUE #( client = sy-mandt
                            mrc_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  )
                            mrc_code = 'ALEQ'
                            description = 'Canopy Width'
                            long_description = 'A measurement taken...'
                            multiple_iterations = ''
                            fff_related = 'X'
                            mode_code = ''
                            is_temporary = ''
                            created_by = sy-uname
                            created_at = timestamp
                            last_changed_by = sy-uname
                            last_changed_at = timestamp
                            local_last_changed = timestamp ) TO t_mrc_header.


  ENDMETHOD.

  METHOD fill_replycode.
DATA(replytable_tab) = t_replytable.
    DATA wa_code TYPE zzreplycode.
    DATA: lv_uuid    TYPE sysuuid_x16.

    GET TIME STAMP FIELD DATA(ts).

    DATA(timestamp) = ts.

    "AN11 records...
    READ TABLE replytable_tab WITH KEY replytable = 'AN11' INTO DATA(replytab).

    IF sy-subrc = 0.
      "Add 2 records with the replytable
      wa_code-reply_table_uuid = replytab-replytable_uuid.
      wa_code-client = sy-mandt.
      wa_code-description = to_upper( 'Mandatory' ).
      wa_code-is_temporary = ''.
      wa_code-created_by = sy-uname.
      wa_code-created_at = timestamp.
      wa_code-last_changed_by = sy-uname.
      wa_code-last_changed_at = timestamp.
      wa_code-local_last_changed = timestamp.


      wa_code-reply_code = 'B'.
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      APPEND wa_code TO t_replycode.

      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = 'C'.
      wa_code-description = to_upper( 'preferred' ).
      APPEND wa_code TO t_replycode.

      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = 'D'.
      wa_code-description = to_upper( 'alternate' ).
      APPEND wa_code TO t_replycode.

    ENDIF.

    "AM81 records...
    CLEAR replytab.
    READ TABLE replytable_tab WITH KEY replytable = 'AM81' INTO replytab.

    IF sy-subrc = 0.
      "Add 4 records with the replytable
      "id = AY
      wa_code-reply_code = 'AY'.
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_table_uuid = replytab-replytable_uuid.
      wa_code-client = sy-mandt.
      wa_code-description = to_upper( 'General Purpose Heated Warehouse' ).
      wa_code-is_temporary = ''.
      wa_code-created_by = sy-uname.
      wa_code-created_at = timestamp.
      wa_code-last_changed_by = sy-uname.
      wa_code-last_changed_at = timestamp.
      wa_code-local_last_changed = timestamp.
      APPEND wa_code TO t_replycode.

      "ID = AX
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = 'AX'.
      wa_code-description = to_upper( 'Dock Level Unheated Warehouse' ).
      APPEND wa_code TO t_replycode.

      "ID = AT
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = 'AT'.
      wa_code-description = to_upper( 'Dock Level Headed Warehouse' ).
      APPEND wa_code TO t_replycode.

      "ID = AE
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = 'AE'.
      wa_code-description = to_upper( 'General Purpose Warehouse' ).
      APPEND wa_code TO t_replycode.

    ENDIF.

    "AN12 records...
    CLEAR replytab.
    READ TABLE replytable_tab WITH KEY replytable = 'AN12' INTO replytab.

    IF sy-subrc = 0.
      wa_code-reply_code = 'AF'.
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_table_uuid = replytab-replytable_uuid.
      wa_code-client = sy-mandt.
      wa_code-description = to_upper( 'Chill' ).
      wa_code-is_temporary = ''.
      wa_code-created_by = sy-uname.
      wa_code-created_at = timestamp.
      wa_code-last_changed_by = sy-uname.
      wa_code-last_changed_at = timestamp.
      wa_code-local_last_changed = timestamp.
      APPEND wa_code TO t_replycode.

      "ID = AJ
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = 'AJ'.
      wa_code-description = to_upper( 'Corrosion' ).
      APPEND wa_code TO t_replycode.

      "ID = AD
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = 'AD'.
      wa_code-description = to_upper( 'Flammable' ).
      APPEND wa_code TO t_replycode.

      "ID = AB
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = 'AB'.
      wa_code-description = to_upper( 'General Purpose' ).
      APPEND wa_code TO t_replycode.

    ENDIF.

    "0333 records...
    CLEAR replytab.
    READ TABLE replytable_tab WITH KEY replytable = '0333' INTO replytab.

    IF sy-subrc = 0.
      wa_code-reply_code = '3AAC'.
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_table_uuid = replytab-replytable_uuid.
      wa_code-client = sy-mandt.
      wa_code-description =  to_upper( 'Core Conductor First Conductor' ).
      wa_code-is_temporary = ''.
      wa_code-created_by = sy-uname.
      wa_code-created_at = timestamp.
      wa_code-last_changed_by = sy-uname.
      wa_code-last_changed_at = timestamp.
      wa_code-local_last_changed = timestamp.
      APPEND wa_code TO t_replycode.

      "ID = 3aad
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = '3AAD'.
      wa_code-description = to_upper( 'core conductor second conductor' ).
      APPEND wa_code TO t_replycode.


      "ID = xxx1
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = to_upper( 'xxx1' ).
      wa_code-description = to_upper( 'core conductor first conductor' ).
      APPEND wa_code TO t_replycode.

      "ID = xxx2
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = to_upper( 'xxx2' ).
      wa_code-description = to_upper( 'core conductor second conductor' ).
      APPEND wa_code TO t_replycode.

    ENDIF.

    "ma01 records...
    CLEAR replytab.
    READ TABLE replytable_tab WITH KEY replytable = 'MA01' INTO replytab.

    IF sy-subrc = 0.
      wa_code-reply_code = to_upper( 'ada000' ).
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_table_uuid = replytab-replytable_uuid.
      wa_code-client = sy-mandt.
      wa_code-description =  to_upper( 'adhesive' ).
      wa_code-is_temporary = ''.
      wa_code-created_by = sy-uname.
      wa_code-created_at = timestamp.
      wa_code-last_changed_by = sy-uname.
      wa_code-last_changed_at = timestamp.
      wa_code-local_last_changed = timestamp.
      APPEND wa_code TO t_replycode.

      "ID = ala000
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = to_upper( 'ala000' ).
      wa_code-description = to_upper( 'aluminum' ).
      APPEND wa_code TO t_replycode.

       "ID = alb000
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = to_upper( 'alb000' ).
      wa_code-description = to_upper( 'aluminum alloy' ).
      APPEND wa_code TO t_replycode.

       "ID = AL1350
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = to_upper( 'al1350' ).
      wa_code-description = to_upper( 'aluminum alloy 1350' ).
      APPEND wa_code TO t_replycode.

      "ID = stl000
      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = to_upper( 'stl000' ).
      wa_code-description = to_upper( 'steel' ).
      APPEND wa_code TO t_replycode.

      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = to_upper( 'stl301' ).
      wa_code-description = to_upper( 'steel comp 301' ).
      APPEND wa_code TO t_replycode.

      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = to_upper( 'stl302' ).
      wa_code-description = to_upper( 'steel comp 302' ).
      APPEND wa_code TO t_replycode.

      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = to_upper( 'stl304' ).
      wa_code-description = to_upper( 'steel comp 304' ).
      APPEND wa_code TO t_replycode.

      wa_code-reply_code_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  ).
      wa_code-reply_code = to_upper( 'stl316' ).
      wa_code-description = to_upper( 'steel comp 316' ).
      APPEND wa_code TO t_replycode.

      endif.
  ENDMETHOD.

  METHOD fill_replytable.
    GET TIME STAMP FIELD DATA(ts).

    DATA(timestamp) = ts.

    APPEND VALUE #( client = '200'
                    replytable_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  )
                    replytable = 'AN11'
                    replycodesize = ''
                    isac = ''
                    description = 'Type Storage'
                    istemporary = ''
                    created_by = sy-uname
                    created_at = timestamp
                    last_changed_by = sy-uname
                    last_changed_at = timestamp
                    local_last_changed = timestamp ) TO t_replytable.
    APPEND VALUE #( client = '200'
                    replytable_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  )
                    replytable = 'AM81'
                    replycodesize = 2
                    isac = ''
                    description = 'Storage Location'
                    istemporary = ''
                    created_by = sy-uname
                    created_at = timestamp
                    last_changed_by = sy-uname
                    last_changed_at = timestamp
                    local_last_changed = timestamp ) TO t_replytable.

    APPEND VALUE #( client = '200'
                    replytable_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  )
                    replytable = 'AN12'
                    replycodesize = 2
                    isac = ''
                    description = 'Special Storage'
                    istemporary = ''
                    created_by = sy-uname
                    created_at = timestamp
                    last_changed_by = sy-uname
                    last_changed_at = timestamp
                    local_last_changed = timestamp ) TO t_replytable.

    APPEND VALUE #( client = '200'
                    replytable_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  )
                    replytable = '0333'
                    replycodesize = 4
                    isac = 'X'
                    description = 'Material Location'
                    istemporary = ''
                    created_by = sy-uname
                    created_at = timestamp
                    last_changed_by = sy-uname
                    last_changed_at = timestamp
                    local_last_changed = timestamp ) TO t_replytable.


    APPEND VALUE #( client = '200'
                    replytable_uuid = zcl_get_uuid_x16=>generate_uuid_x16(  )
                    replytable = 'MA01'
                    replycodesize = 6
                    isac = '' description = 'Material'
                    istemporary = ''
                    created_by = sy-uname
                    created_at = timestamp
                    last_changed_by = sy-uname
                    last_changed_at = timestamp
                    local_last_changed = timestamp ) TO t_replytable.
  ENDMETHOD.

  METHOD generate_data.

  ENDMETHOD.
ENDCLASS.

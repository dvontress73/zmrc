@EndUserText.label: 'Abstract Enity to Create Replytable'
define abstract entity ZA_NEW_REPLYTABLE_PARAMS
  //with parameters parameter_name : parameter_type
{
  
  @EndUserText.label: 'Reply Table'
  ReplyTable          : abap.char(4);
  //mrc_build_uuid      : sysuuid_x16;
  @EndUserText.label: 'Reply Code Size'
  ReplyCodeSize       : abap.int1;
  @EndUserText.label: 'ISAC'
  ISAC                : abap_boolean;
  @EndUserText.label: 'Description'
  Description         : abap.char(50);
  @EndUserText.label: 'Temporary Reply Table'
  IsTemporary         : abap_boolean;
  //created_by          : syuname;
  //created_at          : timestampl;
  //last_changed_at     : abp_lastchange_tstmpl;
  //last_changed_by     : abp_lastchange_user;
  //local_last_changed  : abp_locinst_lastchange_tstmpl;
    
}

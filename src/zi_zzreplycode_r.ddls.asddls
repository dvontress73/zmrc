@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic Interface View forZZREPLYCODE_R'
define view entity ZI_ZZREPLYCODE_R
  as select from ZZREPLYCODE as ZZREPLYCODE_R
{
  key REPLY_CODE_UUID as ReplyCodeUUID,
  REPLY_TABLE_UUID as ReplyTableUUID,
  REPLY_CODE as ReplyCode,
  DESCRIPTION as Description,
  IS_TEMPORARY as IsTemporary,
  CREATED_BY as CreatedBy,
  CREATED_AT as CreatedAt,
  LAST_CHANGED_AT as LastChangedAt,
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED as LocalLastChanged
  
}

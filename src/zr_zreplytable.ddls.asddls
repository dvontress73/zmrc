@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZZREPLYTABLE'
define root view entity ZR_ZREPLYTABLE
  as select from zzreplytable as ReplyTable
{
  key replytable_uuid as ReplytableUUID,
  replytable as Replytable,
  replycodesize as Replycodesize,
  isac as Isac,
  description as Description,
  istemporary as Istemporary,
  created_by as CreatedBy,
  created_at as CreatedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed as LocalLastChanged
  
}

@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic Interface View forZZREPLYTABLE_R'
define view entity ZI_ZZREPLYTABLE_R
  as select from ZZREPLYTABLE as ZZREPLYTABLE_R
{
  key REPLYTABLE_UUID as ReplytableUUID,
  REPLYTABLE as Replytable,
  REPLYCODESIZE as Replycodesize,
  ISAC as Isac,
  DESCRIPTION as Description,
  ISTEMPORARY as Istemporary,
  @Semantics.user.createdBy: true
  CREATED_BY as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  CREATED_AT as CreatedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.user.lastChangedBy: true
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED as LocalLastChanged
  
}

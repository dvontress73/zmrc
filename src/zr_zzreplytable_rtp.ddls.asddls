@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forZZREPLYTABLE_R'
define root view entity ZR_ZZREPLYTABLE_RTP
  as select from ZI_ZZREPLYTABLE_R as ZZREPLYTABLE_R
  composition [0..*] of ZR_ZZREPLYCODE_R01TP as _ZZREPLYCODE_R
{
  key ReplytableUUID,
  Replytable,
  Replycodesize,
  Isac,
  Description,
  Istemporary,
  @Semantics.user.createdBy: true
  CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  CreatedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LastChangedAt,
  @Semantics.user.lastChangedBy: true
  LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LocalLastChanged,
  _ZZREPLYCODE_R
  
}

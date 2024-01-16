@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forZZREPLYCODE_R'
define view entity ZR_ZZREPLYCODE_R01TP
  as select from ZI_ZZREPLYCODE_R as ZZREPLYCODE_R
  association to parent ZR_ZZREPLYTABLE_RTP as _ZZREPLYTABLE_R on $projection.ReplyTableUUID = _ZZREPLYTABLE_R.ReplytableUUID
{
  key ReplyCodeUUID,
  ReplyTableUUID,
  ReplyCode,
  Description,
  IsTemporary,
  CreatedBy,
  CreatedAt,
  LastChangedAt,
  LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LocalLastChanged,
  _ZZREPLYTABLE_R
  
}

@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forZZREPLYCODE_R'
define view entity ZI_ZZREPLYCODE_R01TP
  as projection on ZR_ZZREPLYCODE_R01TP as ZZREPLYCODE_R
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
  LocalLastChanged,
  _ZZREPLYTABLE_R : redirected to parent ZI_ZZREPLYTABLE_RTP
  
}

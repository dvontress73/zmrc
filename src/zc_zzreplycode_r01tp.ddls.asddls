@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forZZREPLYCODE_R'
@ObjectModel.semanticKey: [ 'ReplyCodeUUID' ]
@Search.searchable: true
define view entity ZC_ZZREPLYCODE_R01TP
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
  _ZZREPLYTABLE_R : redirected to parent ZC_ZZREPLYTABLE_RTP
  
}

@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forZZREPLYTABLE_R'
define root view entity ZI_ZZREPLYTABLE_RTP
  provider contract transactional_interface
  as projection on ZR_ZZREPLYTABLE_RTP as ZZREPLYTABLE_R
{
  key ReplytableUUID,
  Replytable,
  Replycodesize,
  Isac,
  Description,
  Istemporary,
  CreatedBy,
  CreatedAt,
  LastChangedAt,
  LastChangedBy,
  LocalLastChanged,
  _ZZREPLYCODE_R : redirected to composition child ZI_ZZREPLYCODE_R01TP
  
}

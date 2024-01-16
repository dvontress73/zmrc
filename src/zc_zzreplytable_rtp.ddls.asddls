@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forZZREPLYTABLE_R'
@ObjectModel.semanticKey: [ 'Replytable' ]
@Search.searchable: true
define root view entity ZC_ZZREPLYTABLE_RTP
  provider contract transactional_query
  as projection on ZR_ZZREPLYTABLE_RTP as ZZREPLYTABLE_R
{
  key ReplytableUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
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
  _ZZREPLYCODE_R : redirected to composition child ZC_ZZREPLYCODE_R01TP
  
}

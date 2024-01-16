@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_ZREPLYTABLE'
define root view entity ZC_ZREPLYTABLE
  provider contract transactional_query
  as projection on ZR_ZREPLYTABLE
{
  key ReplytableUUID,
  Replytable,
  Replycodesize,
  Isac,
  Description,
  Istemporary,
  CreatedBy,
  CreatedAt,
  LocalLastChanged
  
}

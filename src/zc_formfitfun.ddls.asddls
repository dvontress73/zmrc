@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_FORMFITFUN'
define root view entity ZC_FORMFITFUN
  provider contract transactional_query
  as projection on ZR_FORMFITFUN
{
  key FffUUID,  
  FffName,
  CreatedBy,
  CreatedAt,
  LocalLastChanged
  
}

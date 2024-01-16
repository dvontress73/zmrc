@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_ZHIERROOT_NODE'
define root view entity ZC_ZHIERROOT_NODE
  provider contract transactional_query
  as projection on ZR_ZHIERROOT_NODE
{
  key RootnodeUUID,
  Rootnode,
  Nodedescription,
  CreatedBy,
  CreatedAt,
  LocalLastChanged
  
}

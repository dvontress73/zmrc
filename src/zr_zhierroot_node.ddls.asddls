@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZZHIERROOT_NODE'
define root view entity ZR_ZHIERROOT_NODE
  as select from zzhierroot_node as Root
{
  key rootnode_uuid as RootnodeUUID,
  rootnode as Rootnode,
  nodedescription as Nodedescription,
  created_by as CreatedBy,
  created_at as CreatedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed as LocalLastChanged
  
}

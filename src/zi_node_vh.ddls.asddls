@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for Node Hierarchy field'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_NODE_VH as select from zzhierroot_node
{
    key rootnode_uuid as RootnodeUuid,
    rootnode as Rootnode,
    nodedescription as Nodedescription,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_at as LastChangedAt,
    last_changed_by as LastChangedBy,
    local_last_changed as LocalLastChanged
}

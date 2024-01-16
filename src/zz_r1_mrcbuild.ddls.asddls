@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View for MRC BUILD'
define view entity ZZ_R1_MRCBUILD as select from zzmrc_build
association to parent ZZ_R_ReplyTable as _replyTable
  on $projection.ReplyTableUUID = _replyTable.ReplyTableUUID  
  association [0..1] to ZZ_R_MRC      as _mrc   
  on $projection.MRCUUID = _mrc.MRCUUID

{
    key mrc_build_uuid as MRCBuildUUID,
    line_item as Sequence,
    mrc_uuid as MRCUUID,
    reply_table_uuid as ReplyTableUUID,
    is_temporary as IsTemporary,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
     @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed as LocalLastChanged,
    _mrc,
    _replyTable
//    _Reply_Table.CreatedBy,
//    _Reply_Table.CreatedAt,
//    _Reply_Table.LastChangedAt,
//    _Reply_Table.LastChangedBy,
//    _Reply_Table.LocalLastChanged,
    
    
 
}

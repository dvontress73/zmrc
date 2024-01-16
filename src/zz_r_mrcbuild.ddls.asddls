@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View for MRC BUILD'
define view entity ZZ_R_MRCBUILD as select from zzmrc_build
association to parent ZZ_R_MRC as _mrc 
  on $projection.MRCUUID = _mrc.MRCUUID 
association [0..1] to ZZ_R_ReplyTable       as _Reply_Table   on $projection.ReplyTableUUID = _Reply_Table.ReplyTableUUID
association [0..*] to ZZ_R_ReplyCode as _Reply_Code on  $projection.ReplyTableUUID = _Reply_Code.ReplyTableUUID

{
    key mrc_build_uuid as MRCBuildUUID,
    line_item as Sequence,
    mrc_uuid as MRCUUID,
    reply_table_uuid as ReplyTableUUID,
    mrc_code as MRCCode,
    replytable as ReplyTable,
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
    _Reply_Table,
    _Reply_Code
//    _Reply_Table.CreatedBy,
//    _Reply_Table.CreatedAt,
//    _Reply_Table.LastChangedAt,
//    _Reply_Table.LastChangedBy,
//    _Reply_Table.LocalLastChanged,
    
    
 
}

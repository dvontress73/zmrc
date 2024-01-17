@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View For ReplyCode'
define view entity ZZ_R_ReplyCode as select from zzreplycode
association to parent ZZ_R_ReplyTable as _replyTable
    on $projection.ReplyTableUUID = _replyTable.ReplyTableUUID
{
    key reply_code_uuid as ReplyCodeUUID,
    reply_table_uuid as ReplyTableUUID,
    reply_code as ReplyCode,
    description as Description,
    long_description as LongText,
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
    _replyTable // Make association public
}

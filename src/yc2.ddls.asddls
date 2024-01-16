@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View For MRC'
define root view entity YC2 as select from zzmrc_build as _build
association to zzreplytable as _reply on _build.reply_table_uuid = _reply.replytable_uuid
  
{
key _build.mrc_build_uuid as MrcBuildUuid,
_build.line_item as LineItem,
_build.mrc_uuid as MrcUuid,
_build.reply_table_uuid as ReplyTableUuid,
_build.mrc_code as MrcCode,
_build.replytable as Replytable,
_build.is_temporary as IsTemporary,
@Semantics.user.createdBy: true
_build.created_by as CreatedBy,
@Semantics.systemDateTime.createdAt: true
_build.created_at as CreatedAt,
_build.last_changed_at as LastChangedAt,
_build.last_changed_by as LastChangedBy,
_build.local_last_changed as LocalLastChanged,

_reply

}

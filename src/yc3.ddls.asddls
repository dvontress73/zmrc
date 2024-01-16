@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View For MRC'
define root view entity YC3 as select from zzreplytable as _reply
association to zzreplycode as _code on _code.reply_table_uuid = _reply.replytable_uuid
  
{ 
key _reply.replytable_uuid as ReplytableUuid,
_reply.replytable as Replytable,
_reply.replycodesize as Replycodesize,
_reply.isac as Isac,
_reply.description as Description,
_reply.istemporary as Istemporary,
_reply.created_by as CreatedBy,
_reply.created_at as CreatedAt,
_reply.last_changed_at as LastChangedAt,
_reply.last_changed_by as LastChangedBy,
_reply.local_last_changed as LocalLastChanged, 

_code

}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View For ReplyTable'
define root view entity ZZ_R_ReplyTable
  as select from zzreplytable
  composition [0..*] of ZZ_R_ReplyCode as _replycode
  composition [0..*] of ZZ_R1_MRCBUILD as _mrc_build
{
  key replytable_uuid    as ReplyTableUUID,
      replytable         as ReplyTable,
      replycodesize      as ReplyCodeSize,
      isac               as ISACRelevant,
      description        as Description,
      istemporary        as IsTemporary,
      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed as LocalLastChanged,
      _replycode,
      _mrc_build
}

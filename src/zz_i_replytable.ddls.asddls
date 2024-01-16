@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View For Reply Table'
define view entity ZZ_I_REPLYTABLE as select from ZZ_R_ReplyTable

{
    key ReplyTableUUID,
    ReplyTable,
    ReplyCodeSize,
    ISACRelevant,
    Description,
    IsTemporary,
    CreatedBy,
    CreatedAt,
    LastChangedAt,
    LastChangedBy,
    LocalLastChanged,
    /* Associations */
    _replycode
     // Make association public
}

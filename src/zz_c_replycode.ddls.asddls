@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Consumption View for Reply Code'
@Search.searchable: true
define view entity ZZ_C_ReplyCode as projection on ZZ_R_ReplyCode
{
    key ReplyCodeUUID,
    ReplyTableUUID,
    @Search.defaultSearchElement: true
    ReplyCode,
    Description,
    LongText,
    IsTemporary,
    CreatedBy,
    CreatedAt,
    LastChangedAt,
    LastChangedBy,
    LocalLastChanged,
    /* Associations */
    _replyTable : redirected to parent ZZ_C_ReplyTable

}

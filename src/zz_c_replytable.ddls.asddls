@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Consumption View for Reply Table'
@Search.searchable: true
define root view entity ZZ_C_ReplyTable 

    provider contract transactional_query
    as projection on ZZ_R_ReplyTable

{
    key ReplyTableUUID,
     @Search.defaultSearchElement: true
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
    _replycode : redirected to composition child ZZ_C_ReplyCode,
    _mrc_build : redirected to composition child ZZ_C1_MRCBUILD
    
}

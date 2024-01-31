@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Consumption View for MRC'
@Search.searchable: true
define root view entity ZZ_C_MRC
  provider contract transactional_query
  as projection on ZZ_R_MRC
{
  key MRCUUID,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.85
      @Search.ranking: #HIGH
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MRC_VH', element: 'MrcUuid'} }]
      @ObjectModel.text.element: ['MRCCode']
      MRCCode,
      Description,
      LongDescription,
      MultipleIterations,      
      FFFRelated,
      ModeCode,
      IsTemporary,
      CreatedBy,
      CreatedAt,
      LastChangedAt,
      LastChangedBy,
      LocalLastChanged,
      _mrc_build : redirected to composition child ZZ_C_MRCBUILD
}

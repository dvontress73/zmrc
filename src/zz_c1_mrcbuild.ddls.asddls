@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for MRC Build'
//@Search.searchable: true
define view entity ZZ_C1_MRCBUILD
  as projection on ZZ_R1_MRCBUILD
{
  key MRCBuildUUID,
      Sequence,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MRC_VH', element: 'MrcUuid'} }]
      @ObjectModel.text.element: ['MRCCode']
      MRCUUID,
      @Search.defaultSearchElement: true
      _mrc.MRCCode as MRCCode,
   
      ReplyTableUUID,
      IsTemporary,
      CreatedBy,
      CreatedAt,
      LastChangedAt,
      LastChangedBy,
      LocalLastChanged,
      /* Associations */
      _replyTable : redirected to parent ZZ_C_ReplyTable
      //_Reply_Code


}

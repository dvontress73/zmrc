@EndUserText.label: 'Assign MRC to replytable'
@Metadata.allowExtensions: true
define abstract entity ZA_ASSIGN_MRC
  //with parameters parameter_name : parameter_type
{
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MRC_VH', element: 'MrcUuid'} }]
  @ObjectModel.text.element: ['MRCCode']
  mrcCode     : sysuuid_x16;
  description : abap.char( 50 );


}

@EndUserText.label: 'Assign MRC to replytable'
@Metadata.allowExtensions: true
define abstract entity ZA_ASSIGN_MRC_POPUP
  // with parameters parameter_name : parameter_type
{

  sequence         : abap.char(3);
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_MRC_VH', element: 'MrcUuid'} }]
  @ObjectModel.text.element: ['MRCCode']
  mrcCode          : sysuuid_x16;
  
  reply_table_uuid : sysuuid_x16;
  is_temporary     : abap_boolean;

}

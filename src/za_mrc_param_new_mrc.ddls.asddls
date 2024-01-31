@EndUserText.label: 'Parameters to Create a new MRC'
define abstract entity ZA_MRC_PARAM_NEW_MRC
  //with parameters parameter_name : parameter_type
{
  //mrc_uuid            : sysuuid_x16;
  @EndUserText.label: 'MRC'
  MRCCode            : abap.char(4);
  @EndUserText.label: 'Description'
  Description        : abap.char(50);
  @EndUserText.label: 'Long Description'
  LongDescription    : abap.char(255);
  @EndUserText.label: 'Multiple Iterations'
  MultipleIterations : abap_boolean;
  //@Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_FFFRELATED_VH', element: 'FffName'} }]
  //@ObjectModel.text.element: ['FFFRelated']
  @EndUserText.label: 'Form/Fit/Function'
  FFFRelated         : abap.char(10);
  @EndUserText.label: 'Mode Code'
  ModeCode           : abap.char(1);
  @EndUserText.label: 'Temporary MRC?'
  IsTemporary        : abap_boolean;

}

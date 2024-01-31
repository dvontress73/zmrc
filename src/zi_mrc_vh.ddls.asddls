@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for MRC Code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_MRC_VH as select from zzmrc
{
    key mrc_uuid as MrcUuid,
    mrc_code as MrcCode,
    description as Description
    //long_description as LongDescription,
    //multiple_iterations as MultipleIterations,
    //fff_related as FffRelated,
    //mode_code as ModeCode,
    //is_temporary as IsTemporary
}

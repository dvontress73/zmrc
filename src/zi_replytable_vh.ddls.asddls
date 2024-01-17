@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for replytable field'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_REPLYTABLE_VH as select from zzreplytable
{
    key replytable_uuid as ReplytableUuid,
    replytable as Replytable,
    mrc_build_uuid as MrcBuildUuid,
    replycodesize as Replycodesize,
    isac as Isac,
    description as Description,
    istemporary as Istemporary
}

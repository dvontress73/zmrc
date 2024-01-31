@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZSTW_FORMFITFUN'
define root view entity ZR_FORMFITFUN
  as select from zstw_formfitfun as Form_Fit_Function
{
  key fff_uuid as FffUUID,
  fff_name as FffName,
  created_by as CreatedBy,
  created_at as CreatedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed as LocalLastChanged
  
}

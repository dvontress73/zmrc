@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View For MRC'
define root view entity YC1 as select from zzmrc as _mrc
association to zzmrc_build as _build on _mrc.mrc_uuid = _build.mrc_uuid
  
{
key mrc_uuid as MRCUUID,
mrc_code as MRCCode,
description as Description,
long_description as LongDescription,
multiple_iterations as MultipleIterations,
fff_related as FFFRelated,
mode_code as ModeCode,
is_temporary as IsTemporary,
@Semantics.user.createdBy: true
created_by as CreatedBy,
@Semantics.systemDateTime.createdAt: true
created_at as CreatedAt,
@Semantics.systemDateTime.lastChangedAt: true
last_changed_at as LastChangedAt,
@Semantics.user.lastChangedBy: true
last_changed_by as LastChangedBy,
@Semantics.systemDateTime.localInstanceLastChangedAt: true
local_last_changed as LocalLastChanged,

_build
}

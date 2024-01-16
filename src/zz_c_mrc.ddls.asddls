@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Consumption View for MRC'
define root view entity ZZ_C_MRC 
provider contract transactional_query
as projection on  ZZ_R_MRC
{
key MRCUUID,
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
_mrc_build :  redirected to composition child ZZ_C_MRCBUILD
}

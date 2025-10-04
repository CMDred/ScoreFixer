# Version error checking
execute if score #ScoreFixer.VersionError load.status matches -1 run return run function score_fixer:zprivate/error/version_mismatch
function score_fixer:zprivate/error/not_installed

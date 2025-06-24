data remove storage score_fixer:zprivate Temp.CurrentBackup
$data modify storage score_fixer:zprivate Temp.CurrentBackup set from storage score_fixer:zprivate Backups[{UUID:$(UUID)}]

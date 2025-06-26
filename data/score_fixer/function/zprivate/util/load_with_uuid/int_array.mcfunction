# Load the player's data using the UUID in int array form
$data modify storage score_fixer:loaded Players append from storage score_fixer:zprivate Maps[{UUID:$(UUID)}]

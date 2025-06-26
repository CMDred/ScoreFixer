# Load the player's data using the UUID in hexadecimal form
$data modify storage score_fixer:loaded Players append from storage score_fixer:zprivate Maps[{UUID:uuid("$(UUID)")}]

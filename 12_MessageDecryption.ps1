cls

#Importing csv file with strings to replace and values to replace with
$CSVData = Import-Csv -Path "$PSScriptRoot\12_WordMatch.csv"

#Importing the encrypted message
$EncryptedMessage = Get-Content -Path "$PSScriptRoot\12_TextToReplace.txt" -Raw

#Looping through each row in the CSV file
ForEach ($Row in $CSVData) {
    #Replacing the string with the value
    $EncryptedMessage = $EncryptedMessage -replace $Row.numberBlocks, $Row.MatchedWord
}

$EncryptedMessage.ToLower()
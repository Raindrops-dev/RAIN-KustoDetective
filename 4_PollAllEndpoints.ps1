#Script to poll all endpoints on a loop until one doesn't answer 404

#importing CSV file with endpoints
Write-Output "Importing CSV file with endpoints"
$endpoints = Import-Csv -Path "E:\Andrei\Download\prime-numbers.csv\sorted-prime-numbers.csv"

Write-Output "Starting do while loop"
#do while loop polling endpoints until one doesn't answer 404
foreach ($endpoint in $endpoints) {
    $url = "https://aka.ms/" + $endpoint.Prime
    $response = Invoke-WebRequest -Uri $url -Method Get -UseBasicParsing
    $statuscode = $response.StatusCode
    $forwardsto = $response.baseresponse.responseuri.absoluteuri
    Write-output "$url - $forwardsto"
    if ($forwardsto -notlike "*bing.com*") {
        Write-Output "Found the endpoint that doesn't forward to bing.com: $forwardsTo"
        break
    }
}
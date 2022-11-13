#Script to scrape the webpage until the good one is found

#importing CSV file with endpoints
Write-Output "Importing CSV file with endpoints"
$endpoints = Import-Csv -Path ".\5_IPs.csv"

Write-Output "Starting do while loop"
#do while loop polling endpoints until one doesn't answer 

$endpoints | Foreach-Object -ThrottleLimit 10 -Parallel {
    #Action that will run in Parallel. Reference the current object via $PSItem and bring in outside variables with $USING:varname
    try {
        $url = "https://sneakinto.z13.web.core.windows.net/" + $PSItem.ip
        $response = Invoke-WebRequest -Uri $url -Method Get -UseBasicParsing
        $response
        $url | Out-File -FilePath ".\5_WorkingIPs.txt" -Append -Force
    }
    catch {
        $variable2 = $_.Exception.Response.statuscode
        Write-Output " $url - $variable2"
    }
}
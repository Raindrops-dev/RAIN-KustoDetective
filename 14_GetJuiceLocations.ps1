#Script to poll the Google Maps Find Place API to get all locations in Barcellona with "Juice" in the name and parse the json results to get the name, latitude and longitude and then export those to a csv file to import in Azure Data Explorer
Clear-Host

#Getting API key from mapsapi.json file
$mapsapi = Get-Content -Path "$PSScriptroot\mapsapi.json" | ConvertFrom-Json
$apikey = $mapsapi.api_key

# Define the base URL and parameters for textsearch
$baseUrl = "https://maps.googleapis.com/maps/api/place/textsearch/json"
$query = "Juice in Barcelona"

# URL Encode the query using Uri.EscapeDataString
$encodedQuery = [System.Uri]::EscapeDataString($query)

# Create the initial full URL
$fullUrl = "$($baseUrl)?query=$encodedQuery&key=$apiKey"

#Preparing output object
$juiceLocations = @()

# Loop to get multiple pages of results
do {
    # Output the full URL for debugging
    Write-Host "Full URL: $fullUrl"

    # Make the API request and store the response
    $response = Invoke-RestMethod -Uri $fullUrl -Method Get

    # Output the response (or process it as needed)
    $response.results

    # Loop through the results and add them to the output object
    foreach ($result in $response.results) {
        $juiceLocations += [PSCustomObject]@{
            Name = $result.name
            Latitude = $result.geometry.location.lat -replace ',', '.'
            Longitude = $result.geometry.location.lng -replace ',', '.'
            Operational = $result.business_status
        }
    }

    # Check for next_page_token and prepare for the next request
    if ($response.next_page_token) {
        # Introduce a delay before the next request (change the sleep time as needed)
        Start-Sleep -Seconds 2

        # Update the fullUrl for the next set of results
        $fullUrl = "$($baseUrl)?pagetoken=$($response.next_page_token)&key=$apiKey"
    }
} while ($response.next_page_token)

$juiceLocations | Export-Csv -Path "$PSScriptRoot\juiceLocations.csv" -NoTypeInformation
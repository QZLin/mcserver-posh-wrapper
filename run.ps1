param(
    [switch]$NoPause = $false
)
Push-Location $PSScriptRoot

$jdk = "C:\Program Files\Java\jdk-18.0.1.1+2"
$java = Join-Path $jdk "bin\java"

$jar = "server.jar"
$ram = "2G"

[System.Collections.Generic.List[String]]`
    $arg_list = @("-Xms$ram", "-Xmx$ram", "-jar", $jar , "nogui")

[System.Collections.Generic.List[String]]`
    $advance_args =
@(
    "-XX:+UnlockExperimentalVMOptions"
    , "-XX:+UseShenandoahGC"
    , "-XX:+DisableExplicitGC"
    , "-XX:+UseG1GC"
    , "-XX:MaxGCPauseMillis=50"
    , "-XX:G1NewSizePercent=50"
    , "-XX:G1MaxNewSizePercent=80"
    , "-XX:G1HeapRegionSize=4M"
    , "-XX:G1MixedGCLiveThresholdPercent=50"
    , "-XX:InitiatingHeapOccupancyPercent=10"
    , "-XX:+UnlockExperimentalVMOptions"
    , "-XX:+AlwaysPreTouch"
    # , "-XX:+AggressiveOpts"
    # , "-Xgcpolicy:gencon"
)


$arg_list.InsertRange(0, $advance_args)
Start-Process -FilePath $java -ArgumentList $arg_list -NoNewWindow -Wait
if (-not $NoPause) { Pause }
Pop-Location

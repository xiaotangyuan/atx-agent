@echo off

set GOOS=linux
set GOARCH=arm64
set DEST="/data/local/tmp/atx-agent"
go build .
adb push atx-agent %DEST%
adb forward tcp:7912 tcp:7912
adb shell chmod 755 %DEST%
adb shell %DEST% server -d

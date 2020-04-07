@echo off

set GOOS=linux
set GOARCH=arm64
set DEST="/data/local/tmp/atx-agent"
go generate || echo ERROR && exit /b
go build . || echo ERROR && exit /b
adb push atx-agent %DEST% || echo ERROR && exit /b
adb forward tcp:7912 tcp:7912 || echo ERROR && exit /b
adb shell chmod 755 %DEST% || echo ERROR && exit /b
adb shell %DEST% server --stop|| echo ERROR && exit /b
adb shell %DEST% server -d || echo ERROR && exit /b

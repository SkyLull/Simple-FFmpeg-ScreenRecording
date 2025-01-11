echo off
setlocal

set ffmpeg_path=./bin/ffmpeg.exe

set tmsp=%DATE%_%TIME%
set tmsp=%tmsp::=-%
set tmsp=%tmsp:.=-%
set tmsp=%tmsp:,=-% 
set tmsp=%tmsp:/=-% 
set tmsp=%tmsp: =-%

set output_file=%tmsp%.mp4

echo ============================
echo SFSR ver 1.7 build 1
echo build by SkyLull
echo ============================
echo.
echo Please be reminded
echo 1 included ffmpeg is required
echo 2 this script can now record audio!
echo 3 when using multi screen, all screen will be recorded at once
echo.
echo Choose recording format:
echo     Resolution       Audio    misc
echo 1.  1280x720 (720p)  No       -
echo 2.  1920x1080(1080p) No       -
echo 3.  As-is            Yes      requires VB-CABLE
echo 4.  As-is            Yes      requires VB-CABLE, Choose this if other modes induced a insufferable lag
set /p inputMode="please input 1/2/3/4 to choose mode: "

if %inputMode%==1 set record_resolution=720

if %inputMode%==2 set record_resolution=1080

echo -----------------------------------
echo [Caution] key in q to stop recording!
echo -----------------------------------
echo [Notice] Press any button to start recording!
PAUSE

rem Replace "audio_device_name" with your actual audio device name.
set audio_device=audio="CABLE Output (VB-Audio Virtual Cable)"

if %inputMode%==3 goto alt_record

if %inputMode%==4 goto low_late_record

"%ffmpeg_path%" -f gdigrab -framerate 30 -i desktop -vf scale=-1:%record_resolution% -c:v libx264 -crf 23 -maxrate 5M -bufsize 10M -pix_fmt yuv420p -movflags +faststart "%cd%\%output_file%"

echo [Notice] Recording stopped!
echo [Notice] please verify result "%tmsp%.mp4"

pause
exit


:alt_record
"%ffmpeg_path%" -f gdigrab -framerate 30 -i desktop -f dshow -i %audio_device% -c:v libx264 -crf 23 -maxrate 5M -bufsize 10M -pix_fmt yuv420p -c:a aac -b:a 192k -movflags +faststart "%cd%\%output_file%"

echo [Notice] Recording stopped!
echo [Notice] please verify result "%tmsp%.mp4"
pause
exit


:low_late_record
"%ffmpeg_path%" -f gdigrab -framerate 30 -i desktop -f dshow -i %audio_device% -c:v libx264 -pix_fmt yuv420p -preset ultrafast -tune zerolatency -c:a aac -b:a 192k "%cd%\%output_file%"
echo [Notice] Recording stopped!
echo [Notice] please verify result "%tmsp%.mp4"
echo [Notice] If you find the result video file too large, input y to perform compress
echo [Notice] Be aware that compressing might need up to the time span of the whole video
set /p need_compress="Do you sure want to compress? [y/N]"
if %need_compress%==y goto compress
pause
exit

:compress
echo [Notice] compressing
if %inputMode%==4 "%ffmpeg_path%" -i "%cd%\%output_file%" -c:v libx264 -maxrate 5M "%cd%\%tmsp%_compressed.mp4"
if exist %cd%\%tmsp%_compressed.mp4 del "%cd%\%output_file%"

echo [Notice] Done!
echo [Notice] please verify result "%tmsp%_compressed.mp4"
pause
exit

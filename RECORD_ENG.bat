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
echo SFSR ver 1.6 build 4 
echo build by SkyLull
echo ============================
echo.
echo Please be reminded
echo 1 included ffmpeg is required
echo 2 this script cannot perform audio recording
echo 3 when using multi screen, all screen will be recorded at once
echo.
echo Choose recording format:
echo (1 Fixed 720p HD    2 Fixed 1080p FHD    3 Original)
echo (4 Low Latency, Choose this mode if other mode induced insufferable lag)
set /p inputMode="please input 1/2/3/4 to choose mode: "

if %inputMode%==1 set record_resolution=720

if %inputMode%==2 set record_resolution=1080

echo -----------------------------------
echo [Caution] key in q to stop recording!
echo -----------------------------------
echo [Notice] Press any button to start recording!
PAUSE

if %inputMode%==3 goto alt_record

if %inputMode%==4 goto low_late_record


"%ffmpeg_path%" -f gdigrab -framerate 30 -i desktop -vf scale=-1:%record_resolution% -c:v libx264 -crf 23 -maxrate 5M -bufsize 10M -pix_fmt yuv420p -movflags +faststart "%cd%\%output_file%"

echo [Notice] Recording stopped!
echo [Notice] please verify result "%tmsp%.mp4"

pause
exit


:alt_record
"%ffmpeg_path%" -f gdigrab -framerate 30 -i desktop -c:v libx264 -crf 23 -maxrate 5M -bufsize 10M -pix_fmt yuv420p -movflags +faststart "%cd%\%output_file%"

echo [Notice] Recording stopped!
echo [Notice] please verify result "%tmsp%.mp4"
pause
exit


:low_late_record
"%ffmpeg_path%" -f gdigrab -framerate 30 -i desktop -c:v libx264 -pix_fmt yuv420p -preset ultrafast -tune zerolatency "%cd%\%output_file%"
echo [Notice] Recording stopped!
echo [Notice] please verify result "%tmsp%.mp4"
echo [Notice] If you find the result video file too large, input y to perform compress
echo [Notice] Be awared that compressing might need up to the time span of the whole video
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
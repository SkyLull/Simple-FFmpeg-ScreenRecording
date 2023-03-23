echo off
setlocal
chcp 65001

set ffmpeg_path=./bin/ffmpeg.exe

set tmsp=%DATE%_%TIME%
set tmsp=%tmsp::=-%
set tmsp=%tmsp:.=-%
set tmsp=%tmsp:,=-% 
set tmsp=%tmsp:/=-% 
set tmsp=%tmsp: =-%

set output_file=%tmsp%.mp4

echo ============================
echo 簡易螢幕錄影 ver 1.6 build 4 
echo build by SkyLull
echo ============================
echo.
echo 使用前請注意下列事項
echo 一、本軟體需依靠隨同的ffmpeg運作
echo 二、本軟體無法錄音
echo 三、使用雙螢幕時，本軟體將一同錄製兩個螢幕
echo.
echo 請選擇錄影格式:
echo (1 固定720p HD    2 固定1080p FHD    3 螢幕原畫質)
echo (4 低延遲模式。若錄影時電腦卡頓難以正常使用，請選擇此模式。)
set /p inputMode="請輸入 1/2/3/4 以選擇模式: "

echo inputmode = %inputMode%

if %inputMode%==1 set record_resolution=720

if %inputMode%==2 set record_resolution=1080

echo -----------------------------------
echo [注意] 注意，在此視窗按下 q 來停止錄影!
echo -----------------------------------
echo [通知] 請按任意鍵以開始錄影!
PAUSE

if %inputMode%==3 goto alt_record

if %inputMode%==4 goto low_late_record


"%ffmpeg_path%" -f gdigrab -framerate 30 -i desktop -vf scale=-1:%record_resolution% -c:v libx264 -crf 23 -maxrate 5M -bufsize 10M -pix_fmt yuv420p -movflags +faststart "%cd%\%output_file%"

echo [通知] 錄製已停止!
echo [通知] 請檢查檔案 "%tmsp%.mp4"

pause
exit


:alt_record
"%ffmpeg_path%" -f gdigrab -framerate 30 -i desktop -c:v libx264 -crf 23 -maxrate 5M -bufsize 10M -pix_fmt yuv420p -movflags +faststart "%cd%\%output_file%"

echo [通知] 錄製已停止!
echo [通知] 請檢查檔案 "%tmsp%.mp4"
pause
exit


:low_late_record
"%ffmpeg_path%" -f gdigrab -framerate 30 -i desktop -c:v libx264 -pix_fmt yuv420p -preset ultrafast -tune zerolatency "%cd%\%output_file%"
echo [通知] 錄製已停止!
echo [通知] 請檢查檔案 "%tmsp%.mp4"
echo [通知] 若檔案過大想要壓縮，請輸入y以進行壓縮，注意壓縮時間約需錄影總時長的60%%
set /p need_compress="是否壓縮影片? [y/N]"
if %need_compress%==y goto compress
pause
exit

:compress
echo [通知] 正在壓縮影片
if %inputMode%==4 "%ffmpeg_path%" -i "%cd%\%output_file%" -c:v libx264 -maxrate 5M "%cd%\%tmsp%_compressed.mp4"
if exist %cd%\%tmsp%_compressed.mp4 del "%cd%\%output_file%"

echo [通知] 壓縮完成!
echo [通知] 請檢查檔案 "%tmsp%_compressed.mp4"
pause
exit
# 簡易螢幕錄影 SimpleFFmpegScreenRecording
SFSR 的設計前提是在電腦存取權被嚴重限制、無法安裝其他軟體的環境下（例如學校電腦），使不熟悉電腦使用的人可以進行螢幕錄影。<br>
SFSR was designed to work under a low-permission environment (such as on a school computer) but still provides ease of use for people who are not very familiar with computer things.

如果你仍有此需求，建議可以改用 [Captura](https://github.com/MathewSachin/Captura/releases/download/v8.0.0/Captura-Portable.zip) ，該軟體在同一個限制前提下提供了更全面、更完整的功能，且有更簡單的操作介面及中文翻譯。<br>
If you still have the demand to record under such conditions, I sincerely suggest you use [Captura](https://github.com/MathewSachin/Captura/releases/download/v8.0.0/Captura-Portable.zip) instead, it provides better, cleaner UI and more complete functionality.

本repo將不再做任何更新，請勿提出issue，想要修復任何問題可以直接fork或發pull request<br>
This repo will no longer be maintained or updated, do not raise any issue. If you can fix any problem, you're welcome to fork this project or file a pull request.<br>

等未來 ffmpeg 支援 [WASAPI](https://trac.ffmpeg.org/ticket/9408) 以後，我會回來更新這個玩具項目，使其達成一開始希望的完整功能。<br>
If someday ffmpeg added support to [WASAPI](https://trac.ffmpeg.org/ticket/9408), I will come back to finish this toy project.


RECORD.bat 約有50% code 為 chatGPT協助生成<br>
50% of codes in RECORD.bat is generated via chatGPT, not my work.<br>
<br>

本體需依靠隨同的ffmpeg運作，若希望能錄音則需要安裝附帶的VB-CABLE<br>
included ffmpeg is required, audio recording requires VB-CABLE to be installed.<br>

~~本體無法錄音<br>~~
~~this script cannot perform audio recording<br>~~
1.7 版起含錄音功能，但僅限模式3、4，且需要安裝VB-CABLE並進行相關設定後方可使用。<br>
audio can be recorded starting ver 1.7, but requires installation and settings of VB-CABLE.

使用雙螢幕時，將一同錄製兩個螢幕<br>
when using multi-screen, all screens will be recorded at once<br>

## 如何使用 How to use
~~[點此連結](https://github.com/SkyLull/Simple-FFmpeg-ScreenRecording/archive/refs/heads/main.zip)下載後解壓縮即可使用，點擊 **RECORD.bat** 以啟動程式<br>~~
1.7 版起不再維護中文版介面，跟windows cmd不能用非英文字的問題有關。

[Click this link](https://github.com/SkyLull/Simple-FFmpeg-ScreenRecording/archive/refs/heads/main.zip) to download it, unzip it and it's ready to go.
Double click **RECORD_ENG.bat** to launch the program.<br>


## 如何安裝與設定VB-CABLE 

1. 解壓縮 `VBCABLE_Driver_Pack45.zip`
2. 點兩下解壓縮出來的 `VBCABLE_Setup_x64.exe`
3. 按 `Install` 以安裝
4. 安裝完後點兩下隨附的 `sound_settings`
5. 請記住目前的「預設裝置」的名字
6. 找到 `CABLE Input`，右鍵選單，並按下 `設定成預設裝置`，完成後應顯示如右圖
![image](https://github.com/user-attachments/assets/8f6e64b7-e452-4c03-8fd5-ed61fd7b25cd)
7. 找到 `錄製` 頁籤，找到 `CABLE Output`，右鍵，內容
8. 找到 `接聽` 頁籤，勾選 `聆聽此裝置`，並將下方「透過此裝置撥放」設定為第5步驟所記住的裝置名稱
9. 確定所有修改，完成

## How to install and setup VB-CABLE
1. unzip `VBCABLE_Driver_Pack45.zip`
2. navigate to the unzipped folder, double-click `VBCABLE_Setup_x64.exe`
3. click `Install` to install
4. after successful installation, double-click the attached `sound_settings`
5. please remember the name of the current "default playback device"
6. find `CABLE Input`, right-click, and find the option `set as default playback device`, should look something like this picture except the language different.
![image](https://github.com/user-attachments/assets/8f6e64b7-e452-4c03-8fd5-ed61fd7b25cd)
7. find the `record` page, find `CABLE Output`, right-click, Properties.
8. find the second page, check `listen to this device`, change the "playback via this device" to the name I required you to remember in the 5th step.
9. confirm every modification, done.

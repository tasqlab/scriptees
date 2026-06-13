@echo off
title Summoning the Honored One...
color 0a
echo Ready to summon the Honored One?
pause

:: Loop exactly 20 times
for /L %%i in (1,1,20) do (
    
    :: 1. Write the custom text into a uniquely numbered file in your Temp folder
    echo chirag alone stands at the top > "%temp%\chirag_%%i.txt"
    
    :: 2. Launch that specific text file in a brand-new, separate Notepad instance
    start notepad.exe "%temp%\chirag_%%i.txt"
    
    :: 3. A microscopic 50ms pause so the windows stagger neatly across your screen
    pathping 127.0.0.1 -n -q 1 -p 50 >nul
)

exit

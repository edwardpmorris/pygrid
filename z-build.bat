echo off

rmdir /q /s dist
rmdir /q /s build

rem Bundling all DLLs in one file is a bad idea -
rem it leaves the entire uncompressed app in the Temp folder on every restart
rem call pyinstaller -F -w --icon ui\img\icon.ico pygrid.py
call pyinstaller -w --icon ui\img\icon.ico pygrid.py

rem Fixing the bug in pyinstaller 3.3: https://github.com/pyinstaller/pyinstaller/issues/2857
rem Need to manually copy one library otherwize app won't start
cd .\dist\pygrid\
md platforms
xcopy .\PyQt5\Qt\plugins\platforms\qwindows.dll .\platforms\

rem bunding into a single file
cd ..
"C:\Program Files\WinRAR\winrar.exe" a -afzip pygrid.zip pygrid
cd ..

rmdir /q /s build

echo on

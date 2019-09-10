rem @echo off
for /f "usebackq delims=" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -prerelease -latest -property installationPath`) do (
  if exist "%%i\Common7\Tools\vsdevcmd.bat" (
    set INSTALLDIR=%%i
  )
)

cd luajit\src
call "%INSTALLDIR%"\Common7\Tools\vsdevcmd.bat -arch=x86
call msvcbuild amalg
cd ..\..
mkdir build32
copy luajit\src\lua51.* build32

cd luajit\src
call "%INSTALLDIR%"\Common7\Tools\vsdevcmd.bat -arch=amd64
call msvcbuild amalg
cd ..\..
mkdir build64
copy luajit\src\lua51.* build64

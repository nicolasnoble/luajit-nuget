rem @echo off
for /f "usebackq delims=" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -prerelease -latest -property installationPath`) do (
  if exist "%%i\Common7\Tools\vsdevcmd.bat" (
    set INSTALLDIR=%%i
  )
)

set XCFLAGS=/DLUAJIT_ENABLE_LUA52COMPAT

cd luajit
git clean -f -d -x
cd src
call "%INSTALLDIR%"\Common7\Tools\vsdevcmd.bat -arch=x86
call msvcbuild amalg
cd ..\..
mkdir build-x86
copy luajit\src\lua51.* build-x86

cd luajit
git clean -f -d -x
cd src
call "%INSTALLDIR%"\Common7\Tools\vsdevcmd.bat -arch=amd64
call msvcbuild amalg
cd ..\..
mkdir build-amd64
copy luajit\src\lua51.* build-amd64

nuget pack

REM https://sourceforge.net/projects/gnuwin32/files/wget/1.11.4-1/wget-1.11.4-1-setup.exe/download?use_mirror=altushost-swe

@echo off

@(for %%i in (MAIL,USER,PASS,KEY)do @set /p %%~i=)<.\_secret.txt

echo %MAIL%
echo %USER%
echo %PASS%
echo %KEY%
echo

echo =======================================================
SET MAP=https://%USER%.github.io/sitemap.xml
echo Sitemap: %MAP%
echo =======================================================
echo

cd _site
if %ERRORLEVEL% NEQ 0 (
    echo "'cd' command filed with code: %ERRORLEVEL%"
    exit /B %ERRORLEVEL%
)

git add .
if %ERRORLEVEL% NEQ 0 (
    echo "'git add .' command filed with code: %ERRORLEVEL%"
    exit /B %ERRORLEVEL%
)

git -c user.name="%USER%" -c user.email="%MAIL%" commit -m "commit"
if %ERRORLEVEL% NEQ 0 (
    echo "'git commit' command filed with code: %ERRORLEVEL%"
    exit /B %ERRORLEVEL%
)

git push https://%USER%:%KEY%@github.com/%USER%/%USER%.github.io.git --all --force
if %ERRORLEVEL% NEQ 0 (
    echo "'git push' command filed with code: %ERRORLEVEL%"
    exit /B %ERRORLEVEL%
)


"C:\Program Files (x86)\GnuWin32\bin\wget.exe" https://www.google.com/ping?sitemap=%MAP% --no-check-certificate -O ping-result.html
if %ERRORLEVEL% NEQ 0 (
    echo "Sitemap PING failed with code: %ERRORLEVEL%"
    exit /B %ERRORLEVEL%
)

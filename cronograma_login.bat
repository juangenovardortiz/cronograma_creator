@echo off
REM ES: Arranca un servidor local en http://localhost:8000 y abre la app.
REM EN: Starts a local server at http://localhost:8000 and opens the app.

cd /d "%~dp0"

set PORT=8000
set URL=http://localhost:%PORT%/

REM Abre el navegador en cuanto el servidor esté listo
start "" "%URL%"

REM Intenta primero con Python; si no, usa npx http-server
where python >nul 2>nul
if %ERRORLEVEL%==0 (
    echo Servidor en %URL%  ^(Ctrl+C para parar^)
    python -m http.server %PORT%
    goto :end
)

where py >nul 2>nul
if %ERRORLEVEL%==0 (
    echo Servidor en %URL%  ^(Ctrl+C para parar^)
    py -m http.server %PORT%
    goto :end
)

where npx >nul 2>nul
if %ERRORLEVEL%==0 (
    echo Servidor en %URL%  ^(Ctrl+C para parar^)
    npx --yes http-server -p %PORT% -c-1
    goto :end
)

echo.
echo [ERROR] No se encontro ni Python ni Node/npx.
echo Instala Python desde https://www.python.org/  o  Node.js desde https://nodejs.org/
pause

:end

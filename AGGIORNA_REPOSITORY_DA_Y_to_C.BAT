@echo off
chcp 65001 >nul

echo ================================================
echo     AGGIORNAMENTO PDF da Y: a C: + GIT
echo ================================================
echo.

:: Vai nella cartella corretta
cd /d "C:\GESTIONI\GESTIONE_LLPP\25_GESTIONE_LLPP\ARCHIVI_ACCESS_PRES3000\C_PRES3000_N01_CALENDARIO\C_PDF"

echo Sto copiando i file PDF dalla rete...
echo.

robocopy "Y:\LAVORI_PUBBLICI_FINO_AL_30_09_2019\Valter\OPERE_PUBBLICHE\96_ARCHIVI_LLPP_MDB\25_GESTIONE_LLPP_Y\ARCHIVI_ACCESS_PRES3000_Y\PRES3000_N01_CALENDARIO\PDF" ^
         "." *.pdf /XO /R:5 /W:5 /NP /NDL /NJH /NJS

echo.
if %errorlevel%==0 (
    echo Nessun file nuovo da copiare.
) else if %errorlevel% leq 7 (
    echo ? Copia PDF completata.
) else (
    echo ? Problemi nella copia (codice %errorlevel%)
)

echo.
echo Aggiorno Git...
echo.

:: Aggiunge tutti i pdf e anche questo file bat
git add *.pdf 2>nul
git add AGGIORNA_REPOSITORY_DA_Y_to_C.BAT 2>nul

git commit -m "Aggiornamento automatico PDF da Y: - %date% %time:~0,8%" >nul 2>&1

if %errorlevel% equ 0 (
    echo ? Commit effettuato.
    echo Sto facendo il push su GitHub...
    git push origin HEAD
    if %errorlevel% equ 0 (
        echo ? Push completato con successo!
    ) else (
        echo ? Errore durante il push.
    )
) else (
    echo Nessuna modifica da registrare.
)

echo.
echo ================================================
echo Operazione TERMINATA
echo ================================================
echo.
pause
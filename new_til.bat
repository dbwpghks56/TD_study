@echo off
rem Windows launcher: runs new_til.ps1 (works even with Restricted execution policy)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0new_til.ps1" %*
pause

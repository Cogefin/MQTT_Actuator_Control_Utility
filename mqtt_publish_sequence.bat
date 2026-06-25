@if not "%~0"=="%~dp0.\%~nx0" start /min cmd /c,"%~dp0.\%~nx0" %* & goto :eof
@echo off

rem start /b pythonw mqtt_publish_sequence
python mqtt_publish_sequence
rem pause

@if not "%~0"=="%~dp0.\%~nx0" start /min cmd /c,"%~dp0.\%~nx0" %* & goto :eof
@echo off

rem start /b pythonw publish_mqtt_sequence
python publish_mqtt_sequence
rem pause

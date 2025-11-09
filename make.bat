@ECHO OFF

set TOOLS_BIN=%~dp0

set ORIGINAL_ROM_NAME=balloon_fight
set ORIGINAL_ROM_FILE=%ORIGINAL_ROM_NAME%.nes
set HACK_ROM_NAME=balloon_festival
set HACK_ROM_FILE=%HACK_ROM_NAME%.nes

if not exist %HACK_ROM_NAME%.chr (
    REM Extract CHR from original ROM name
    %TOOLS_BIN%\ucon64.exe -s %ORIGINAL_ROM_FILE%

    REM Apply changed graphics via the IPS
    copy %ORIGINAL_ROM_NAME%.chr %HACK_ROM_NAME%.chr
    %TOOLS_BIN%\ucon64.exe -i %HACK_ROM_NAME%.chr balloon_festival_chr.ips
)

REM Delete hack rom
if exist %HACK_ROM_FILE% (
    del %HACK_ROM_FILE%
)

REM Assembly the hacked ROM
asm6 %HACK_ROM_NAME%.asm %HACK_ROM_FILE%

REM Create IPS patch
%TOOLS_BIN%\ucon64.exe --mki=%ORIGINAL_ROM_FILE% %HACK_ROM_FILE%

REM Cleanup
if exist %ORIGINAL_ROM_NAME%.chr (
    del %ORIGINAL_ROM_NAME%.chr
)
if exist %ORIGINAL_ROM_NAME%.prg (
    del %ORIGINAL_ROM_NAME%.prg
)
if exist %ORIGINAL_ROM_NAME%.prm (
    del %ORIGINAL_ROM_NAME%.prm
)
if exist %HACK_ROM_NAME%.bak (
    del %HACK_ROM_NAME%.bak
)

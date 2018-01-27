@ECHO OFF
IF NOT "%~2"=="" GOTO parse_err
IF NOT "%~1"=="" GOTO check_is_numeric
IF "%~1"=="" (
	echo No argument given, default to 30s loop.
	SET /a a=30 >nul
	GOTO loop
)

:check_is_numeric
SET /a a=%~1+0 >nul
IF %a% == 0 (
	IF NOT "%a%"=="0" ( GOTO parse_err
  ) ELSE ( GOTO check_is_gt_than_zero )
) ELSE (GOTO check_is_gt_than_zero )

:check_is_gt_than_zero
IF %a% GTR 0 ( GOTO loop
) ELSE ( GOTO gt_zero_err )

:parse_err
ECHO This script can read only one argument: the number of seconds per loops.
EXIT /B

:gt_zero_err
ECHO The number of seconds per loop must be greater than 0.
EXIT /B

:loop
TIMEOUT %a%
TASKKILL /im mspaint.exe
GOTO loop

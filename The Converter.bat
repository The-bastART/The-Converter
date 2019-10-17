@echo off
title The Converter
color a
:start
rem start info
	echo  ________________
	echo /                \
	echo ^| THE CONVERTER  ^|
	echo \      v1.2      /
	echo[
	echo Possible File Formats: svg, wmf, emf, pdf, png, dxf
	echo Convert Format [1] into Format [2]
	echo Standard: svg to wmf
	echo[

rem variables
	set /a n=0
	set /a q=0
	set /p Std= Do you want to use the Standard? (y/n): 
	if %std%==n (
	set /p f1=Format [1]:
	set /p f2=Format [2]:
	)
	if %Std%==y (
	set f1=svg
	set f2=wmf
	)
	if not %Std%==y if not %Std%==n cls & goto start
	
	set /p d= Directory of your Files: 

	set load=
	set todo=
	set/a loadnum=0
	


rem count files
	cd %d%
	for %%k in (*.%f1%) do set /a n+=1
	echo Amount of Files: %n%

	set /p r=Do you want to rename you files? (y/n): 
	
	if %r%==y goto rename
	if %r%==n goto con
	if not %r%==y if not %r%==n cls & goto start

rem rename
rem first File
	:rename
	cd %d%
	for  %%x in (*.%f1%) do (
	  set "fF=%%x"
	  goto :done
	)
	:done 
	set /a fF=%fF:~0,-4%
	echo Name of the first File: %fF%.%f1%

	set /a b=%n%	
	setlocal enabledelayedexpansion
	for %%p in (*) do (
		set /a q+=1
		ren %%p !q!.%f1%
		rem echo image %%p renamed  to !q!.%f1%
		
		set load=!load!Û
		set /a b=!b!-1
		set /a i+=1
		set /a c=0
		set todo=
		
		call :counter
		
		cls
		color b
		echo  ________________
		echo /                \
		echo ^| THE CONVERTER  ^|
		echo \      v1.2      /
		echo[
		echo The images are being renamed.
		echo !i! of %n% are done already.
		echo ----------------------------------------------------------------------------------------------------
		echo !load!!todo!
		echo[
		echo ----------------------------------------------------------------------------------------------------
		ping localhost -n 2 >nul
		
		set/a loadnum=%loadnum% +1
	)
	echo All images renamed
	echo[

	rem set /p=press enter to convert
	rem goto pause1
	rem :pause1

	:con

rem file directory
	if not exist "%d%\%f2%" mkdir "%d%\%f2%"

rem convert
	set /a b=%n%
	set /a i=0
	set load=
	set todo=
	set/a loadnum=0
	setlocal enabledelayedexpansion
	for /l %%x in (1, 1, %n%) do ( 
		"c:\Program Files\Inkscape\inkscape.exe" -f "%d%\%%x".%f1% --export-%f2% "%d%\WMF\%%x".%f2%
		rem echo image #%%x converted
		
		set load=!load!Û
		set /a b=!b!-1
		set /a i+=1
		set /a c=0
		set todo=
	
		call :counter
		
		cls
		color a
		echo  ________________
		echo /                \
		echo ^| THE CONVERTER  ^|
		echo \      v1.2      /
		echo[
		echo The images are being converted.
		echo !i! of %n% are done already.
		echo ----------------------------------------------------------------------------------------------------
		echo !load!!todo!
		echo[
		echo ----------------------------------------------------------------------------------------------------
		ping localhost -n 2 >nul
		
		set /a loadnum=%loadnum% +1
	)

	echo Yeah.. 
	echo I have successfully converted %n% .%f1%-files to .%f2%-files!

rem new convert
	set /p new= Do you want to convert some more files? (y/n): 
	cls
	if %new%==y goto start
	if %new%==n exit

rem counter
	:counter
	:repeat
	if %c% == %b% goto :continue
	set todo=%todo%±
	set /a c+=1
	goto :repeat
	
	:continue
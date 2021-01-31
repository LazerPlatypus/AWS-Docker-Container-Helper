@echo off
IF %1.==. GOTO Err1
IF %2.==. GOTO Err2 
ECHO setting up amazon uri variable
SET awsuri=%1.dkr.ecr.%2.amazonaws.com

ECHO setting up variables for Build-Deploy.bat
SET filename=%~dp0Build-Deploy.bat
ECHO creating Build-Deploy.bat
ECHO @echo off > %filename%
ECHO IF %%1.==. GOTO Err >> %filename%
ECHO @echo on >> %filename%
ECHO docker build -t %%1 . >> %filename%
ECHO docker tag %%1 %awsuri%/%%1 >> %filename%
ECHO aws ecr get-login-password ^| docker login --username AWS --password-stdin %awsuri% >> %filename%
ECHO docker push %awsuri%/%%1:latest >> %filename%
ECHO @echo off >> %filename%
ECHO GOTO End >> %filename%
ECHO. >> %filename%
ECHO :Err >> %filename%
ECHO	ECHO No image name >> %filename%
ECHO	ECHO usage: Build-Deploy.bat [image name] >> %filename%
ECHO. >> %filename%
ECHO :End >> %filename%

ECHO setting up file variables for Build-Test.bat
SET filename=%~dp0Build-Test.bat
ECHO creating Build-Test.bat
ECHO @echo off > %filename%
ECHO IF %%1.==. GOTO Err >> %filename%
ECHO @echo on >> %filename%
ECHO docker build -t %%1 . >> %filename%
ECHO docker run -dp 9000:8080 %%1 >> %filename%
ECHO @echo off >> %filename%
ECHO GOTO End >> %filename%
ECHO. >> %filename%
ECHO :Err >> %filename%
ECHO	No image name >> %filename%
ECHO	ECHO usage: Build-Test.bat [image name] >> %filename%
ECHO. >> %filename%
ECHO :End >> %filename%

ECHO setting up file variables for Build.bat
SET filename=%~dp0Build.bat
ECHO creating Build.bat
ECHO @echo off > %filename%
ECHO IF %%1.==. GOTO Err >> %filename%
ECHO @echo on >> %filename%
ECHO docker build -t %%1 . >> %filename%
ECHO @echo off >> %filename%
ECHO. >> %filename%
ECHO :Err >> %filename%
ECHO	Echo No image name >> %filename%
ECHO	usage: Build.bat [image name] >> %filename%
ECHO. >> %filename%
ECHO :End1 >> %filename%

ECHO setting up file variables for Create-Repo.bat
SET filename=%~dp0Create-Repo.bat
ECHO creating Create-Repo.bat
ECHO @echo off > %filename%
ECHO IF %%1.==. GOTO Err >> %filename%
ECHO @echo on >> %filename%
ECHO aws ecr create-repository --repository-name %%1 --image-scanning-configuration scanOnPush=true >> %filename%
ECHO @echo off >> %filename%
ECHO GOTO End >> %filename%
ECHO. >> %filename%
ECHO :Err >> %filename%
ECHO	ECHO no image name >> %filename%
ECHO	usage: Create-Repo.bat [image name] >> %filename%
ECHO. >> %filename%
ECHO :End >> %filename%

ECHO setting up file variables for Deploy.bat
SET filename=%~dp0Deploy.bat
ECHO creating Deploy.bat
ECHO @echo off > %filename%
ECHO IF %%1.==. GOTO Err >> %filename%
ECHO @echo on >> %filename%
ECHO docker tag %%1 %awsuri%/%%1 >> %filename%
ECHO aws ecr get-login-password ^| docker login --username AWS --password-stdin %awsuri% >> %filename%
ECHO docker push %awsuri%/%%1:latest >> %filename%
ECHO @echo off >> %filename%
ECHO GOTO End >> %filename%
ECHO. >> %filename%
ECHO :Err >> %filename%
ECHO	ECHO no image name >> %filename%
ECHO	ECHO usage: Deploy.bat [image name] >> %filename%
ECHO. >> %filename%
ECHO :End >> %filename%

ECHO setting up file variables for Test.bat
SET filename=%~dp0Test.bat
ECHO creating Test.bat > %filename%
ECHO @echo off >> %filename%
ECHO IF %%1.==. GOTO Err >> %filename%
ECHO @echo on >> %filename%
ECHO docker run -dp 9000:8080 %%1 >> %filename%
ECHO @echo off >> %filename%
ECHO GOTO End >> %filename%
ECHO. >> %filename%
ECHO :Err >> %filename%
ECHO	ECHO no image name >> %filename%
ECHO	ECHO usage: Test.bat [image name] >> %filename%
ECHO. >> %filename%
ECHO :End >> %filename%

ECHO done
@echo off
GOTO End

:Err1
    ECHO No account number
    ECHO usage: Create-Commands.bat [Account number] [Account region]
    GOTO End1

:Err2
    ECHO No account region
    ECHO usage: Create-Commands.bat [Account number] [Account region]
    GOTO End1

:End
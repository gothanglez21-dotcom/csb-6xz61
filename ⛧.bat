@echo off
setlocal EnableExtensions EnableDelayedExpansion
color 0C
title ⛧

set "ROOT=%~dp0"
set "PROFILE_DIR=%ROOT%profiles"
set "LOG_DIR=%ROOT%logs"
set "APP_DIR=%USERPROFILE%\AppData\Local\⛧"
set "KEY_FILE=%APP_DIR%\keys.txt"
set "NOTES_FILE=%ROOT%notes.txt"
set "ADMIN_PASS=REDADMIN2026"
set "USER_ROLE="

if not exist "%PROFILE_DIR%" mkdir "%PROFILE_DIR%"
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"
if not exist "%APP_DIR%" mkdir "%APP_DIR%"
if not exist "%NOTES_FILE%" > "%NOTES_FILE%" echo Quick notes
if not exist "%KEY_FILE%" > "%KEY_FILE%" echo 1111-1111-1111^|2030-12-31 23:59:59^|active^|default

>> "%LOG_DIR%\grave_log.txt" echo [%date% %time%] App started
call :auth_screen
exit /b 0

:auth_screen
cls
echo =============================================================
echo                       ⛧ ACCESS GATE
echo =============================================================
echo.
echo Enter your key or type ADMIN to unlock admin mode.
echo Default key: 1111-1111-1111
echo.
set /p "INPUT_KEY=Key: "
if "%INPUT_KEY%"=="" goto :auth_screen
if /i "%INPUT_KEY%"=="ADMIN" goto :admin_login
call :validate_key "%INPUT_KEY%"
if "%VALID_KEY%"=="1" goto :main_menu

echo Invalid license key.
timeout /t 2 /nobreak >nul
goto :auth_screen

:admin_login
cls
echo =============================================================
echo                       ⛧ ADMIN LOGIN
echo =============================================================
echo.
set /p "ADMIN_INPUT=Admin password: "
if /i "%ADMIN_INPUT%"=="%ADMIN_PASS%" (
    set "USER_ROLE=admin"
    goto :main_menu
)

echo Admin password incorrect.
timeout /t 2 /nobreak >nul
goto :auth_screen

:validate_key
set "VALID_KEY=0"
set "TARGET=%~1"
powershell -NoLogo -NoProfile -Command "$target = '%TARGET%'; $path = '%KEY_FILE%'; $now = [DateTime]::UtcNow; $ok = $false; if($target -eq '1111-1111-1111'){ $ok = $true }; if(Test-Path $path){ foreach($line in Get-Content -Path $path -ErrorAction SilentlyContinue){ if([string]::IsNullOrWhiteSpace($line)){ continue }; $parts = $line.Split('|'); if($parts.Length -ge 4){ $key = $parts[0].Trim(); $exp = [DateTime]::ParseExact($parts[1].Trim(),'yyyy-MM-dd HH:mm:ss',[System.Globalization.CultureInfo]::InvariantCulture); $status = $parts[2].Trim(); if($key -eq $target -and $status -eq 'active' -and $exp -gt $now){ $ok = $true; break } } } }; if($ok){ exit 0 } else { exit 1 }"
if errorlevel 1 exit /b
set "VALID_KEY=1"
exit /b

:main_menu
cls
title ⛧
echo =============================================================
echo                        ⛧ MAIN MENU
echo =============================================================
echo.
echo 1. Identity Tools
echo 2. Username Tools
echo 3. World IP Generator
echo 4. Profile Builder
echo 5. Encrypt / Decrypt
echo 6. Key Manager
echo 7. VPN Tools
echo 8. God Mode Folder
echo 9. Self Test
echo 10. Notes
echo 99. Exit
echo.
if defined USER_ROLE if /i "%USER_ROLE%"=="admin" echo [ADMIN MODE ACTIVE]
if defined USER_ROLE if /i "%USER_ROLE%"=="admin" echo 100. Admin Console
set /p "CHOICE=Choose an option: "

if /i "%CHOICE%"=="1" goto :identity_tools
if /i "%CHOICE%"=="2" goto :username_tools
if /i "%CHOICE%"=="3" goto :world_ip_generator
if /i "%CHOICE%"=="4" goto :profile_builder
if /i "%CHOICE%"=="5" goto :encrypt_menu
if /i "%CHOICE%"=="6" goto :key_manager
if /i "%CHOICE%"=="7" goto :vpn_tools
if /i "%CHOICE%"=="8" goto :god_mode
if /i "%CHOICE%"=="9" goto :self_test
if /i "%CHOICE%"=="10" goto :notes
if /i "%CHOICE%"=="99" goto :exit_app
if defined USER_ROLE if /i "%USER_ROLE%"=="admin" if /i "%CHOICE%"=="100" goto :admin_console

echo Invalid option.
pause
goto :main_menu

:identity_tools
cls
echo =============================================================
echo                    ⛧ IDENTITY TOOLS
echo =============================================================
echo.
powershell -NoLogo -NoProfile -Command "$first=@('Aiden','Aria','Blake','Cora','Derek','Elena','Finn','Gina','Harper','Iris','Jules','Kira','Luca','Maya','Nolan','Opal','Parker','Quinn','Rhea','Soren','Tessa','Umar','Vera','Wes','Xena','Yara','Zane'); $last=@('Avery','Bennett','Carter','Drake','Everett','Foster','Graham','Hawkins','Irwin','Jordan','Keller','Lowe','Morris','Nash','Owens','Pace','Quinn','Rowe','Stone','Turner','Underwood','Voss','Wilder','Yates','Zen'); $username=$first[(Get-Random -Minimum 0 -Maximum $first.Length)] + $last[(Get-Random -Minimum 0 -Maximum $last.Length)]; $number=(Get-Random -Minimum 1000 -Maximum 9999); $email=($username.ToLower() + $number.ToString() + '@mailbox.io'); $ip=@('8.8.8.8','1.1.1.1','45.76.15.9','23.95.10.22','104.16.120.45','89.45.67.12','185.52.56.42','103.17.86.8','221.123.36.78','212.52.134.61'); Write-Output ('Username: ' + $username); Write-Output ('Email: ' + $email); Write-Output ('Number: ' + $number); Write-Output ('IP: ' + $ip[(Get-Random -Minimum 0 -Maximum $ip.Length)])"
pause
goto :main_menu

:username_tools
cls
echo =============================================================
echo                    ⛧ USERNAME TOOLS
echo =============================================================
echo.
echo 1. Random username
echo 2. Random email
echo 3. Random number
echo 4. Back
set /p "USER_CHOICE=Choose: "
if /i "%USER_CHOICE%"=="1" goto :random_username
if /i "%USER_CHOICE%"=="2" goto :random_email
if /i "%USER_CHOICE%"=="3" goto :random_number
if /i "%USER_CHOICE%"=="4" goto :main_menu
goto :username_tools

:random_username
cls
powershell -NoLogo -NoProfile -Command "$prefix=@('vanta','nova','crimson','echo','atlas','ember','drift','orbit','pixel','raven','swift','focus'); $suffix=@('byte','core','line','north','edge','loop','zero','vibe','track','wave','drive','flux'); $num=(Get-Random -Minimum 100 -Maximum 9999); Write-Output ($prefix[(Get-Random -Minimum 0 -Maximum $prefix.Length)] + $suffix[(Get-Random -Minimum 0 -Maximum $suffix.Length)] + $num)"
pause
goto :username_tools

:random_email
cls
powershell -NoLogo -NoProfile -Command "$parts=@('alpha','orbit','cinder','nova','dyne','synth','vanta','matrix','brisk','north','swift','axis'); $domain=@('mailbox.io','cloudmail.net','signalmail.com','northmail.cc','echohub.dev'); $user=$parts[(Get-Random -Minimum 0 -Maximum $parts.Length)] + (Get-Random -Minimum 100 -Maximum 9999); $domainName=$domain[(Get-Random -Minimum 0 -Maximum $domain.Length)]; Write-Output ($user + '@' + $domainName)"
pause
goto :username_tools

:random_number
cls
powershell -NoLogo -NoProfile -Command "$a=(Get-Random -Minimum 1000 -Maximum 9999); $b=(Get-Random -Minimum 100 -Maximum 999); $c=(Get-Random -Minimum 1000 -Maximum 9999); Write-Output ($a.ToString() + '-' + $b.ToString() + '-' + $c.ToString())"
pause
goto :username_tools

:world_ip_generator
cls
echo =============================================================
echo                    ⛧ WORLD IP GENERATOR
echo =============================================================
echo.
powershell -NoLogo -NoProfile -Command "$ips=@('8.8.8.8','1.1.1.1','45.76.15.9','89.45.67.12','104.16.120.45','185.52.56.42','207.46.136.24','203.0.113.18','176.58.100.12','212.52.134.61','51.91.82.10','103.17.86.8','34.117.59.81','170.64.0.10','221.123.36.78'); Write-Output ('Random IP: ' + $ips[(Get-Random -Minimum 0 -Maximum $ips.Length)])"
pause
goto :main_menu

:profile_builder
cls
echo =============================================================
echo                     ⛧ PROFILE BUILDER
echo =============================================================
echo.
set /p "PROFILE_NAME=Profile name: "
if "%PROFILE_NAME%"=="" set "PROFILE_NAME=default"
set /p "PROFILE_USER=Username: "
if "%PROFILE_USER%"=="" set "PROFILE_USER=%USERNAME%"
set /p "PROFILE_EMAIL=Email: "
if "%PROFILE_EMAIL%"=="" set "PROFILE_EMAIL=unknown@mailbox.io"
set /p "PROFILE_REGION=Region: "
if "%PROFILE_REGION%"=="" set "PROFILE_REGION=Global"
set /p "PROFILE_ID=IP or ID: "
if "%PROFILE_ID%"=="" set "PROFILE_ID=Auto-generated"
set "PROFILE_FILE=%PROFILE_DIR%\%PROFILE_NAME%.profile.txt"
set "PROFILE_JSON=%PROFILE_DIR%\%PROFILE_NAME%.json"
> "%PROFILE_FILE%" echo Profile Name: %PROFILE_NAME%
>> "%PROFILE_FILE%" echo Username: %PROFILE_USER%
>> "%PROFILE_FILE%" echo Email: %PROFILE_EMAIL%
>> "%PROFILE_FILE%" echo Region: %PROFILE_REGION%
>> "%PROFILE_FILE%" echo IP / ID: %PROFILE_ID%
>> "%PROFILE_FILE%" echo Created: %date% %time%
> "%PROFILE_JSON%" echo {
>> "%PROFILE_JSON%" echo   "name": "%PROFILE_NAME%",
>> "%PROFILE_JSON%" echo   "username": "%PROFILE_USER%",
>> "%PROFILE_JSON%" echo   "email": "%PROFILE_EMAIL%",
>> "%PROFILE_JSON%" echo   "region": "%PROFILE_REGION%",
>> "%PROFILE_JSON%" echo   "id": "%PROFILE_ID%"
>> "%PROFILE_JSON%" echo }
set "ACTIVE_PROFILE=%PROFILE_FILE%"
set "ACTIVE_JSON=%PROFILE_JSON%"

type "%PROFILE_FILE%"
echo.
echo Saved to %PROFILE_FILE%
pause
goto :main_menu

:encrypt_menu
cls
echo =============================================================
echo                    ⛧ ENCRYPT / DECRYPT
echo =============================================================
echo.
echo 1. Encrypt text
echo 2. Decrypt text
echo 3. Encrypt file
echo 4. Decrypt file
echo 5. Choose encryption type
echo 6. Back
echo.
if "%CRYPTO_ALG%"=="" set "CRYPTO_ALG=AES256"
echo Active algorithm: %CRYPTO_ALG%
echo.
set /p "ENC_CHOICE=Choose: "
if /i "%ENC_CHOICE%"=="1" set "ENC_MODE=TEXT_ENCRYPT" & goto :crypto_prompt
if /i "%ENC_CHOICE%"=="2" set "ENC_MODE=TEXT_DECRYPT" & goto :crypto_prompt
if /i "%ENC_CHOICE%"=="3" set "ENC_MODE=FILE_ENCRYPT" & goto :crypto_prompt
if /i "%ENC_CHOICE%"=="4" set "ENC_MODE=FILE_DECRYPT" & goto :crypto_prompt
if /i "%ENC_CHOICE%"=="5" goto :crypto_algo_menu
if /i "%ENC_CHOICE%"=="6" goto :main_menu
goto :encrypt_menu

:crypto_algo_menu
cls
echo =============================================================
echo                 ⛧ ENCRYPTION TYPES
echo =============================================================
echo.
echo 1. XOR         (basic)
echo 2. AES-128     (fast modern)
echo 3. AES-192     (stronger)
echo 4. AES-256     (strongest default)
echo 5. TripleDES   (legacy strong)
echo 6. RC2         (custom flexible)
echo 7. Back
echo.
set /p "CRYPTO_ALG_CHOICE=Choose algorithm: "
if /i "%CRYPTO_ALG_CHOICE%"=="1" set "CRYPTO_ALG=XOR" & goto :encrypt_menu
if /i "%CRYPTO_ALG_CHOICE%"=="2" set "CRYPTO_ALG=AES128" & goto :encrypt_menu
if /i "%CRYPTO_ALG_CHOICE%"=="3" set "CRYPTO_ALG=AES192" & goto :encrypt_menu
if /i "%CRYPTO_ALG_CHOICE%"=="4" set "CRYPTO_ALG=AES256" & goto :encrypt_menu
if /i "%CRYPTO_ALG_CHOICE%"=="5" set "CRYPTO_ALG=TRIPLEDES" & goto :encrypt_menu
if /i "%CRYPTO_ALG_CHOICE%"=="6" set "CRYPTO_ALG=RC2" & goto :encrypt_menu
if /i "%CRYPTO_ALG_CHOICE%"=="7" goto :encrypt_menu
echo Invalid encryption type.
pause
goto :crypto_algo_menu

:crypto_prompt
if "%CRYPTO_ALG%"=="" set "CRYPTO_ALG=AES256"
if /i "%ENC_MODE%"=="TEXT_ENCRYPT" (
    cls
    set /p "ENC_TEXT=Text to encrypt: "
    if "%ENC_TEXT%"=="" goto :encrypt_menu
    set /p "ENC_PASS=Password: "
    if "%ENC_PASS%"=="" set "ENC_PASS=⛧-RED-KEY-2026"
    powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$alg='%CRYPTO_ALG%'; $pass='%ENC_PASS%'; $text='%ENC_TEXT%'; $md = [System.Security.Cryptography.SHA256]::Create(); $keyBytes = $md.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($pass + '⛧SECURE')); $iv = New-Object byte[] 16; for($i=0; $i -lt 16; $i++){ $iv[$i] = $keyBytes[$i] }; switch($alg){ 'XOR' { $salt = [System.Text.Encoding]::UTF8.GetBytes($pass + 'XOR'); $out = New-Object byte[] $text.Length; for($i=0; $i -lt $text.Length; $i++){ $out[$i] = [byte]([char]$text[$i] -bxor $salt[$i %% $salt.Length]) }; [Convert]::ToBase64String($out) } 'AES128' { $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 128; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..15]); $aes.IV = $iv; $enc = $aes.CreateEncryptor(); $ms = New-Object System.IO.MemoryStream; $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $enc, [System.Security.Cryptography.CryptoStreamMode]::Write); $sw = New-Object System.IO.StreamWriter($cs); $sw.Write($text); $sw.Close(); $cs.Close(); [Convert]::ToBase64String($ms.ToArray()) } 'AES192' { $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 192; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..23]); $aes.IV = $iv; $enc = $aes.CreateEncryptor(); $ms = New-Object System.IO.MemoryStream; $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $enc, [System.Security.Cryptography.CryptoStreamMode]::Write); $sw = New-Object System.IO.StreamWriter($cs); $sw.Write($text); $sw.Close(); $cs.Close(); [Convert]::ToBase64String($ms.ToArray()) } 'AES256' { $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 256; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..31]); $aes.IV = $iv; $enc = $aes.CreateEncryptor(); $ms = New-Object System.IO.MemoryStream; $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $enc, [System.Security.Cryptography.CryptoStreamMode]::Write); $sw = New-Object System.IO.StreamWriter($cs); $sw.Write($text); $sw.Close(); $cs.Close(); [Convert]::ToBase64String($ms.ToArray()) } 'TRIPLEDES' { $td = [System.Security.Cryptography.TripleDESCryptoServiceProvider]::new(); $td.Key = ($keyBytes[0..23]); $td.IV = $iv; $td.Mode = [System.Security.Cryptography.CipherMode]::CBC; $td.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $enc = $td.CreateEncryptor(); $ms = New-Object System.IO.MemoryStream; $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $enc, [System.Security.Cryptography.CryptoStreamMode]::Write); $sw = New-Object System.IO.StreamWriter($cs); $sw.Write($text); $sw.Close(); $cs.Close(); [Convert]::ToBase64String($ms.ToArray()) } 'RC2' { $rc = [System.Security.Cryptography.RC2CryptoServiceProvider]::new(); $rc.Key = ($keyBytes[0..15]); $rc.IV = $iv; $rc.Mode = [System.Security.Cryptography.CipherMode]::CBC; $rc.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $enc = $rc.CreateEncryptor(); $ms = New-Object System.IO.MemoryStream; $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $enc, [System.Security.Cryptography.CryptoStreamMode]::Write); $sw = New-Object System.IO.StreamWriter($cs); $sw.Write($text); $sw.Close(); $cs.Close(); [Convert]::ToBase64String($ms.ToArray()) } default { $text } }"
    pause
    goto :main_menu
)
if /i "%ENC_MODE%"=="TEXT_DECRYPT" (
    cls
    set /p "DEC_TEXT=Text to decrypt: "
    if "%DEC_TEXT%"=="" goto :encrypt_menu
    set /p "ENC_PASS=Password: "
    if "%ENC_PASS%"=="" set "ENC_PASS=⛧-RED-KEY-2026"
    powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$alg='%CRYPTO_ALG%'; $pass='%ENC_PASS%'; $encText='%DEC_TEXT%'; $md = [System.Security.Cryptography.SHA256]::Create(); $keyBytes = $md.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($pass + '⛧SECURE')); $iv = New-Object byte[] 16; for($i=0; $i -lt 16; $i++){ $iv[$i] = $keyBytes[$i] }; switch($alg){ 'XOR' { $salt = [System.Text.Encoding]::UTF8.GetBytes($pass + 'XOR'); $data = [Convert]::FromBase64String($encText); $out = New-Object char[] $data.Length; for($i=0; $i -lt $data.Length; $i++){ $out[$i] = [char]([byte]($data[$i] -bxor $salt[$i %% $salt.Length])) }; [string]::new($out) } 'AES128' { $data = [Convert]::FromBase64String($encText); $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 128; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..15]); $aes.IV = $iv; $dec = $aes.CreateDecryptor(); $ms = New-Object System.IO.MemoryStream($data); $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $dec, [System.Security.Cryptography.CryptoStreamMode]::Read); $sr = New-Object System.IO.StreamReader($cs); $sr.ReadToEnd() } 'AES192' { $data = [Convert]::FromBase64String($encText); $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 192; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..23]); $aes.IV = $iv; $dec = $aes.CreateDecryptor(); $ms = New-Object System.IO.MemoryStream($data); $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $dec, [System.Security.Cryptography.CryptoStreamMode]::Read); $sr = New-Object System.IO.StreamReader($cs); $sr.ReadToEnd() } 'AES256' { $data = [Convert]::FromBase64String($encText); $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 256; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..31]); $aes.IV = $iv; $dec = $aes.CreateDecryptor(); $ms = New-Object System.IO.MemoryStream($data); $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $dec, [System.Security.Cryptography.CryptoStreamMode]::Read); $sr = New-Object System.IO.StreamReader($cs); $sr.ReadToEnd() } 'TRIPLEDES' { $data = [Convert]::FromBase64String($encText); $td = [System.Security.Cryptography.TripleDESCryptoServiceProvider]::new(); $td.Key = ($keyBytes[0..23]); $td.IV = $iv; $td.Mode = [System.Security.Cryptography.CipherMode]::CBC; $td.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $dec = $td.CreateDecryptor(); $ms = New-Object System.IO.MemoryStream($data); $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $dec, [System.Security.Cryptography.CryptoStreamMode]::Read); $sr = New-Object System.IO.StreamReader($cs); $sr.ReadToEnd() } 'RC2' { $data = [Convert]::FromBase64String($encText); $rc = [System.Security.Cryptography.RC2CryptoServiceProvider]::new(); $rc.Key = ($keyBytes[0..15]); $rc.IV = $iv; $rc.Mode = [System.Security.Cryptography.CipherMode]::CBC; $rc.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $dec = $rc.CreateDecryptor(); $ms = New-Object System.IO.MemoryStream($data); $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $dec, [System.Security.Cryptography.CryptoStreamMode]::Read); $sr = New-Object System.IO.StreamReader($cs); $sr.ReadToEnd() } default { $encText } }"
    pause
    goto :main_menu
)
if /i "%ENC_MODE%"=="FILE_ENCRYPT" (
    cls
    set /p "FILE_IN=File to encrypt: "
    if not exist "%FILE_IN%" (
        echo File not found.
        pause
        goto :encrypt_menu
    )
    set /p "ENC_PASS=Password: "
    if "%ENC_PASS%"=="" set "ENC_PASS=⛧-RED-KEY-2026"
    set "OUT_FILE=%FILE_IN%.enc"
    powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$alg='%CRYPTO_ALG%'; $pass='%ENC_PASS%'; $src='%FILE_IN%'; $dst='%OUT_FILE%'; $data = [System.IO.File]::ReadAllBytes($src); $md = [System.Security.Cryptography.SHA256]::Create(); $keyBytes = $md.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($pass + '⛧SECURE')); $iv = New-Object byte[] 16; for($i = 0; $i -lt 16; $i++){ $iv[$i] = $keyBytes[$i] }; switch($alg){ 'XOR' { $salt = [System.Text.Encoding]::UTF8.GetBytes($pass + 'XOR'); $out = New-Object byte[] $data.Length; for($i = 0; $i -lt $data.Length; $i++){ $out[$i] = [byte]($data[$i] -bxor $salt[$i %% $salt.Length]) }; [System.IO.File]::WriteAllBytes($dst, $out) } 'AES128' { $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 128; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..15]); $aes.IV = $iv; $enc = $aes.CreateEncryptor(); $ms = New-Object System.IO.MemoryStream; $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $enc, [System.Security.Cryptography.CryptoStreamMode]::Write); $cs.Write($data,0,$data.Length); $cs.FlushFinalBlock(); [System.IO.File]::WriteAllBytes($dst, $ms.ToArray()) } 'AES192' { $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 192; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..23]); $aes.IV = $iv; $enc = $aes.CreateEncryptor(); $ms = New-Object System.IO.MemoryStream; $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $enc, [System.Security.Cryptography.CryptoStreamMode]::Write); $cs.Write($data,0,$data.Length); $cs.FlushFinalBlock(); [System.IO.File]::WriteAllBytes($dst, $ms.ToArray()) } 'AES256' { $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 256; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..31]); $aes.IV = $iv; $enc = $aes.CreateEncryptor(); $ms = New-Object System.IO.MemoryStream; $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $enc, [System.Security.Cryptography.CryptoStreamMode]::Write); $cs.Write($data,0,$data.Length); $cs.FlushFinalBlock(); [System.IO.File]::WriteAllBytes($dst, $ms.ToArray()) } 'TRIPLEDES' { $td = [System.Security.Cryptography.TripleDESCryptoServiceProvider]::new(); $td.Key = ($keyBytes[0..23]); $td.IV = $iv; $td.Mode = [System.Security.Cryptography.CipherMode]::CBC; $td.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $enc = $td.CreateEncryptor(); $ms = New-Object System.IO.MemoryStream; $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $enc, [System.Security.Cryptography.CryptoStreamMode]::Write); $cs.Write($data,0,$data.Length); $cs.FlushFinalBlock(); [System.IO.File]::WriteAllBytes($dst, $ms.ToArray()) } 'RC2' { $rc = [System.Security.Cryptography.RC2CryptoServiceProvider]::new(); $rc.Key = ($keyBytes[0..15]); $rc.IV = $iv; $rc.Mode = [System.Security.Cryptography.CipherMode]::CBC; $rc.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $enc = $rc.CreateEncryptor(); $ms = New-Object System.IO.MemoryStream; $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $enc, [System.Security.Cryptography.CryptoStreamMode]::Write); $cs.Write($data,0,$data.Length); $cs.FlushFinalBlock(); [System.IO.File]::WriteAllBytes($dst, $ms.ToArray()) } default { [System.IO.File]::WriteAllBytes($dst, $data) } }"
    echo Encrypted: %OUT_FILE%
    pause
    goto :main_menu
)
if /i "%ENC_MODE%"=="FILE_DECRYPT" (
    cls
    set /p "FILE_IN=Encrypted file: "
    if not exist "%FILE_IN%" (
        echo File not found.
        pause
        goto :encrypt_menu
    )
    set /p "ENC_PASS=Password: "
    if "%ENC_PASS%"=="" set "ENC_PASS=⛧-RED-KEY-2026"
    set "OUT_FILE=%FILE_IN%"
    if /i "%FILE_IN:~-4%"==".enc" set "OUT_FILE=%FILE_IN:~0,-4%"
    if "%OUT_FILE%"=="%FILE_IN%" set "OUT_FILE=%FILE_IN%.decrypted"
    powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$alg='%CRYPTO_ALG%'; $pass='%ENC_PASS%'; $src='%FILE_IN%'; $dst='%OUT_FILE%'; $data = [System.IO.File]::ReadAllBytes($src); $md = [System.Security.Cryptography.SHA256]::Create(); $keyBytes = $md.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($pass + '⛧SECURE')); $iv = New-Object byte[] 16; for($i = 0; $i -lt 16; $i++){ $iv[$i] = $keyBytes[$i] }; switch($alg){ 'XOR' { $salt = [System.Text.Encoding]::UTF8.GetBytes($pass + 'XOR'); $out = New-Object byte[] $data.Length; for($i = 0; $i -lt $data.Length; $i++){ $out[$i] = [byte]($data[$i] -bxor $salt[$i %% $salt.Length]) }; [System.IO.File]::WriteAllBytes($dst, $out) } 'AES128' { $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 128; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..15]); $aes.IV = $iv; $dec = $aes.CreateDecryptor(); $ms = New-Object System.IO.MemoryStream($data); $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $dec, [System.Security.Cryptography.CryptoStreamMode]::Read); $out = New-Object System.IO.MemoryStream; $buf = New-Object byte[] 4096; while(($read = $cs.Read($buf,0,$buf.Length)) -gt 0){ $out.Write($buf,0,$read) }; [System.IO.File]::WriteAllBytes($dst, $out.ToArray()) } 'AES192' { $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 192; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..23]); $aes.IV = $iv; $dec = $aes.CreateDecryptor(); $ms = New-Object System.IO.MemoryStream($data); $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $dec, [System.Security.Cryptography.CryptoStreamMode]::Read); $out = New-Object System.IO.MemoryStream; $buf = New-Object byte[] 4096; while(($read = $cs.Read($buf,0,$buf.Length)) -gt 0){ $out.Write($buf,0,$read) }; [System.IO.File]::WriteAllBytes($dst, $out.ToArray()) } 'AES256' { $aes = [System.Security.Cryptography.Aes]::Create(); $aes.KeySize = 256; $aes.BlockSize = 128; $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC; $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $aes.Key = ($keyBytes[0..31]); $aes.IV = $iv; $dec = $aes.CreateDecryptor(); $ms = New-Object System.IO.MemoryStream($data); $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $dec, [System.Security.Cryptography.CryptoStreamMode]::Read); $out = New-Object System.IO.MemoryStream; $buf = New-Object byte[] 4096; while(($read = $cs.Read($buf,0,$buf.Length)) -gt 0){ $out.Write($buf,0,$read) }; [System.IO.File]::WriteAllBytes($dst, $out.ToArray()) } 'TRIPLEDES' { $td = [System.Security.Cryptography.TripleDESCryptoServiceProvider]::new(); $td.Key = ($keyBytes[0..23]); $td.IV = $iv; $td.Mode = [System.Security.Cryptography.CipherMode]::CBC; $td.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $dec = $td.CreateDecryptor(); $ms = New-Object System.IO.MemoryStream($data); $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $dec, [System.Security.Cryptography.CryptoStreamMode]::Read); $out = New-Object System.IO.MemoryStream; $buf = New-Object byte[] 4096; while(($read = $cs.Read($buf,0,$buf.Length)) -gt 0){ $out.Write($buf,0,$read) }; [System.IO.File]::WriteAllBytes($dst, $out.ToArray()) } 'RC2' { $rc = [System.Security.Cryptography.RC2CryptoServiceProvider]::new(); $rc.Key = ($keyBytes[0..15]); $rc.IV = $iv; $rc.Mode = [System.Security.Cryptography.CipherMode]::CBC; $rc.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7; $dec = $rc.CreateDecryptor(); $ms = New-Object System.IO.MemoryStream($data); $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $dec, [System.Security.Cryptography.CryptoStreamMode]::Read); $out = New-Object System.IO.MemoryStream; $buf = New-Object byte[] 4096; while(($read = $cs.Read($buf,0,$buf.Length)) -gt 0){ $out.Write($buf,0,$read) }; [System.IO.File]::WriteAllBytes($dst, $out.ToArray()) } default { [System.IO.File]::WriteAllBytes($dst, $data) } }"
    echo Decrypted: %OUT_FILE%
    pause
goto :main_menu
)

:key_manager
cls
echo =============================================================
echo                     ⛧ KEY MANAGER
echo =============================================================
echo.
echo 1. Generate key
echo 2. View keys
echo 3. Check key
echo 4. Back
set /p "KEY_ACTION=Choose: "
if /i "%KEY_ACTION%"=="1" goto :generate_key
if /i "%KEY_ACTION%"=="2" goto :list_keys
if /i "%KEY_ACTION%"=="3" goto :check_key
if /i "%KEY_ACTION%"=="4" goto :main_menu
goto :key_manager

:generate_key
cls
set /p "K_LABEL=Key label: "
if "%K_LABEL%"=="" set "K_LABEL=custom"
set /p "K_DAYS=Days (1,3,7,14,30): "
if "%K_DAYS%"=="" set "K_DAYS=7"
for /f "delims=" %%G in ('powershell -NoLogo -NoProfile -Command "$rng = [System.Random]::new(); $parts = @(); 1..4 | ForEach-Object { $parts += $rng.Next(1000, 9999) }; $key = ($parts -join '-'); $exp = (Get-Date).AddDays(%K_DAYS%).ToString('yyyy-MM-dd HH:mm:ss'); $label = '%K_LABEL%'; $path = '%KEY_FILE%'; $lines = @(); if(Test-Path $path){ $lines = @(Get-Content -Path $path -ErrorAction SilentlyContinue) }; $lines += ($key + '|' + $exp + '|active|' + $label); Set-Content -Path $path -Value $lines; Write-Output $key"') do set "NEW_KEY=%%G"
>> "%LOG_DIR%\key_log.txt" echo %NEW_KEY%^|%date% %time%
echo Generated key: %NEW_KEY%
echo Expires in %K_DAYS% day(s).
pause
goto :main_menu

:list_keys
cls
echo =============================================================
echo                       ⛧ ACTIVE KEYS
echo =============================================================
echo.
if exist "%KEY_FILE%" type "%KEY_FILE%" else echo No keys found.
pause
goto :main_menu

:check_key
cls
set /p "CHECK_KEY=Enter key to verify: "
if "%CHECK_KEY%"=="" goto :key_manager
call :validate_key "%CHECK_KEY%"
if "%VALID_KEY%"=="1" (
    echo Key valid and active.
) else (
    echo Key invalid or expired.
)
pause
goto :main_menu

:admin_console
cls
echo =============================================================
echo                     ⛧ ADMIN CONSOLE
echo =============================================================
echo.
echo 1. View keys
echo 2. Revoke a key
echo 3. Back
set /p "ADMIN_MENU=Choose: "
if /i "%ADMIN_MENU%"=="1" goto :list_keys
if /i "%ADMIN_MENU%"=="2" goto :revoke_key
if /i "%ADMIN_MENU%"=="3" goto :main_menu
goto :admin_console

:revoke_key
cls
set /p "REVOKE_KEY=Key to revoke: "
if "%REVOKE_KEY%"=="" goto :admin_console
powershell -NoLogo -NoProfile -Command "$path = '%KEY_FILE%'; $target = '%REVOKE_KEY%'; if(Test-Path $path){ $lines = @(); foreach($line in Get-Content -Path $path -ErrorAction SilentlyContinue){ $parts = $line.Split('|'); if($parts.Length -ge 3){ if($parts[0].Trim() -eq $target){ $parts[2] = 'revoked'; $line = ($parts -join '|') } }; $lines += $line }; Set-Content -Path $path -Value $lines }; Write-Output 'Key update complete.'"
pause
goto :admin_console

:vpn_tools
cls
echo =============================================================
echo                     ⛧ VPN TOOLS
echo =============================================================
echo.
echo 1. Open VPN settings
echo 2. Show saved VPN profiles
echo 3. Disconnect VPN
echo 4. Back
set /p "VPN_CHOICE=Choose: "
if /i "%VPN_CHOICE%"=="1" (
    start ms-settings:network-vpn
    goto :main_menu
)
if /i "%VPN_CHOICE%"=="2" (
    powershell -NoLogo -NoProfile -Command "Get-VpnConnection | Format-Table -AutoSize"
    pause
    goto :main_menu
)
if /i "%VPN_CHOICE%"=="3" (
    powershell -NoLogo -NoProfile -Command "Get-VpnConnection | ForEach-Object { $name = $_.Name; if($name){ Rasdial $name /DISCONNECT | Out-Null } }"
    echo Disconnect request sent.
    pause
    goto :main_menu
)
if /i "%VPN_CHOICE%"=="4" goto :main_menu
goto :vpn_tools

:god_mode
cls
echo =============================================================
echo                     ⛧ GOD MODE
echo =============================================================
echo.
set "GOD_MODE_PATH=%USERPROFILE%\Desktop\God Mode.{ED7BA470-8E54-465E-A066-3E5A0D6F6E7A}"
if not exist "%GOD_MODE_PATH%" mkdir "%GOD_MODE_PATH%"
echo Created: %GOD_MODE_PATH%
pause
goto :main_menu

:notes
cls
echo =============================================================
echo                       ⛧ NOTES
echo =============================================================
echo.
echo 1. View notes
echo 2. Add note
echo 3. Back
set /p "NOTE_CHOICE=Choose: "
if /i "%NOTE_CHOICE%"=="1" (
    if exist "%NOTES_FILE%" type "%NOTES_FILE%" else echo No notes yet.
    pause
    goto :main_menu
)
if /i "%NOTE_CHOICE%"=="2" (
    set /p "NEW_NOTE=New note: "
    if not "%NEW_NOTE%"=="" >> "%NOTES_FILE%" echo %NEW_NOTE%
    goto :notes
)
if /i "%NOTE_CHOICE%"=="3" goto :main_menu
goto :notes

:self_test
cls
echo =============================================================
echo                     ⛧ SELF TEST
echo =============================================================
echo.
set "SELF_OK=1"
if not exist "%PROFILE_DIR%" set "SELF_OK=0"
if not exist "%LOG_DIR%" set "SELF_OK=0"
if not exist "%KEY_FILE%" set "SELF_OK=0"
call :validate_key "1111-1111-1111"
if "%VALID_KEY%"=="0" set "SELF_OK=0"
powershell -NoLogo -NoProfile -Command "$txt='test-token';$key='RED-KEY-2026';$bytes=[System.Text.Encoding]::UTF8.GetBytes($txt);$k=[System.Text.Encoding]::UTF8.GetBytes($key);$out=New-Object System.Collections.Generic.List[byte];for($i=0;$i -lt $bytes.Length;$i++){ $out.Add([byte]($bytes[$i] -bxor $k[$i %% $k.Length])) }; $enc=[Convert]::ToBase64String($out.ToArray()); $raw=[System.Convert]::FromBase64String($enc); $dec=New-Object System.Collections.Generic.List[byte]; for($i=0;$i -lt $raw.Length;$i++){ $dec.Add([byte]($raw[$i] -bxor $k[$i %% $k.Length])) }; if([System.Text.Encoding]::UTF8.GetString($dec.ToArray()) -ne 'test-token'){ exit 1 }"
if errorlevel 1 set "SELF_OK=0"
if "%SELF_OK%"=="1" (
    echo Self test passed.
) else (
    echo Self test failed.
)
pause
goto :main_menu

:exit_app
cls
echo =============================================================
echo                     ⛧ THANKS FOR USING ⛧
echo =============================================================
echo.
>> "%LOG_DIR%\grave_log.txt" echo [%date% %time%] App closed
exit /b 0

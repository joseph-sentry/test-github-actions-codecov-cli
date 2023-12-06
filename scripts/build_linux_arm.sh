#!/bin/sh
apt install build-essential
pip install -r requirements.txt
pip install .
python setup.py build
STATICCODECOV_LIB_PATH=$(find build/ -maxdepth 1 -type d -name 'lib.*' -print -quit | xargs -I {} sh -c "find {} -type f -name 'staticcodecov*' -print -quit | sed 's|^./||'")`
pyinstaller --add-binary ${STATICCODECOV_LIB_PATH}:. --copy-metadata codecov-cli --hidden-import staticcodecov_languages -F codecov_cli/main.py
echo $*
cp ./dist/main ./dist/codecovcli_$*
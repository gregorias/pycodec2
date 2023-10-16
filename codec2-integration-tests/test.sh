cd pycodec2
rm dist/*
pipenv run python -m build --wheel
pipenv run pip install dist/*.whl
cd test
pipenv run python -m unittest discover -s .

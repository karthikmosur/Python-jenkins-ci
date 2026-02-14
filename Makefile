.PHONY: venv install clean

venv:
	python -m venv .venv
	. .venv/bin/activate && python -m pip install --upgrade pip setuptools wheel

install: venv
	. .venv/bin/activate && pip install -r requirements.txt

clean:
	rm -rf .venv
	find . -type d -name "__pycache__" -exec rm -r {} +

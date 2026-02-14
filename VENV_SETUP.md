# Virtual environment setup

Use the provided script or Makefile to create a local virtual environment at `.venv` and install dependencies.

Linux / macOS
```bash
./scripts/setup_venv.sh
```

Or with Makefile:
```bash
make install
```

Activate the environment:
```bash
source .venv/bin/activate
```

Deactivate:
```bash
deactivate
```

Windows (PowerShell)
```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

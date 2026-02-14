#!/usr/bin/env bash
set -euo pipefail

if ! command -v python >/dev/null 2>&1; then
  echo "python not found in PATH"
  exit 1
fi

python -m venv .venv
# shellcheck source=/dev/null
source .venv/bin/activate
python -m pip install --upgrade pip setuptools wheel
if [ -f requirements.txt ]; then
  pip install -r requirements.txt
else
  echo "No requirements.txt found; created venv only."
fi

cat <<'EOF'
Virtual environment created at .venv
Activate with: source .venv/bin/activate
Deactivate with: deactivate
EOF

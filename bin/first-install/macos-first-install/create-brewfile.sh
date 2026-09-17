#!/usr/bin/env bash
# Regenerate the Brewfile from what is currently installed on this machine.
#
# Usage: create-brewfile.sh [output file]

set -o errexit
set -o pipefail
set -o nounset

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly OUT="${1:-${DIR}/Brewfile}"

if ! command -v brew &> /dev/null; then
    echo "error: Homebrew not installed" >&2
    exit 1
fi

echo "> dumping installed formulae, casks and taps to ${OUT}"
echo "# managed by create-brewfile.sh - regenerate with: brew bundle dump" > "${OUT}"
brew bundle dump --file="${OUT}" --force
echo "> done - ${OUT}"

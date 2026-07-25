#!/usr/bin/env bash
# Open the current file, at the current line or selection, in the browser.
# With no file — no editor open, or an unsaved buffer — opens the repository
# homepage instead. Designed to be spawned as a Zed task, but usable standalone.
#
# Usage:
#   open-repo-in-browser.sh [<relative-file> [<row>]]
#
# Falls back to Zed's task environment when arguments are omitted:
#   ZED_WORKTREE_ROOT, ZED_RELATIVE_FILE, ZED_ROW, ZED_SELECTED_TEXT

set -euo pipefail

die() {
  echo "open-repo-in-browser: $*" >&2
  exit 1
}

root="${ZED_WORKTREE_ROOT:-$PWD}"
rel_file="${1:-${ZED_RELATIVE_FILE:-}}"
row="${2:-${ZED_ROW:-}}"

cd "$root" || die "cannot cd into $root"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "not a git repository: $root"

# Normalize a git remote URL into a browsable https:// URL.
clean_url() {
  local url="$1"
  url="${url%.git}"
  case "$url" in
    git@*)
      local host_and_user="${url#git@}"
      local host="${host_and_user%%:*}"
      local repo="${host_and_user#*:}"
      host="${host%%+*}" # strip host aliases such as git@github.com+work:owner/repo
      url="https://${host}/${repo}"
      ;;
    ssh://*)
      url="${url#ssh://}"
      url="${url#*@}"
      local host_port="${url%%/*}" path="${url#*/}"
      url="https://${host_port%%:*}/${path}" # drop an optional :port
      ;;
    http://*|https://*)
      url="https://${url#*://}"
      url="https://${url#*@}" # strip embedded credentials
      ;;
  esac
  printf '%s' "$url"
}

# Resolve the remote to browse: the current branch's remote, else origin, else
# the first remote configured.
resolve_remote() {
  local branch="$1" remote=""
  if [[ -n "$branch" ]]; then
    remote="$(git config --get "branch.${branch}.remote" || true)"
  fi
  if [[ -z "$remote" ]] && git remote get-url origin >/dev/null 2>&1; then
    remote="origin"
  fi
  if [[ -z "$remote" ]]; then
    remote="$(git remote | head -n 1)"
  fi
  printf '%s' "$remote"
}

# Resolve the ref to browse, in decreasing order of specificity:
#   1. the upstream branch of the current branch
#   2. the current branch (assumed to exist on the remote under the same name)
#   3. the remote's default branch
#   4. the current commit sha
resolve_ref() {
  local branch="$1" remote="$2" upstream=""

  upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)"
  if [[ -n "$upstream" ]]; then
    printf '%s' "${upstream#"${remote}"/}"
    return
  fi

  if [[ -n "$branch" ]]; then
    printf '%s' "$branch"
    return
  fi

  local head_ref
  head_ref="$(git symbolic-ref "refs/remotes/${remote}/HEAD" 2>/dev/null || true)"
  if [[ -n "$head_ref" ]]; then
    printf '%s' "${head_ref#"refs/remotes/${remote}/"}"
    return
  fi

  git rev-parse HEAD
}

# Percent-encode the characters that actually show up in paths.
encode_path() {
  local path="$1" out="" char
  while IFS= read -r -n1 char; do
    case "$char" in
      [a-zA-Z0-9._~/-]) out+="$char" ;;
      '') ;;
      *) out+="$(printf '%%%02X' "'$char")" ;;
    esac
  done < <(printf '%s' "$path")
  printf '%s' "$out"
}

branch="$(git symbolic-ref --short -q HEAD || true)"
remote="$(resolve_remote "$branch")"
[[ -n "$remote" ]] || die "no git remote configured"

remote_url="$(git remote get-url "$remote" 2>/dev/null || git config --get "remote.${remote}.url" || true)"
[[ -n "$remote_url" ]] || die "no URL configured for remote '${remote}'"

url="$(clean_url "$remote_url")"

if [[ -n "$rel_file" ]]; then
  ref="$(resolve_ref "$branch" "$remote")"
  url="${url}/blob/${ref}/$(encode_path "$rel_file")"

  if [[ -n "$row" ]]; then
    # ZED_ROW is the cursor position, i.e. the end of the selection. Derive the
    # start of the selection by counting the lines it spans.
    selected="${ZED_SELECTED_TEXT:-}"
    end_line="$row"
    start_line="$row"
    if [[ -n "$selected" ]]; then
      spanned="$(printf '%s' "$selected" | grep -c '' || true)"
      start_line=$((end_line - spanned + 1))
      ((start_line < 1)) && start_line=1
    fi

    case "$rel_file" in
      *.md|*.markdown|*.mdx) url="${url}?plain=1" ;;
    esac

    if ((start_line < end_line)); then
      url="${url}#L${start_line}-L${end_line}"
    else
      url="${url}#L${end_line}"
    fi
  fi
fi

echo "$url"

if command -v open >/dev/null 2>&1; then
  open "$url"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$url"
else
  die "no browser opener found (tried 'open' and 'xdg-open')"
fi

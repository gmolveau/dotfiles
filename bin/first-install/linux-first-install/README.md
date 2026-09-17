# Linux first install — Ansible

State-based equivalent of `~/bin/linux-first-install.sh`. Mirrors the layout
of `../macos-first-install/`.

## Ansible in 2 minutes

- **Playbook** (`linux-first-install.yml`) — the entrypoint; declares which
  machines to configure (`hosts: localhost`) and which roles to apply.
- **Role** — a reusable unit of configuration. Here: `linux_first_install`
  (packages and tools) and `dotfiles` (bare-repo checkout + zsh plugins,
  shared with the macOS playbook). Each role contains:
  - `tasks/` — the steps to converge; each step is a **task**, grouped in
    one file per tool (apt, tmux, ssh, 1password, vscode, signal, docker,
    python, nodejs, databases, chrome, vlc, uv, rust, claude);
  - `defaults/` — variables with low precedence, easy to override
    (basic tools list, Node major version, dotfiles repo).
- **Become** — equivalent of sudo, only on the tasks that need it: every
  `apt` task runs with `become: true`. If sudo is already cached (e.g. from
  `sudo -v` in another shell), no password is asked.
- **Check mode** — `--check --diff` shows what *would* change, touching
  nothing. Regular sanity-check for changes.
- **Idempotence** — installing a `.deb` is skipped when up-to-date, the
  Docker installer only runs when `docker --version` fails, same guard for
  `uv`, `rustup` and `claude`, and SSH keys / tpm clones are guarded by
  `stat` checks — the shell script's `[ ! -f ... ]` tests, but declarative.

## Layout

```
linux-first-install/
├── bootstrap.sh                       # run this on a fresh machine
├── linux-first-install.yml            # playbook
└── roles/
    ├── linux_first_install/
    │   ├── defaults/main.yml          # basic tools + node major version
    │   └── tasks/*.yml                # one file per tool, imported by main.yml
    └── dotfiles/
        ├── defaults/main.yml          # repo url + zsh plugins
        └── tasks/main.yml             # bare-clone, checkout...
```

## Fresh machine flow

1. Install a Debian-based distribution, create your user account. Nothing else;
2. `bootstrap.sh` then takes over:
   - installs ansible (via apt) and rust,
   - prompts for git identity only if `user.name`/`user.email` are unset
     globally,
   - runs the playbook with `-K`.

## Day-to-day

- **Changed your system by hand?** Rerun the playbook — it converges back
  to the declared state.

## Usage

```sh
./bootstrap.sh                                # fresh machine
ansible-playbook linux-first-install.yml -K   # rerun / converge
ansible-playbook linux-first-install.yml --check --diff  # preview changes
```

## Extend

Want to add a package to the basic tools? Add it to
`roles/linux_first_install/defaults/main.yml`:

```yaml
linux_basic_tools:
  - tree
  - your-tool
```

Want a new tool? Create `tasks/<tool>.yml` and import it from
`tasks/main.yml`. Rerun. Only that one step is applied, everything else
reports `ok`.

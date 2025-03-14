export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export CARGO_BIN=${CARGO_HOME}/bin
export PATH=${PATH}:${CARGO_BIN}
[ -f "${CARGO_HOME}/env" ] && . "${CARGO_HOME}/env"

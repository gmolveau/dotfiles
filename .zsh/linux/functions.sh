function update() {
    deactivate 2> /dev/null
    sudo apt update && sudo apt -y upgrade && sudo apt -y dist-upgrade
    echo "updating npm ..."
    sudo npm install -g npm
    npm update -g
    echo "updating gem ..."
    gem update
    echo "updating cargo ..."
    cargo update
    echo "updating pip and pip apps ..."
    pip3 install --user --upgrade pip
    command -v pip-chill > /dev/null 2>&1 || pip3 install --user pip-chill
    pip-chill --no-version | xargs pip3 install -U
}

function freeze() {
    println "# apt-get packages"
    python3 -c "from apt import cache;manual = set(pkg for pkg in cache.Cache() if pkg.is_installed and not pkg.is_auto_installed);depends = set(dep_pkg.name for pkg in manual for dep in pkg.installed.get_dependencies('PreDepends', 'Depends', 'Recommends') for dep_pkg in dep);print('\n'.join(pkg.name for pkg in manual if pkg.name not in depends))"
    println "# snap packages"
    snap list | grep -v Publisher | grep -v canonical | awk '{print $1}'
    if [ -d "$HOME/bin" ]; then
        println "# user bin "
        ls -1 "$HOME/bin"
    fi
    println "# pip3 apps"
    pip-chill --no-version
    println "# golang apps "
    ls -1 ${GOBIN}
    println "# cargo apps "
    cargo install --list
    echo "# npm apps \n"
    npm list -g --depth=0
}

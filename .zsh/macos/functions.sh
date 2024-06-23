function update() {
    deactivate 2> /dev/null
    println "updating brew ..."
    brew update
    println "upgrading brew ..."
    brew upgrade
    println "cleaning brew ..."
    brew cleanup -s
    #now diagnotic
    brew doctor
    brew missing

    println "updating app store apps ..."
    mas upgrade
}

function freeze() {
    println "# /Applications"
    ls -1 /Applications
    println "# ~/Applications"
    ls -1 ~/Applications
    println "# Mac App Store apps"
    mas list | sed 's/ / # /'
    println "# brew apps"
    brew leaves
    println "# pip3 apps"
    command -v pip-chill > /dev/null 2>&1 || pip3 install pip-chill
    pip-chill --no-version
    println "# golang apps"
    ls -1 ${GOBIN}
    println "# cargo apps"
    cargo install --list
    println "# npm apps"
    npm list -g --depth=0
}

export ARCHIVE=${NEXTCLOUD}/Documents/archive

function archive-download() {
    if [ $# -eq 0 ]; then
        echo "missing argument: URL"
        exit 1
    fi
    FILE=$(wget -P "${ARCHIVE}" -nv --content-disposition "${1}" 2>&1 | cut -d\" -f2)
    FILENAME="$(basename -- "${1}")"
    EXTENSION=$([[ "${FILENAME}" = *.* ]] && echo ".${FILENAME##*.}" || echo '')
    if [ $# -eq 2 ]; then
        FILENAME="$(date +%Y-%m-%d)-$(echo "${2}" | sed -E 's/[^[:alnum:]]+/_/g')"
    fi
    mv -n "${FILE}" "${ARCHIVE}/${FILENAME}${EXTENSION}"
    echo "${ARCHIVE}/${FILENAME}${EXTENSION}"
}

function archive-youtube() {
    # shellcheck disable=SC2016
    youtube-dl -no-playlist --embed-subs --write-auto-sub -no-playlist --merge-output-format mkv --restrict-filenames -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' -o '${ARCHIVE}/$(date +%Y-%m-%d)-%(title)s.%(ext)s' "${1}"
}

function archive-web() {
    if [ $# -eq 2 ]; then
        FILENAME="$(date +%Y-%m-%d)-$(echo "${2}" | sed -E 's/[^[:alnum:]]+/_/g').html"
    elif [ $# -eq 1 ]; then
        FILENAME="$(date +%Y-%m-%d)-$(basename "${1}" | sed -E 's/[^[:alnum:]]+/_/g').html"
    elif [ $# -eq 0 ]; then
        echo "missing argument: URL"
        exit 1
    fi
    # brew install monolith | snap install monolith
    monolith -f -j -s "${1}" -o "${ARCHIVE}/${FILENAME}"
    echo "${FILENAME}"
}

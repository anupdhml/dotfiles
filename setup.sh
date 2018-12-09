#!/bin/bash
# Make symlinks for the dotfiles here to a dest dir ($HOME)
# If the dotfile is already present, backs it up
# One time operation

SOURCE_DIR="$(pwd)/data"
DEST_DIR="$HOME"

BACKUP_DIR="$(pwd)/backup"

#if [ -d "$BACKUP_DIR" ]; then
#    echo "Clearing the old backup dir ${BACKUP_DIR}"
#    rm -rf "${BACKUP_DIR}"
#fi

mkdir -p $BACKUP_DIR

pushd "$SOURCE_DIR"

# for getting only the hidden files (and not . & ..)
export GLOBIGNORE=". .."
#shopt -u dotglob
for file in .*; do
    if [ -e "${DEST_DIR}/${file}" ]; then
        echo "Backup and remove: $DEST_DIR/$file"
        cp -R "${DEST_DIR}/${file}" "${BACKUP_DIR}/" && rm -r "${DEST_DIR}/${file}"
    fi
    ln -sfv "$(pwd)/${file}" "${DEST_DIR}/"
done

popd

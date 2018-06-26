#!/usr/bin/env bash

cd "$(dirname "$(readlink -f "$0")")"/..    #'"%#@!

#sudo apt install mingw-w64
#sudo update-alternatives --config x86_64-w64-mingw32-gcc # (configure to use POSIX variant)
#sudo update-alternatives --config x86_64-w64-mingw32-g++ # (configure to use POSIX variant)

patch -p1 < ./zcutil/extra/zcash-win32.patch

HOST=x86_64-w64-mingw32 ./zcutil/build.sh --disable-tests || exit 1

cd src

cp -f zcashd.exe votecoind.exe
cp -f zcash-cli.exe votecoin-cli.exe
cp -f zcash-tx.exe votecoin-tx.exe

strip --strip-unneeded votecoind.exe
strip --strip-unneeded votecoin-cli.exe
strip --strip-unneeded votecoin-tx.exe

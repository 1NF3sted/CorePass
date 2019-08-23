#!/bin/bash
echo "============================================="
echo "CorePass Re:Sign Installer IPA"
echo "Created by 1NF3STED 2019"
echo "============================================="

if [ $# == 0 ]; then
echo "WARINING CorePass required ROOT previlegies."
echo "Usage: corepass filename.ipa."
    exit 1
fi

FILE=$1
if [ -f $FILE ]; then
    echo "CorePass -> Extracting... ${FILE%.ipa}"
	rm -rf "/var/tmp/extracted/"
    mkdir "/var/tmp/extracted/"
    unzip "$FILE" -d "/var/tmp/extracted/" >/dev/null 2>&1
    cd "/var/tmp/extracted/"
    APPLICATION=$(ls /var/tmp/extracted/Payload/)
    echo "CorePass -> Patching $APPLICATION..."
    cd "Payload/"
    TEMP=$(ls -1)
    BUNDLENAME=${TEMP%.app}
    cd "$(ls -1)"
    ldid -S "$BUNDLENAME"
    cd /var/tmp/extracted/
	echo "CorePass -> Zipping $APPLICATION"
    zip -qr "/var/tmp/${FILE%.ipa}_signed.ipa" Payload
    echo "CorePass -> Installing ${FILE%.ipa}.ipa ..."
    appinst "/var/tmp/${FILE%.ipa}_signed.ipa" >/dev/null 2>&1
    echo "CorePass -> Successfuly installed ${FILE%.ipa}..."
    echo "CorePass -> Cleanup..."
    rm -rf "/var/tmp/extracted/"
    echo "CorePass -> All job are done."
else
   echo ""
fi
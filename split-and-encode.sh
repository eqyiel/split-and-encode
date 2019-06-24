#!/bin/sh

MODULE_SIZE="3"
ERROR_CORRECTION_LEVEL="L"
DOTS_PER_INCH="150"
DIRNAME="$(dirname "${0}")"
DEST="${1}-output"

mkdir "${DIRNAME}/tmp" || :

split -C 512 "${1}" "${DIRNAME}/tmp/${1}-"

mkdir -p "${DEST}/qr" || :

for i in "${DIRNAME}/tmp/${1}-"*; do
  <"${i}" qrencode -l "${ERROR_CORRECTION_LEVEL}" -s "${MODULE_SIZE}" -d "${DOTS_PER_INCH}" -o "${DIRNAME}/${DEST}/qr/$(basename "${i}").png"
done

cat <<EOF >| "${DEST}/${1}".html
<!doctype html>
<html>
<head></head>
<body>
  <table>
EOF

for i in "${DIRNAME}/${DEST}/qr/${1}-"*; do
  cat <<EOF >> "${DEST}/${1}".html
    <tr>
      <th>$(basename "${i}")</th>
      <td><img src="qr/$(basename "${i}")"></td>
    </tr>
EOF
done

cat <<EOF >> "${DEST}/${1}".html
  </table>
</body>
EOF

rm -rf "${DIRNAME}/tmp"

# `split-and-encode`

This is a script that splits a text file into chunks, make QR codes and formats
them in a HTML table.  This is one way of backing up stuff like SSH/GPG keys on
paper.


Depends on [libqrencode](https://github.com/fukuchi/libqrencode) and GNU coreutils.

Note: a good way to check that the files can actually be reconstructed is by
diffing the output of this with the original key:

```
for i in pubkey.txt-output/qr/pubkey-*; do zbarimg --raw --quiet "$i" | head -c -1; done
```

(requires [zbar](https://github.com/ZBar/ZBar))

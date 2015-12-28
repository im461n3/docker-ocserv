#! /bin/sh
#! /usr/bin/expect -f


certtool --generate-privkey --outfile $1-key.pem
sed -i "1ccn = "${1}"" client.tmpl
sed -i "3cemail = ${2}" client.tmpl
certtool --generate-certificate --load-privkey $1-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template client.tmpl --outfile $1-cert.pem
openssl pkcs12 -export -inkey $1-key.pem -in $1-cert.pem -name "$1 VPN Client Cert" -certfile ca-cert.pem -out $1.cert.p12
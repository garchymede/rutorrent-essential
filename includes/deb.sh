#!/bin/bash

function FONCDEP ()
{
echo "#dépôt paquet propriétaire
deb http://ftp2.fr.debian.org/debian/ $1 main non-free
deb-src http://ftp2.fr.debian.org/debian/ $1 main non-free" > "$SOURCES"/non-free.list

echo "# dépôt nginx
deb http://nginx.org/packages/mainline/debian/ $1 nginx
deb-src http://nginx.org/packages/mainline/debian/ $1 nginx" > "$SOURCES"/nginx.list

# clés
wget http://www.dotdeb.org/dotdeb.gpg
apt-key add dotdeb.gpg

wget http://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key
}

function FONCDEPNGINX ()
{
#apt-get install -y nginx=1.9.6-1~"$1"
apt-get install -y nginx
echo "# dépôt nginx
deb http://nginx.org/packages/debian/ $1 nginx
deb-src http://nginx.org/packages/debian/ $1 nginx" > "$SOURCES"/nginx.list
}

# ajout dépôts
cd /tmp || exit

if [[ $VERSION =~ 7. ]]; then

DEBNUMBER="Debian_7.0.deb"
DEBNAME="wheezy"

echo "# dépôt dotdeb php 5.6
deb http://packages.dotdeb.org $DEBNAME-php56 all
deb-src http://packages.dotdeb.org $DEBNAME-php56 all" > "$SOURCES"/dotdeb-php56.list

elif [[ $VERSION =~ 8. ]]; then
# shellcheck disable=SC2034
DEBNUMBER="Debian_8.0.deb"
DEBNAME="jessie"

echo "# dépôt dotdeb
deb http://packages.dotdeb.org $DEBNAME all
deb-src http://packages.dotdeb.org $DEBNAME all" > "$SOURCES"/dotdeb.list

echo "# dépôt multimedia
deb http://www.deb-multimedia.org $DEBNAME main non-free" > "$SOURCES"/multimedia.list

# clé deb-multimedia.org
wget http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_"$DEBMULTIMEDIA"_all.deb
dpkg -i deb-multimedia-keyring_"$DEBMULTIMEDIA"_all.deb

else
	set "130" ; FONCTXT "$1" ; echo -e "${CRED}$TXT1${CEND}" ; echo ""
	exit 1
fi

# dépôts standard
FONCDEP "$DEBNAME"


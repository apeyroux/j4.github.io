+++
Categories = ["Development", "GoLang"]
Description = ""
Tags = ["Development", "golang"]
date = 2014-08-01T21:17:52Z
menu = "main"
title = "GPG & Yubi"
+++

GPG
===

Importation de la clef pub de **m at j4.pe** : gpg --recv-key 92B3B329

Yubikey
=======

Installation Debian
-------------------

``` {.bash}
apt-get install libccid libpcsclite1 pcscd scdaemon
```

Vérifier la carte GPG
---------------------

``` {.bash}
gpg --card-status
#END_SRC

#+BEGIN_SRC sh
Application ID ...: D2760001240102000000000000010000
Version ..........: 2.0
Manufacturer .....: test card
Serial number ....: 00000001
Name of cardholder: [non positionné]
Language prefs ...: [non positionné]
Sex ..............: non indiqué
URL of public key : [non positionné]
Login data .......: [non positionné]
Signature PIN ....: forcé
Key attributes ...: 2048R 2048R 2048R
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 3 3
Signature counter : 3
Signature key ....: 9A90 7406 EA0F 850A BEE7  F97D 607D EADB ADE7 0183
      created ....: 2014-02-25 16:49:12
Encryption key....: E318 4880 F203 D6C7 FEF6  4845 9F3B 75C0 4CE6 4CA5
      created ....: 2012-03-28 08:00:47
Authentication key: F9EA 99DE B87F B819 5F07  37E5 5C39 18AE 5F82 0A59
      created ....: 2014-02-25 16:49:35
General key info..: pub  2048R/ADE70183 2014-02-25 Jean-Alexandre Peyroux <m at j4.pe>
sec   2048R/92B3B329  créé : 2012-03-28  expire : jamais    
ssb>  2048R/4CE64CA5  créé : 2012-03-28  expire : jamais    
                      nº de carte : 0000 00000001
ssb>  2048R/ADE70183  créé : 2014-02-25  expire : jamais    
                      nº de carte : 0000 00000001
ssb>  2048R/5F820A59  créé : 2014-02-25  expire : jamais    
                      nº de carte : 0000 00000001
```

.xsession
---------

``` {.bash}
/etc/X11/Xsession i3
```

Configuration GPG-agent & Xsession
----------------------------------

\*/etc/X11/Xsession.d/90gpg-agent\*

``` {.bash}
: ${GNUPGHOME=$HOME/.gnupg}

GPGAGENT=/usr/bin/gpg-agent
PID_FILE="$GNUPGHOME/gpg-agent-info-$(hostname)"

if grep -qs '^[[:space:]]*use-agent' "$GNUPGHOME/gpg.conf" "$GNUPGHOME/options" &&
   test -x $GPGAGENT &&
   { test -z "$GPG_AGENT_INFO" || ! $GPGAGENT 2>/dev/null; }; then

   if [ -r "$PID_FILE" ]; then
       . "$PID_FILE"
   fi

   # Invoking gpg-agent with no arguments exits successfully if the agent
   # is already running as pointed by $GPG_AGENT_INFO
   if ! $GPGAGENT 2>/dev/null; then
       STARTUP="$GPGAGENT --daemon --enable-ssh --sh --write-env-file=$PID_FILE $STARTUP"
   fi
fi
```

Yubikey & ssh
-------------

Vérifier la clef pub

``` {.bash}
ssh-add -L
```

``` {.bash}
ssh-rsa AAAAB3Nza[...]8uCPDHnStGSiCgAOR9ZtonYB1CkFT5SFNY8ed
cardno:000000000001
```

Puis, copier cette clef pub dans le **.ssh/authorized~keys~** des
serveurs.


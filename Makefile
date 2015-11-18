GTK_PIDGIN_INCLUDES= `pkg-config --cflags gtk+-2.0 pidgin`

CC ?= clang
CFLAGS+= -O2 -Wall -fpic -fpie -g -pipe
LDFLAGS+= -shared -fPIC -Wl,-z,relro,-z,now
PREFIX=/usr
SOPATH=/lib64/pidgin

INCLUDES = \
      $(GTK_PIDGIN_INCLUDES)

xmpp-receipts.so: xmpp-receipts.c
	$(CC) xmpp-receipts.c $(CFLAGS) $(INCLUDES) $(LDFLAGS) -o xmpp-receipts.so

install: xmpp-receipts.so
	mkdir -p ${DESTDIR}${PREFIX}${SOPATH}
	chmod 444  ${DESTDIR}${PREFIX}${SOPATH}

	install -m 444 xmpp-receipts.so ${DESTDIR}${PREFIX}${SOPATH}

uninstall:
	rm -f ~/.purple/plugins/xmpp-receipts.so

clean:
	rm -f xmpp-receipts.so

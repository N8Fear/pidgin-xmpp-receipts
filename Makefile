GTK_PIDGIN_INCLUDES= `pkg-config --cflags gtk+-2.0 pidgin`

CC ?= clang
CFLAGS+= -O2 -Wall -fpic -fpie -g -pipe
LDFLAGS+= -shared -fPIC -Wl,-z,relro,-z,now

INCLUDES = \
      $(GTK_PIDGIN_INCLUDES)

xmpp-receipts.so: xmpp-receipts.c
	$(CC) xmpp-receipts.c $(CFLAGS) $(INCLUDES) $(LDFLAGS) -o xmpp-receipts.so

install: xmpp-receipts.so
	mkdir -p ~/.purple/plugins
	cp xmpp-receipts.so ~/.purple/plugins/

uninstall:
	rm -f ~/.purple/plugins/xmpp-receipts.so

clean:
	rm -f xmpp-receipts.so

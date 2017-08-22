PREFIX ?= /usr


default :

install :
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 0755 $(CURDIR)/bin/deployer-github $(DESTDIR)$(PREFIX)/bin
	install -d $(DESTDIR)/etc
	install -m 0640 $(CURDIR)/etc/deployer-github.example.conf $(DESTDIR)/etc/deployer-github.conf
	install -m 0755 -o root -g root -d $(DESTDIR)/etc/service
	tar cf - etc/service --owner root --group root | tar xf - -C $(DESTDIR)/


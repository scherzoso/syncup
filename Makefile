# SPDX-License-Identifier: 0BSD
# -----------------------------------------------------------------------------

V_MAJOR = 0
V_MINOR = 1
V_PATCH = 0
V_EXTRA =
VERSION = $(V_MAJOR).$(V_MINOR).$(V_PATCH)$(V_EXTRA)
export V_MAJOR V_MINOR V_PATCH V_EXTRA VERSION

PREFIX = /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man

-include .version.mk

all:
	@:

clean:
	rm -f syncup.1

distclean: clean
	rm -f .version.mk

man: syncup.1

install: syncup syncup.1
	scripts/atomic-install -D syncup $(DESTDIR)$(BINDIR)/syncup
	scripts/atomic-install -D -m 0644 syncup.1 $(DESTDIR)$(MANDIR)/man1/syncup.1

.version.mk:
	scripts/gen-version

syncup.1: README.adoc .version.mk
	asciidoctor -b manpage -a manmanual="Syncup Manual" -a mansource="Syncup $(VERSION)" -o $@ $<

.PHONY: all clean distclean install man

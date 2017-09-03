EMACS ?= emacs
CASK ?= cask

all: .cask test

test: clean-elc ert-runner

$(CASK_PKGS) :
	$(CASK) install

ert-runner: compile
	${CASK} exec ert-runner

compile:
	${CASK} exec ${EMACS} -Q -batch -f batch-byte-compile winnow.el

clean-elc:
	rm -f winnow.elc

.cask:
	${CASK} install

distclean: clean-elc
	rm -rf .cask

.PHONY:	all test compile clean-elc ert-runner

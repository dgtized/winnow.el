EMACS ?= emacs
CASK ?= cask
PKG_DIR := $(shell ${CASK} package-directory)

all: test

test: clean-elc ert-runner

$(CASK_PKGS) :
	$(CASK) install

ert-runner: compile
	${CASK} exec ert-runner

compile:
	${CASK} exec ${EMACS} -Q -batch -f batch-byte-compile winnow.el

clean-elc:
	rm -f winnow.elc

elpa: ${PKG_DIR}

${PKG_DIR}:
	${CASK} install
	touch $@

.PHONY:	all test compile clean-elc ert-runner

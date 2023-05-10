SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

ps-sources := $$(fd -epurs)

.PHONY: run-build
run-build:
	@spago build

.PHONY: check-format
check-format:
	@purs-tidy check ${ps-sources}

.PHONY: format
format:
	@purs-tidy format-in-place ${ps-sources}

.PHONY: open-docs
open-docs:
  # if docs where generated for the current git HEAD
  # it will skip their generation, otherwise it'd call spago docs --open
	DOCS_VERSION=$$(cat .spago-doc-git-head); \
	CURRENT_VERSION=$$(git rev-parse HEAD); \
	DOCS_ROOT=$$(pwd)/generated-docs/html/index.html; \
	if [ "$$DOCS_VERSION" == "$$CURRENT_VERSION" ]; then
		xdg-open $$DOCS_ROOT
	else
		spago docs --open && (git rev-parse HEAD > .spago-doc-git-head)
	fi

.PHONY: force-open-docs
force-open-docs: 
	DOCS_ROOT=$$(pwd)/generated-docs/html/index.html; \
	xdg-open $$DOCS_ROOT

.PHONY: regenerate-docs
regenerate-docs:
	spago docs --open && (git rev-parse HEAD > .spago-doc-git-head)


.PHONY: tag
tag:
	spago docs --format ctags
	spago docs --format etags

.PHONY: ci
ci:
	nix run .#ci

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

ps-sources := $$(fd -epurs)

check-format:
	@purs-tidy check ${ps-sources}

format:
	@purs-tidy format-in-place ${ps-sources}

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

force-open-docs: 
	DOCS_ROOT=$$(pwd)/generated-docs/html/index.html; \
	xdg-open $$DOCS_ROOT

regenerate-docs:
	spago docs --open && (git rev-parse HEAD > .spago-doc-git-head)

tag:
	spago docs --format ctags
	spago docs --format etags

ci:
	@ [[ "$$(uname -sm)" == "Linux x86_64" ]] || (echo "NOTE: CI only builds on Linux x86_64. Your system is $$(uname -sm), continuing...")
	nix build .#check.$(shell nix eval -f '<nixpkgs>' system)

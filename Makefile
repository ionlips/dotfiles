# Directories to symlink via Stow.
PACKAGES := aerospace editor ghostty git nvim shell starship tmux

# Stow command to run.
STOW := stow --ignore="\.DS_Store" --ignore="\.gitkeep" --target=${HOME}

# Check whether we are on GNU/Linux or macOS and assign a value consistent
# with the name of our directories.
UNAME_M := $(shell uname -m)
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	OS := darwin
else
	OS := linux
endif

# Once the system has been identified, check the architecture, and assign a
# value consistent with the name of our directories.
ifeq ($(filter arm64 aarch64,$(UNAME_M)),)
	ARCH := x86-64
else
	ARCH := aarch64
endif

# Binaries, their locations, and where to symlink them to.
BIN_SRC := ${CURDIR}/bin/.local/bin/${OS}/${ARCH}
LOCAL := ${HOME}/.local
BIN_DEST := ${LOCAL}/bin

# `TOOLS` are single binaries symlinked directly into `BIN_DEST`.
ifeq ($(OS),darwin)
	TOOLS := mdtoc
else
	TOOLS := clang-format fd fzf lazygit mdtoc rg shellcheck stylua tree-sitter zk
endif

.PHONY: bin restow stow unbin unstow

bin:
	@mkdir -p ${BIN_DEST}
	@for tool in ${TOOLS}; do \
		src=$$(find ${BIN_SRC}/$$tool -type f -name $$tool | head -n 1); \
		if [ -n "$$src" ]; then \
			chmod +x $$src; \
			ln -sf $$src ${BIN_DEST}/$$tool; \
			echo Linked $$tool to $$src.; \
		else \
			echo $$tool not found under ${BIN_SRC}.; \
		fi; \
	done
ifeq ($(OS),darwin)
	@xattr -dr com.apple.quarantine ${BIN_SRC}
endif

restow: bin
	${STOW} --restow ${PACKAGES}

stow: bin
	${STOW} ${PACKAGES}

unbin:
	@for tool in ${TOOLS}; do \
		rm -f ${BIN_DEST}/$$tool; \
	done

unstow: unbin
	${STOW} --delete ${PACKAGES}

INSTALL = /usr/bin/install
INSTALL_DATA = ${INSTALL} -m 644
SHELLCHECK ?= shellcheck

PROGRAM_NAME = git-syn

PREFIX ?= /usr/local
BIN_DIR = ${PREFIX}/bin

BUILD_DIR = .
TARGET_DIR = ${BUILD_DIR}
SRC_DIR = ${BUILD_DIR}/src

SRC = ${SRC_DIR}/main.sh

all: ${PROGRAM_NAME}

${PROGRAM_NAME}:
	@cp ${SRC} ${TARGET_DIR}/${PROGRAM_NAME}
	@chmod +x ${TARGET_DIR}/${PROGRAM_NAME}

check:
	@${SHELLCHECK} ${SRC}

install: ${PROGRAM_NAME}
	@${INSTALL} ${TARGET_DIR}/${PROGRAM_NAME} ${BIN_DIR}

clean:
	@rm -rf ${TARGET_DIR}/${PROGRAM_NAME}

.PHONY: all check install clean


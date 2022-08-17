#!/bin/bash

set -ex

export LDFLAGS="$LDFLAGS -s"

git -C ./src/riscv-gnu-toolchain submodule deinit --force qemu

NPROC=$CPU_COUNT ./src/build-toolchains.sh --prefix $PREFIX/esp-tools --clean-after-install

# create activate & deactivate scripts that manage the toolchain
mkdir -p "${PREFIX}"/etc/conda/{de,}activate.d

perl -pe 's/\@NATURE\@/activate/' "${RECIPE_DIR}"/activate.sh > "${PREFIX}"/etc/conda/activate.d/activate-${PKG_NAME}.sh
perl -pe 's/\@NATURE\@/deactivate/' "${RECIPE_DIR}"/activate.sh > "${PREFIX}"/etc/conda/deactivate.d/deactivate-${PKG_NAME}.sh

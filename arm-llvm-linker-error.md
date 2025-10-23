/lib/llvm-20/bin/ld.lld
ld -EL --fix-cortex-a53-843419 \
--unique -r -o common/device-tree/built_in.o \
common/device-tree/bootfdt.init.o \
common/device-tree/bootinfo-fdt.init.o \
common/device-tree/bootinfo.init.o \
common/device-tree/device-tree.o \
common/device-tree/domain-build.init.o \
common/device-tree/dom0less-build.init.o \
common/device-tree/dom0less-bindings.init.o \
common/device-tree/intc.o \
common/device-tree/kernel.o \
common/device-tree/static-evtchn.init.o

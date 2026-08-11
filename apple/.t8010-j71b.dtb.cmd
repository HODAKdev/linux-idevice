savedcmd_arch/arm64/boot/dts/apple/t8010-j71b.dtb := clang -E -Wp,-MMD,arch/arm64/boot/dts/apple/.t8010-j71b.dtb.d.pre.tmp -nostdinc -I ./scripts/dtc/include-prefixes -undef -D__DTS__ -x assembler-with-cpp -o arch/arm64/boot/dts/apple/.t8010-j71b.dtb.dts.tmp arch/arm64/boot/dts/apple/t8010-j71b.dts ; ./scripts/dtc/dtc -o arch/arm64/boot/dts/apple/t8010-j71b.dtb -b 0 -iarch/arm64/boot/dts/apple/ -i./scripts/dtc/include-prefixes -Wno-unique_unit_address -Wno-unit_address_vs_reg -Wno-avoid_unnecessary_addr_size -Wno-alias_paths -Wno-interrupt_map -Wno-simple_bus_reg   -d arch/arm64/boot/dts/apple/.t8010-j71b.dtb.d.dtc.tmp arch/arm64/boot/dts/apple/.t8010-j71b.dtb.dts.tmp ; cat arch/arm64/boot/dts/apple/.t8010-j71b.dtb.d.pre.tmp arch/arm64/boot/dts/apple/.t8010-j71b.dtb.d.dtc.tmp > arch/arm64/boot/dts/apple/.t8010-j71b.dtb.d 

source_arch/arm64/boot/dts/apple/t8010-j71b.dtb := arch/arm64/boot/dts/apple/t8010-j71b.dts

deps_arch/arm64/boot/dts/apple/t8010-j71b.dtb := \
  arch/arm64/boot/dts/apple/t8010-ipad6.dtsi \
  arch/arm64/boot/dts/apple/t8010.dtsi \
  scripts/dtc/include-prefixes/dt-bindings/gpio/gpio.h \
  scripts/dtc/include-prefixes/dt-bindings/interrupt-controller/apple-aic.h \
  scripts/dtc/include-prefixes/dt-bindings/interrupt-controller/irq.h \
  scripts/dtc/include-prefixes/dt-bindings/phy/phy.h \
  scripts/dtc/include-prefixes/dt-bindings/pinctrl/apple.h \
  arch/arm64/boot/dts/apple/t8010-pmgr.dtsi \
  arch/arm64/boot/dts/apple/t8010-common.dtsi \
  scripts/dtc/include-prefixes/dt-bindings/input/input.h \
  scripts/dtc/include-prefixes/dt-bindings/input/linux-event-codes.h \

arch/arm64/boot/dts/apple/t8010-j71b.dtb: $(deps_arch/arm64/boot/dts/apple/t8010-j71b.dtb)

$(deps_arch/arm64/boot/dts/apple/t8010-j71b.dtb):

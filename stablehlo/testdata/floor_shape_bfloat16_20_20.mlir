// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xbf16>
    %1 = call @expected() : () -> tensor<20x20xbf16>
    %2 = stablehlo.floor %0 : tensor<20x20xbf16>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xbf16>, tensor<20x20xbf16>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xbf16> {
    %0 = stablehlo.constant dense<"0xADC0E5BFE4BF34C06D4061BFE4BF323F8A40A1C099BFD4BF57C074C0ECBED3BFCB3F7A3F9C4092C0A5BD653F343FBE3F103F81C0D6BFC9C00FBF503EA53F00BF4B40CF402D4069C01D408B404FC023C0D3BFCDBE823FAD3F9EC0343FC43F993F8D3F853EF33E3E400A408D3F4BC05C3FA640883FA93F963FEE40D8BF09C03DC025C094C0C73E8CBF4DBF34C00DC03CBF52BF80C0E1BF2A40B9BD094013C0A2C05B40EEC039BEFEC035C060404F405CBF52BF93BEAFC03E3F32409E4026BF89C00BC09140D4400A3F91402B40EBBFE83FB53EBD3FDA401D3FFF3F00405CC0FC3F303F85C026C0C33F0940693FD1BF61C056C01A406DC01340B33F1240B3BFA6C021C0A33E97C099BFAF40163F3AC03CC05F3F0341B240473F52405EC03EC0A7C0EDBFE03F44C04B3F643F6B3F25C06ABF42C09DC09AC088BE09C0784029BF74BF544007BE3CC0203FB2BF403F803FCA408E3FC7C03CBE9ABF5A3FB3BF29C0F43ED7BF874096C01F40803E823E46BF213F3340FAC0D4BFADBF8BC077C0B23F8540034168C067C082402BC0A5BE1540D43F9F400340AB4050C039BFBA3F9C402FBF1240E23F483F11BF03C02140AA40EA3F01C03740E9BF26C050C0E9BF8740FCBF3740F8C087C027C01DC027C0BA3FDC3F6E3FEBBEFCBF943E2ABFCE40BBC012BF0CBF99C063407C3E754004C010C014C0BE3E02C0F740E03CB33D3FC0A23F12C0A140D8BF9D407CC0F5BF0BC00F41D13FF93E354025C03D3FEABFA73FA7408E3D03BEB9BFC7BFF8BF883E30C0973F194002401440B7BFD8BEB33F02401E4096C0E33FD740A63FF3406C3F05C0F53FF4C0EABF58404F3E8CBE114091BDC840953F8B400B403CC03DBE0FC02CC00DC00BBF49408EBFDCC087C0ECBF96BFA63FBC3F1AC00A3FE34034C0ABBFB0BF89C012BF8B3F724035C011C086C07ABE7EC0E3BFDB3FC2C0B1C0A23F043E043F7E3F7C3F32C072C0B53FA54037C0423F883F57C0834032C0DEBE93BEC9C01DC064409FBEB43C98C0583F47401840154067C002C010C019C02BBFC83F9FBE0DBF88C0DDBF28C06F3E803F653FE6C048403CC035C069BE4FC02DBF72C0A33F403FDF3F84BF303FEDBF45C00940C93F92404DC0A5BD"> : tensor<20x20xbf16>
    return %0 : tensor<20x20xbf16>
  }
  func.func private @expected() -> tensor<20x20xbf16> {
    %0 = stablehlo.constant dense<"0xC0C000C000C040C0404080BF00C000008040C0C000C000C080C080C080BF00C0803F00008040A0C080BF00000000803F0000A0C000C0E0C080BF0000803F80BF4040C040004080C00040804080C040C000C080BF803F803FA0C00000803F803F803F0000000000400040803F80C00000A040803F803F803FE04000C040C040C040C0A0C0000000C080BF40C040C080BF80BF80C000C0004080BF004040C0C0C0404000C180BF00C140C04040404080BF80BF80BFC0C000000040804080BFA0C040C08040C04000008040004000C0803F0000803FC0400000803F004080C0803F0000A0C040C0803F0040000000C080C080C0004080C00040803F004000C0C0C040C00000A0C000C0A040000040C040C000000041A0400000404080C040C0C0C000C0803F80C000000000000040C080BF80C0A0C0A0C080BF40C0404080BF80BF404080BF40C0000000C00000803FC040803FE0C080BF00C0000000C040C0000000C08040A0C000400000000080BF0000004000C100C000C0A0C080C0803F8040004180C080C0804040C080BF0040803F80400040A04080C080BF803F804080BF0040803F000080BF40C00040A040803F40C0004000C040C080C000C0804000C0004000C1A0C040C040C040C0803F803F000080BF00C0000080BFC040C0C080BF80BFA0C040400000404040C040C040C0000040C0E0400000000040C0803F40C0A04000C0804080C000C040C00041803F0000004040C0000000C0803FA040000080BF00C000C000C0000040C0803F00400040004000C080BF803F00400040A0C0803FC040803FE040000040C0803F00C100C04040000080BF004080BFC040803F8040004040C080BF40C040C040C080BF404000C0E0C0A0C000C000C0803F803F40C00000E04040C000C000C0A0C080BF803F404040C040C0A0C080BF80C000C0803FE0C0C0C0803F000000000000000040C080C0803FA04040C00000803F80C0804040C080BF80BFE0C040C0404080BF0000A0C0000040400040004080C040C040C040C080BF803F80BF80BFA0C000C040C00000803F000000C1404040C040C080BF80C080BF80C0803F0000803F00C0000000C080C00040803F804080C080BF"> : tensor<20x20xbf16>
    return %0 : tensor<20x20xbf16>
  }
}

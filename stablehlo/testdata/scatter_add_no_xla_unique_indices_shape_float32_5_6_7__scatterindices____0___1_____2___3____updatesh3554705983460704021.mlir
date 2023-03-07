// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[[0], [1]], [[2], [3]]]> : tensor<2x2x1xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xf32>, tensor<5x2x2x7xf32>)
    %2 = call @expected() : () -> tensor<5x6x7xf32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<f32>
      stablehlo.return %5 : tensor<f32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 3], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1], index_vector_dim = 2>, unique_indices = true} : (tensor<5x6x7xf32>, tensor<2x2x1xi32>, tensor<5x2x2x7xf32>) -> tensor<5x6x7xf32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xf32>, tensor<5x6x7xf32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xf32>, tensor<5x2x2x7xf32>) {
    %0 = stablehlo.constant dense<"0x021C2B40B0E85B3F777E07C0C19932C043FA53C08EE62EC0F2F6EE3E7C9B10C05FFF6DBEB93F5C40B64250C02B52FFBF6F6A56C08B550E3F2C272BC0C22504C0F2E60DC01E0E91403B0220C0C3870840041EBE3E16044F4074A2E9BF74F693BF5075563F38409640BFCE98BF07696E4026AB97BF6BAD13BF3023CF40F16A37C0BF1CFAC02F0100409B43EA3F32B06C40FF36333F7D6B8F3FC4580F3EB0F597BF776F98407CB95B3CAA37F73FC0ACCDBF3F66DFBFFE011B40E9BD66C009851A4092924DC09187F63F1F15A0BE9B6E7A40E38A18C005E8893E59F09A405A2280BFC03AC33F642905C057F5593E431467C0C0CD8D3E72516940A83F5040B75B4CBF3EBB813FA23D86BF9046393F03D874C017AF0D3F864F98BF4CFC7EBF648AABBFE174093FF31676BF944FF23D21851440CA814D3F7D02703EFC7B8DC04A50B83F4FE2F8BE187822C01C339ABF0441473F29A56BC079AF1EC0EBE7C63F7364343F2BCA2A405F2B8F3E85997240032B71C0C07ED63F466F92BFAD51933FC4C104C0B6206D4047DD47C0064ABD3F36E70EC072D48DC0684FB7BF3AD18140661D71C0A9B3483FF21D91C021788D3E80114440AECC19C0E046D03F62904DC00E828440A9E1A43E24E1D1BF017CBFC0CCD9A0C0DB818940D358F6BF7E5CA9C065694040C6C4A4BFD3EF8FBF1A8F943E2DF17FC08121B3BFA7907A3FA0579EBF63733FBF71D5403FCDBCD940CE7A53BF811129404DB10C3FF9D0443F7E115440C684E53F3AC8CCC03DA7DFBEE4E570BF13F5BC3F000DE03EBD56804063FA2DC0FB80833E1D0257BF33A912BF7E06903F4B5778BF431480BFF53635409E27BB3F00D28C40C045B240C1C69E40D4010A3E302B8F3FE36BDABFCEB0BDBF15057F4096A76BC016E05240CBA985C03830B940DD228CBF4F74024039DEB5BFAE2516C0A133AD3E260CD43FCECB38C02DA994C05D44E8C0444B17C0CF619140F5D832C0D86B21BFA185B8BF0A9CEF3FFD4FC9BF71A06EBE761B3D3F09DA59C06B8FC9C05B32E5BEE59115BF873EB5BF98139E40B42E8F40E87DA73F1C2BAE4004AF98409918253FA24202C029C79A40D3FD26C083D477BFDD4482C0243F053F48382D40C78F7EC08D969A3D799372BE577C81407DD72D409FE321406D75BE40CE4DD8BF7999AB3D9DE2E8BEE28E4C3F"> : tensor<5x6x7xf32>
    %1 = stablehlo.constant dense<"0xF08307BEDBEEDD3FD949843EE84BD4BF55B751C065A0493D32BA05403696014033F6C5C030B1F43F5B9F47403877603F212672C0C7F4A54026B65D3EB508083F094CBB3DAD8DF9BFA9708DC072196140B9D7C8BF5417E43ED5436AC06AE35B407C45B8BF2B3B12419AE896C078230840047813BF35A424BF879981BF952028C0E0B76A4004CD2EC07528BBBF3EC6173FD59F843FE134E0BF8CE10CBFD7AB2D40DD6F7ABF511D3640F2A5B7400C3B8FBF3D66E040BE3C33407DF2B8C0B125A34008C071C0C8EBEDC0FB5A8FC056FFF33FF9B2213D88CCD83E74FDC63E702952C07FEC2140831D1CC0CFFBBEC0BF95913FFB4D87C0F43A9EBFC025F7BFD211DB3F9E44C33F0EF0983EB26C6A4043671EC0B6C602C0A686A540D38F35C06B5B974097D10F40021289C075ED81BFC82A6CC04FDA85C0BA638040EB40C8C0133255C04EAF82BF4AE65340C189B63E947BA2C01E378140946765C02ED093406B86343FD8D6A040B5EBA5C09D66D63ABD7554C0EA275540D94D17C07AA4994072A8B93FF7DC463EBDB283BC9EC8B83E478BA93FFECAF53E8128B9C05F7E22408C67F9BEE64DA340694D414097851F401C04E13EF48086BF64B0BBBFB6BD0840216D30C04F64873E9A6650C02017C0BE697CA7BFA84D704064B63BC0A317C6BFCB84154061322FC0C77D2BC0101E23C0722EBB3F7E439FC057782A3EFC84653D43BFAD3F15A87F3F04241AC0E8574940AC00DD3E0B4219C07F1002C0862273BF13B6F6BA9DA2443FCD63BE40100C31C0A2C5D63F"> : tensor<5x2x2x7xf32>
    return %0, %1 : tensor<5x6x7xf32>, tensor<5x2x2x7xf32>
  }
  func.func private @expected() -> tensor<5x6x7xf32> {
    %0 = stablehlo.constant dense<"0xC3A322409AF1254078EAEDBFDA5F8EC0CCD8D2C00CC02BC010992340605470BE2E66CDC0284CAB40B0350ABE8F168FBF4848E4C078BFB740CA4B1DC02A47C4BF920C08C066552540C671DDC09AD0B440385099BF00876B40888AAFC030E81140A8151ABF475B5D414A1CBDC04046BB4026AB97BF6BAD13BF3023CF40F16A37C0BF1CFAC02F0100409B43EA3F32B06C40FF36333F7D6B8F3FC4580F3EB0F597BF776F98407CB95B3CA87BAD3F6DFF0FC0E37F30C070E951BEC07D7E3DD83FA2BE669395C0583521401A35393F2A540A4046C33BC0D8E83E40BB4477404818EC3FA274E840EAC64CC0E835E740145E4FBFA115B0C035E70B41800106BF9FBB03C157D85DC068835B3FC061433F72BE59C0D12D713F9A288FC04CFC7EBF648AABBFE174093FF31676BF944FF23D21851440CA814D3F7D02703EFC7B8DC04A50B83F4FE2F8BE187822C01C339ABF0441473F547193BF7E669DC0D4418DC0F8C7EB3F96A3C7BF38E074BF4A0DEE3F1AA203C0AFE14C40856658BFC40A9A40849491C000B4D43F05300340A0D5ADBFA0CF1F404DD70BC0DCE5B6C0BAAB424017A4EEC0B48759C0C0D105BF6969BFC0980489BE55245BC0DD049E402ABF36C030CC6FBFA9E1A43E24E1D1BF017CBFC0CCD9A0C0DB818940D358F6BF7E5CA9C065694040C6C4A4BFD3EF8FBF1A8F943E2DF17FC08121B3BFA7907A3F6C42334036A28AC0DCEAAB409A4DF0407E678640E9C522C0801C0D3F7F4123C0B49CD440D82D12BF008FCCBFA3BE813FA62E3FBF48E6BA3FCF6A4C3F8FB9AA4003410FC071F0B0C0B07BD93F7CAE87BF864FC74096370340EBF6BE3F78575140A89AD23ECECB3B409BA4F64061200D40D4010A3E302B8F3FE36BDABFCEB0BDBF15057F4096A76BC016E05240CBA985C03830B940DD228CBF4F74024039DEB5BFAE2516C0A133AD3E3AE5F53F3499C4C09FAAA0C0BC1109C1C804B23F741ACE3F63F28AC0AA53DA3F99BA85C008BF4EBF07E383C0645A9D3F0FA087C084324FC061C4C7C058E5683F602CD43E48C374C0C65F0141BFFE9C402E068BBFB9455A40669574403E9D243FF633A2BF7B952C41F204ACC0C1B6353FDD4482C0243F053F48382D40C78F7EC08D969A3D799372BE577C81407DD72D409FE321406D75BE40CE4DD8BF7999AB3D9DE2E8BEE28E4C3F"> : tensor<5x6x7xf32>
    return %0 : tensor<5x6x7xf32>
  }
}


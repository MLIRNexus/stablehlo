// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0:2 = call @inputs() : () -> (tensor<20x20xf32>, tensor<1x20xf32>)
    %1 = call @expected() : () -> tensor<20x20xf32>
    %2 = stablehlo.broadcast_in_dim %0#1, dims = [0, 1] : (tensor<1x20xf32>) -> tensor<20x20xf32>
    %3 = stablehlo.subtract %0#0, %2 : tensor<20x20xf32>
    %4 = stablehlo.custom_call @check.eq(%3, %1) : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<20x20xf32>, tensor<1x20xf32>) {
    %0 = stablehlo.constant dense<"0x2D03FE3EE67AD3BFAB6BFEBEE71539C078F4C83F778D653FAED479BF1CD6B23F2A5AD840B982943F8682D03FAD1B97405E18A03E70A89C407556BD403AD6AE3F9760273ED925C53FC9F5A5BE009DDDBF068B4EBF077CBA3F024F1C3F7DE51AC0319DE0BF637478BEE679E8BFE2DE82C0BAF9C1408EE3243E836BD1BF33CC06C0810297C0AA4E3CC0D27AB6BEAB2E5CC09FE696405A319ABFA4309DC03ADD8A3F045015C0794D08C0857E36BF70C19C3F5850B83F55D24640F80013BBC1AF2EBEBD4D9A4051FD9E3F6E7619BFB06E99BF51D5C33F48DFDD3B1AB9B1C0F540643F96DFE6BE6E178E40D36F2D3F012194407F3E61C02C37CBBF6F25DFBFCC6CE2BFBAF9DB3F84F6AC3E704AC1C042841BBDB7481E40090B44400700D43F729366C04D806F404A16D6BF6E581A40FC445740F64772C078374740FD4534BF81FA2DC026651C405F077840751B10BD9229BD403809CEBE9184BABE49D0C9BE22A18A3FC20234406413724046A6A7C004B64E40EBC7F53E272462405AF653C0153E2FC0BAAD51C02DA3DEBF4B68F13F20259740A76D14BF5ABD3740549DA6C0FBCD3DC0E3C45040CFBD86C01267EDBF933115C1D8F95EC07E9F92C03F5F9540FE127AC02F3A2EC0830406C042DAB5BF3FA401401CB086BF03A9E8BE191FC1BF768F7B3FDB18CD3FE2C38CBF3728D0BE0C761A404368C13F766F4440860087BE39ADB63F29FFA6C0D191A1BFE45A19407E2B9D4009F8E2BEE78224405CE94EC06CFE963F3A93B03EB8E75CBF9D5F1E4005EE76C06E856C40FF01263F450881C0A322EE3F92858A3F56C7883F1877273B067BE1BF0A763FC07BA865BEDA9FEDBF4625053FBF7E2BBFD9A02CBF36E29EC099D5063DD1D1D53DDD2F82C07A1D2AC0B6C6B6BF73607940D4949040CF6C9E3FEE5A0A40FDBBE3BFC1C785C0CC0C17C1CA2164C058D54BBF5D8C6EC03FCE3540E6E784405F7725C04DE38DC0A78F57BFA6AD9E4084BE06C03F2415BFEE3D23BDC5505BC0051C1D3FC4C987C0058DF03F7A6C4D40BBDE2CC01F6209402D0C813F6756DE3FAD3D57BFDF0C223EDA057EBF359A3640FF6A1540B4D25140324037BFC5B5FFBFB1B54FC025130B40880289406E1EDBBE581DA03E17219940891E243E1B6D02C08F22023F080087BF2A364C3F0B0B1BC0DEE7773FEB6EBF40B95957C04CBC0E401F1DC23A88CE66BEDE447B40D2D8D4C0CB3B04BFC84AC0BF00442CC051273D40F61256C0B3CAD4BFC80C6540452252BEB60718400788C53F18E4E93D9E9E0140DF5CB23F5281B5BED012B6C0225F87C0AE7D0A40E5A1C4C0A98F8E3FD7002DBF7D0B183E8FC8BBBF34DE663F1C7EDDBF027115C06782D93EE6B819BF0ADFE8BFA4EEB7C0247D613FE4C4343E297358C03B6E8DBE899A6C3E891A81BE27C2DD3EEF6F31C089A5ABBC0E4E00C021C49CC05152274053BF7F40D2702D40AB8AA24060FC07BF7D0571C01AAE643F571AAB40F689A5BFE27364402B6604C0098D5440C0CED3BF85A60CC03F82B3BE7F3B4DBFCBD77CC04F797DC0A040E03F39E5CBBFB703FBBF32CFD74074A86AC01C79EE3EF1DE5EC0880261C0B23C97C0581753C0905ABE402BB3AB3F0053E0C00B4D3EBFD1202B3F4C6FB7404B9C94BEE5572A3F611CAC4090DC483F8B3DE5BFEDD177C06215E9BF03341BC0812BBFBFE46D88BF9D739BC0AEC72ABC3F81A1C0609D76BF4883BD3F9E3B37C02ED076BE2AAA9540346784BE2D8E27C00E77003C835123C0BB2A5D4091D621409E626240A2D8C43F8D0F89BF86D2B3BE31C62BC0149D64C018D1AF40CBBCEF3F9F3AD23F7FE408C0948F10C0A9623B403D5411BFB6DF2F3F2D01F63E965A40C00AECD1C0C0BA09C02CB4274081F14740799F23C0E7CC703F7029D73F1758913F9C0942C00B3FE33FBBE5803F445128405650D7BF896244C02FF6A53FAD681CC041AD01C0079A92405E9E864066BD094063E2FDBF4A3778BF5DA686BF690B66BFDA768B40EF97E5BF06E3B53E36822E3F9C94F53F2F0F9EBF3AFF9FBF207D76C0DA8FB5BFBBB403C0668236C0CF42C9BF273E49BF022E7540162BB0BF95D8D73F5633C8BFCA0688C00423BBBE4C2A814005E6D03E0D2B1440807289C037B331404B11D2400C4F99BEFD7C073F30FA27BF70D4B1BEE235AB3F25290B402382F63F676ECCBF81B777C0BAC4044037B63BC015F54DC0A2CF8CC05C488A3FCA01BC409B2436C0DC40E3BF494C563F0B035EBE50CDD2BF81B28BBE"> : tensor<20x20xf32>
    %1 = stablehlo.constant dense<[[-2.10213423, 3.14236474, -0.0476996601, 0.71378225, -4.99376202, 0.689282119, 0.699026227, -1.59163511, -2.67922258, 1.23341644, 6.93745899, -3.13493466, -4.67826796, 0.196232349, 2.13258815, 3.22118735, -0.994539916, 2.27659726, -4.68295956, 0.286352873]]> : tensor<1x20xf32>
    return %0, %1 : tensor<20x20xf32>, tensor<1x20xf32>
  }
  func.func private @expected() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0xC4492640FA6C99C094FFE5BE83C466C0040AD240B062543E0864D6BF68483F402E0B1741E0DD95BD08DFA9C0106DFB40E5B59F40E760964097307240A479EDBF2839943F62833CBF717B8B401B2201C039CDA53FFBBCD7BF0E85283F199448C0344B4F40E4916EBFCCF920C06AE01FC0F6DA0B41254489BF452D09C124AD833F001127BDBCDD48C0AD4B1FC04D2BD5C0E4B9B64072CC5EC0C0BA6ABE086C4C3F606A6CBEFDB4A8C07A482ABF71C8023FFCE0CD4022B51A40638633BFBBE4B53FEE09F040005D0E3C782EF1C0DAD6F73FB3A9C640280242BE44F7F5C0B21715C0602A0B3F177B0A40C888AB4034F78A40426AB5BF0C5C97C0690AD9BF02E51EC054CBD64012F3B3BEDCA8D7C091DEC63F8CE0A4407B35EA3FA8FFA8C06885EFBE43BA06416E34EFBFD8E08E3ED0D0113E6BA132C0CC0E563F1DA47E401C4E40C04277914078AB3B3F0C154D3C4452A64052EC92408ADB86BFC3ED8BBFEA2D2B4092BDAF4018232340F8D242C164ACCB40DE10A540159555405639AEC002B3BEC02F0712C0AE8280C0E134D24052FB8D40E8DBC23F38F98ABE9316A5C0977C6BC0AC17044168CC9CC0627023C07974F7C0D8054EBFA417BAC0D64011C0E4C045BF1E5DFA3F959312C0746963C0600799BFD0606CBDE5C82EC010264B400A41323FCC156D4039BF87C020BCB7BEE08ED93FF726D04043521840A57376BFF6334140F08522C034B91FC0385291C070BE0041DE848740D5F31740D8B2ABC0B9A802C0E471AB3FB3ED48C09C0AE540D0A084C06687B940019C1FC007037FC06CC5923F4A6EC240C233C23EEB4B32BF98022EBE40ED9FBEA695BABFD0B30CC116EC69408744804022DD5EBF6020E3C0990C4CC033AA8C3FC009CBC022980140EC6DDBBFE8F4BF404E1AB03FD587A43FA458B93FCEBB4D405AD69BC0023C22C1E188FCBF1806F13F54BE9EC08A1883C04839E9405FF10540D62A94C03D603EC0BA66DE3FF22F8EBFD5FC36C05294944060A46DC05FD02D400458ECC00BA8F63FDEBD1F4011BB1240D889BA3FF0499E3E8D085540EE51EB3FFB9E89BF65C0FDC07D9EBF40DE69E040A2434540604C36C06901A7C0260F10C00014D4BDAB6E0F41A3DD36BF098D1A405A4BD23FB7F6543EB71B30C03811B0406E3ADFBF4016CA3DC6B654BF5A726940C5F6974043D624C188AFAB4081C09540D5DFD7BE1691E53F65F61DC1C0BCF43E29D971C038E3FE3FB6D32A4030139FBFEDC099C04B1A684000436BBFC1D0EB40439B5A3FDFB615BFF87B674069538240EC40CBBF3D094AC1FE368CBF36F3DA406EE9CAC0FD6882BF256879C0854E923F0C986FC094B6B240A91201C0407A6EBE34EC2DC0DA820DBF211E22C0F00D41BF6421443E29C205BF9F2BE5BF9BCA1940464D80BF5311E6C00A5B64409EF1F33FD3655EBE306584C00CEC01C1DCF866401C17DC3F3793EC40DE6099408C14C93FFF10DDC026E4703F09439440D1D46C40AF563840042331C031359D400422833FD0965BC0CE37E9C0E5531540CC433A3F310485C018E0C2BE460D9AC0436D77BF50F58E40501A823F88B8373E26ABB0BF840FD5C0F1B595C0FA6280C0BB132F418BF1263F6CB1F6C05B28593F9640564026F78F406F49E7C0BE38734060E8204148A0163F181B7BC0EEFCE2C0999053BFE47396C0DC1F4C401A15ADBFDC5D30C049C749C07EFA9FC0E8ABD6BFB82DCF40D15863C06EA770BFD798C8407CEB1A40787E76C06EBFDDC00845153FDE2402417F47154096CCB33F3C77D7BF78279CBD162E28C0D6DEFF3FAFF076C0C715F340377CA2BFA555D83F1B9336C0380A2F4076450F40D023A2BF47D5114088384A4071A587C0DAF557C114A07B3F758EE9406F623B40E60D96C0B5F411C0433B2B40730F92BF0058D33FD597BE3F3CFC4640F42C03BF5035D1BF251172C0724AC940E08548C01A6A2EC0B488C5408F5ADC406A346B3F21BC0EC1F2940A4090156840D9238CBF61710E40F379A0C0D7C5AC3F6F26CCBFF53FD34065B6C2BF04275A3FD0CCDFC0D474AFBF576331C0661709409ABE10C0C418BEBFAE85AD40AEC5A63FF8DFE73E400608C19ED58EBF2F028A4086C5754025BFDCBF88F367BF753E53C090FBFF3E0CF63341F2F515BF9D6828400D1B73C0596899BE55B11F3F7861E540BE479E3F0CF412C028DA11C08E1E9840415385C01A7D22C1FEF8A1BF7646B84041BAB54077509FC02EE49FC03A73EA3FF6931FC0F44E4240AC270FBF"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
}

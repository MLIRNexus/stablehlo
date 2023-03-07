// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xcomplex<f32>>
    %1 = call @expected() : () -> tensor<20x20xcomplex<f32>>
    %2 = stablehlo.sine %0 : tensor<20x20xcomplex<f32>>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xcomplex<f32>>, tensor<20x20xcomplex<f32>>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xcomplex<f32>> {
    %0 = stablehlo.constant dense<"0xB2091FC06BB935C0452B5F3F99178540C04EE83F0DDDC23F8B473040845449BFD2B12EC0EA72B73F96A893C006ADD83E1D6A5E3FEB90F1BF2805D43E299949405E68AA40E03FEF3FAFAE2D401A601D40FDF654BF8C628A3D23397CBF9C4D90C0620911C0C3F1B2BF6FB31CC0D918A2408263E5BF761E0A40C87FF6BF5D1A0E411945CDBFB4315A40A266D4BFB74769C057B20EBF32A3F8BF33CED1BE176262409969683FB6CDAD3E1DB112C1EAB902C0271CBB401675963F05CF0D408A1D173F6CCCAABF2592CABD21EED9BE62517BC083B74840CCC498403BBFDCBFE6EB1DC011FD06C043254E3F9F82CDC02786DC3F0927D33F66910FC0F72C9AC0F2E6E23FE759D53F0C2642C0F12EF93E57DCD53FFD06BC3F21AC3B40E1A618C0DA1C5AC0CD82F73F631D5F3EB8D25340EF9393C0D12684407D2C3E40B010FA3EBBC9C4408E599E40DED00BBD638A64C069CA9C3F65E9403EA57F4A40896449C0DC0FF33F3EE4843FF7A08F3E6128163FDA0AE43F47DD1640DCEF78C0C8A83C3FD0FB564022E314C0784E004098189EBF15BB7CC08992CFC0D98B723F83DD2CBF65A82540E1084F408F5A8740859FCB3F7C8C713F69BD0B40B1B26C4011056B405304A23FE63C35405F490840EE6BD9404DCDE4BF01D4B2C090490F3F00545840093C2DC0E327323ED3B4874000B65D3F66D14C40FE99BBBE11C33C3F489724C0E927D5BFE9B8E33E629DA240DCDC073FF0969EBE6BF26040912E4D40766EDABEBCC9A6C0667E624046548A3F2F8C1CC0D5AE94C0A0EE15C030BFBDC0ABAA553ECE38D5C0708D963C5FCD81BFD62ACFC01F9605C129A6BF3F28C323BCBA2997BF1808C740C4834340BAF307408C8A3C407EBDA5401D6DDDBFCBF76E3FD42D07BF1EC3AA3F6938663FE60D07BFD39541408BDD233FE4AF5DBFCB09A3BCCD8CBF3F89F8E0BFF9A69F3D7BA7FC3FB3CE873F693C8D4053DD93BFCB4EBF3F11D9AD408C0B2FC07D1538C03910334021502A405DBE513FA981F340CD823340534F8B40200E83BFD1186FC02ABF99C0E54D71C0A6647ABE2F0ED3BF6682AA3FEC7337C09BC0E5BF412432400C578940D45F5B40D75C7AC0686BA63F06619A3FF6F88040C4F08AC0DAEB29C0912FA9BF25D78EC0C62EBD3E791EEEBF1275AE3FF2EE763F66C8483FCBE1553FB34002C09B3EA63F488EABC006CD26406038473E689A98BFB2C0744033D29640EEBFF43F138163C0703723C0D1C54EC041C681C0EBE9E53F2B8688C0CB9FC73F9A6F31C03EF269BD7A48B1BF67A047C03C846FC0824B243FD9F26AC0164F2FBFDB95C73E2A4BA33F53CC35BF5A994FBFA2A3F7BF574CB2C05FDBF8BFD84288405F1058C0F37A88BF4D21B93F2FEC0F405DE327C06285EE3F5760F13FC20011C05F19763F0C5E673EE1F426C0AB6FD0BE2ED8DD3F9228B63FA5FC00C08E8185C02EA4E640446DDDBF778E91C0B8F21D407850FB3FB5269C3F8C5A4A3F0BDC91409EDD3C40F52FF43FB7C97E40A80B05BE536595BF959C58BECFF7F8BEBE59CA3FC66A98BFC630AA3EF49A853E506C5940EED35B4036B8553FBAE47840816258C0828B8C40B2418940B20EA840F6A37BBD05842DBF26843240995A74C032B6473FD0AFAB3F9EB0A4BEF911AFC0DBA19740A49C4BC0CEC831BF70DE9F40562266C0AFB5F7BF2509A8C08260993E726D9DC05102D6C0DA2C5DC0FC965EC049EEF73FFD607540732432C0E4569CBFC1D94F40E06665400DEB133FA61866400C16243F2EAB0C40C6F938400CAD57BEA0BF8340EEB075C0B8C6C33FDC7B8D405163CAC0AE69C2C05D4F0C4027BF0CBFAA632940F28397C056D2113E6DEA793FE897CBBFFD108DC052C1C3BFBBCC21BF7ECD6EC05184244099E9D3BCB9CB4BBF0621443F3A4DEB4030425ABCE1E2223F5242D63F3C577040E7731C3F6CBE77BE151735C08DA0C9BF5C10E7BFE7CC53BF328AC5BF01B6B3BEAD0AC53F90E4A03F255A5BC04EAD9A3F674F22BFF02C8FC04B9649C062618E40126D8FC0FA39FDBF3777994085D7DDBFC4E03BC0546C0CC016A49F404634094013C480BE1FD67E401B8206BF7C444B40D4890C406C2577C0E94592C0AB031DBF5816BCBFEADDFCBE111D99C0BB9DE53E4AA6C6BDE3438740F7DFB73F7511A6407CE960BF05F07EC01D1546C0327D953F09A81BC0352FAABF4B0E1A3F657EC93F0B4FAE40C29202C0A50BC740A0645B400181F73F0A7E403E852FD1C03A01783FEFAD2F40341CAD3FA19669C0428BFFBF9721183F8D69EEBF58141FC030D2FD3FEE60234002D0AFBFE7C4933F94E8C23E7D3045C00077893D40BCF43F60B91B3FBE4ABB3F340DEBBFE88ED93E1D6A1440CAA66FBFA3EEC23FAB50583FA9E96B40AF22B3BE3A3A5640B826E53C59E915C020E62A3F0FF66FBF5AA86BC0A2E3EB3E418308C022C204BFF6DA26BF0A5B1AC0AC85CB3C165594C07726373DE6BC7F40D87FEA3E6EC8263F1F745D406B94D740F736E3401389213F9C762AC061D06A3F643897BFEF5ECBBF0004DA3FD24FE73F16F2913F5D172DC0658F073FCB161940678541C02C8685C0ED57AC3EEA70513FC7EF0AC0C4906BC069CA20C095F3ADBF819E83C0824677400C5B4FC069AF4640A60BB6C0D1140A40971D4EC09778A2BF2D9F88BFE22378BF93F553C0A5211A40D150FDBFDAA1A03FFC7B923FFEE7F23E4911AB3FDE4210412FA708C03436B13F9CFE36BF5CDC284010F71EC082A3B73E9B8238BF15022DBF95AE3A3F26336DC08C6580C02435613F81F08EC018120640E03882C022360E3DB7AA463D935FBCBFC821B0BFC6B405C078FE5340B7EBD840480D7CBF7F315940AAFF403F27CB3C3FB8CB2340A9280E406E0734BC06B8D1BFBEE179BFE1612C40BC0E9ABF4FCBD1BFD5279E3EE7EF623F08714940530A273F35A62CC085CA85BF6624C23FAB0E0C40CB50CEBF8884B93E6FB200C072D26140AB4F993FD3989C40B826143F3571BA3FF8505F4061066DC04CC35FC0CCDD7DC036558440500BFC3FE12580409CDA2A3EF682CDC09D5701BE327F9A40F2D3073F9EF234BF2F6379BF62FB27C01E967F40D8B49C3FEE4313BE761D1940224A48BEB41737BF78A1F03F4837D4BF3727EB3D2FA323BF50A606C0F23297BE32E17B401DC182409449A9BD59D351BF615D2D3ECE15C2C07BF9ABBC533AD0C00C157F3D5FF6BBBFBD8CFFBF416F93BFEB66A1BF608840C03D9AD4C023052FBF413CD23FE4D51CC00565163FB57850BFC9DAA73D58800ABFA79BC4BF73646B40B7B7C14091171040D79D883E27D5F93D8776B43F14A72040A818903FE81708C11E230A408A53134042FF2F40093FA1C0CF88CC40375C02C06C40AD3F62DC60BFD627D1BE0BF812C01622A7C0A40B09C00425503F74E841BFE414A43D7ED99BBC4D2C0D3F51AA963F6BBE0DBF6F8E0B40F55368409C30A6BEBCA73E403B6334C0D1840940F283E6BFE9474F405E7D2EC05227BBBF9865623F44318D3FDEEA11BF8173BA4060380B408CD6E540259E94C080284940806498BE7E343240646CCFC0365681C05D1073404D398140AADE6540CD36A34024210DBF28E0983D53FF66404948B43FB407E33D6486D13F4C6DADC0BA47DF3F4856D740F03BD1BF077067C0C9F3E6402576E73F01A6EF3F3B4255C08F875A40C1210C3FC62F083CA28064C035578B3F299B8040578FA6C0142806405F7A2ABFFFF3B33DF630283E07C3B240EFE71ABF3795AE40A3BE0040EB2A5C4018623E3F7011B63FF27EA13F9A3C87BF9EDB1E40ADB1164080848B3FA033554034393C405A7FC83F5F3EA8408BBA4C3EFC7484C019FE4F3F1A261640789925C1018DCCC05E6BF03F7D698EC0340BDCBF043AAC3D706B04C0941F60C0FF628840B6737840048971BFEC761840A109A33D2C2C80402DCBE13E448ECA40E27399C0F159A3BFC147463F60C42EC0F1F9C73F36AED03F708C6EBF903E2D3FB3FBE13E07B8E3BF00C05FC0AC8F4C406B1F12C019A4AFBF58C547C0EC8B2640F88178404D1E6E40D9B57EBF65725DBF4BEECE3F65419DBF0AED833F65DD5CBD417DB13F118BB7BE51F51CC098BDD4C092C24DC014E820C0EBEF063E8E3654C028155640BB3E2540B8CB9340B6CCF9BF17BE35403E7D44404D728840969F1CC0D45D2040ADBD083F5C04B6BB4487BD3FFC3FB7BE6110A6BFF935A4401F90C9BF43C4F13E167141C011C174C0F124A4401906B33EB3E40EBD539DB03C71C141C0DE401C3F47F2F3BF46BD8640851A6340998651C007E2B23F1DB1303F5661E1BFC8658440899FFDBFE965A840345804407C6447C0E3B0E8BF8E4803408E082AC08D360640CC78713F24561CC09D1728C077D5FEBFC4FC9340D3DC86C06C50A7BF0847D83F3DDC973D31A863C0F3FA41402381E3BEE70EB7BF6D4C2C409EA5C73F7EB36E3CFA565BC0A5321DC08B1F0940CF3378C009051DC18EB9173F54B403408C2A8DC048237F3CD7AD004098B591C03B2BE33FAC6BD73F3D9C8EBF908EC43E"> : tensor<20x20xcomplex<f32>>
    return %0 : tensor<20x20xcomplex<f32>>
  }
  func.func private @expected() -> tensor<20x20xcomplex<f32>> {
    %0 = stablehlo.constant dense<"0x76A6A7C06C0BD840C30DC44193BBA441F81515408B0807BFAF23003F6E3E4E3FD31763BF96DAE7BF9BF68A3FEAD02EBDE8FD2440AA4505C0BB81964040972A4139BB2DC0EDF7E83F305F1C4079FBA8C061AB3DBF438A3A3D197D17C24BDDC8C13B03D3BF4AD19B3F2D834AC24BC973C212E788C036EB6FBF48E352C50D589CC40C1572C16C34FEBE93A298C1D29CD83F5907F1BF988C39C09649DBC0F2FE7B41A283553FAA0F5A3EC0A27EBF88A66A409FCE3FBFC107AA3F9243713FD86DC0BEB0187ABF7B1BBEBCB7B127C15ECDB8C1CB6FA33ED3C46CC20FCEBBC0C192653FFE7C93BFD901EBBE00FECCBE8FD32B40B90198403DD9BB3E05BA404063419A3EDAC92541F0477E3F6BC3A43FAA0C1140FBD21541E592733FE20526C1E78D2F413708753F9EA79FBD74C906C11D79464283BD02C17667ABC0C7D9DB4211E14E43E10B79BF2CD002BC7107453F71FBB4BFCE140E407BA53941128F903C81EC50C05847653F2BC7133E8A5AD83F17CD1940B7338A413C618A4134D41A412F322A413F1230C0F8F41FC01402C4C196A908C1F07599BE245B893F67DB85C0AE44A540D1EB4CC0DBC708C28E4BBD3FD9A4B2BC433C844120A839C1C2F077BF2029B4BF5665A63F0CB47CC01752C03FFB1122C05A403E3FEDD0E73E158DE3BF73DFE7403D6FC040E9CD084236CC1541EDEFFD40E298EBBE0FA4403F1517BDBF745B0940AC960A4215609142FFD6073FFCF88ABEB83490C0DD8A37C104DB17C26008A7C242C722BF92DE99BFF78E05C215FB1F4255B806C3AF2003439D34A2427F83BFC3D0D0EA3C243299BF7861C8C326AF01C524527F3F898340BAE16E68C3A0FEBE420010BC3E567583C01F148A41172EAEC20F90B9BFCA672EBE64EA82BFE151C33F7BF6643F7AF4AFBE1CA7103E95172EBF090A43BFF04753BC6C8A3E4092DB55BE8E47923EC5376140B62810428C26A141D01009C052C45A3F5519BAC03FF8A1C01A2F0AC08B6DFCC0324D203F3C844FBF2ABD00418AF9FE3F1757BCBFD20FDA3E58B50842D0434A4209181B3F07874C3E764C01C0B5C40CBE741857BF1F403440BF084D41B2E708C24EDCE1C07BC5BF41F676E03F2622D03E16B0EEC1FEBDC141EE6870BFCF0FC53F4FA1843F1A7ABEBD8E61FFBF397105BF143D8B3F12FCFC3EE7BC3840817E21C02D23CD4268DCE4C12E12053FB56E2CBEFE4DAAC1105B074181485DC00D0B273BF39725407F93BA407A9E244078DBE541B4F20A429CC9FE40F67800419A47B7BD9227F8BD9143EFBF1369F2BECAAAA841A04C3C41B6A47BC150622EBF68889E3E4EAB9A3F74B265BE32EC23C0856315C055FB1440F4E925C00C8B52C10021CD403928FBBF5840783F86A0AC408D9189404A9A4E4006CB6DBF685C93BFCDFD36BF00C8C33F47A1D2C08DDE93BF9D14214076BA7140FCD20ABF0AAA1044328FADC338A43AC29587EF4025021140B9A42EC0C9BF9F3FEF0B9A3EC49917C16F94BBBF6451CA4149A20DC1EDC569BEE822B8BF67EC70BE1820FDBE00FAE53F1C39763C5BCBAC3EC6757F3EEB4F7BC066E36FC14CEB90419F2483416E51194188F91CC2D413AEC2B6C51CC243BF9BBDC8C13ABF1A63FB4086CBAA4182E9B73FBA11A23F624916C2757DE1C2B4EA40C1ACB8A0BEC6313DC2E3226342A18BC63F7EFE4240A2AC653F20BE1F3EDD57C4438F1DA5C2E55EA040F938764156D0AC41B36804C18B6825BF00A4B93F9256F4BF01358FC156471F4130E97341A7762E4049286440992C823E6B72523EEFFF99C1F56050416F4D26422ED1DB3F2B2C10C1EE5259C3A160703F954BAC3E5F4BD841605C484233425C3E484C903F6D4124C241DE4F3F9A4B9ABF212CE5BC46026A4024D4ACC067530DBD2DF061BF934D0744D49E0C4492F883BC07162E3F692DAA4116B60CC0CC36173FB4E24CBE950346BF9BD80C40C898A9BFACFD5B3E23EA87BF337D21BCD208F33F7ABF4F3D2898033F8A40BBBF35E7CFC146560DC2F5C7B33EB11E2BC27794654017404F3F19133AC093D669BE67D26DBF90C58A40492285C0D9F5923F5B8CD5C097A3CF41838EC0C01A7B254115489A41247B5E41C550973FF745BC3D1F318FBF662055BD2EB88C3FDF64093D4C5F54C0CD5A084204CBB142C3204041B869A5C16A0C89C1BB09A8BD1FAAB9BF5A99A8BFB6ABAA3F5E62B63FC8B6F33F78BA39C08B3B22C0CDA578BF7CC675411F93733FDB7189BD19CCC1BE1DB48B3F86FA4B3F9EFFD4BFAF89E93F81084A40D358EC3F0DA526C0977810C0CAB834C0F15E953F3CB7C43F094D7B3FB27C213E983F78BD015189BD70A28F3F97865DBEFAA94C40F30EA8BE9465074026BF92401791F7BFFBB9A53F51D76E4104AF53412E189CC0C25D55418363163E30E4A4C0DD5B693F0B4859BFE9F8113FF87CD1BE086176BF6DF7933E4F415AC0A3BD8CC0C6E0A33F6F0D4EC2609B9B3F8935D941C8130A3F2267203F460604C35A1FC8C31B1D613F2B03EC3EC7E72ABF11F96EBF5B0C17C0431564BF907846401E71C8BE914DDA40B6C346C0CA3D324018BE9540752374C058D7004217EEE43E8B7D5C3FFE0D83C1FD1F334189489CBF4C1ABC3F2A6C9D4139E156C12E638C3F692831C1980B1D408345624021101B3ED218D13F430BA9BFF65B0BBF4B08733FD9D9ADC07DC9DEBF4AC023BF21E7813F138C503ECA5A7A45310E6F44AF71E5BF301D80BF1A7D93C05733A84023AE26BFE97594BE590451BF481B0CBF7D14594198A772C1414A8A3F428824BFF7FF7F40EFF078BF39024D3FCB8FAABC13AFE33D32E803C0D6BF80C0BC0C45BF356A95C29A8CD8C326A646C1C69F03413314613F6574163F492324404C7C73C02465F0BCCD7A1EC002D1C4C0D4E88340679D1FC007C063BF22ECDC3E35A5753F4837EDBB2C2533BFA0B02FBF3D0E903F0C5190401EB3733E426188BF83F578BC3FD076C1F80BE8C0DF8978421486C241245F9E3F1F6FD93F716FDDC0908C984171C712410003C6413BE243C0683EF5BF163A45BF7030DFBD4C100FBE486F00BE277791BF3557833D59947BBF78175DBFCC8656C18E93BCC1EE46733F62C148BD85B0313F9699133E3FB70CC03AA01A40165B80BF7D1524BC5FD41EC07B694FC0DB7AEEC01CD6C3414B1E50BFB5AF463D00CC3DBF93C5ED3D5D8A5D3E83EAA7BC92D663BEB7DF783DC1B56EC0AD04BDBE94E0DEBFBCFE28BF991A4CC2F04DBE4342BCD8BFCDCFF63F0E2240BF2859F5BECFCE3ABFDAAB663DA13AA0BF9311F3BF8B8BD9C25FF136C377144E3FB4FD2DBE792F873EBCA5F43F93B4803FE77C8EBFBE2A5FC05CD225C0650FBB40366FA6C011558D431877BF426C17ECBFAACF4FBF75B655BFBC4589BEFAC18AC233257642C05691BF7D6FFABE9F7430BFDDB16E3D8824B4BC3869143F0FCB883F38CB64BEAE887741E2AD2CC1043D49C0D0BD14415190B0BF7E5180C00AF246C1D3D739C09BC26ABFD822EF3FF69AA53F9F89593F320BB7C297C90E43C65B07444D02BBC3AF5139411C7049BF348618C069B8F64089EFB3C0C427DFC1EB7E8AC1FFB6B3C1C3CA0EC266BE93C2627606BF2759823D77217ABFA7A7DBBF010F973E62421D4096730F4020ADE63FEAF8923F71650EC0BAB19B43CB8317C412094F40CC333FBF3C7C3840DA8E6EC1133E053FF793E83B9DF82F3F844899BF021C8CC2D0E36842D635883FA2EEB73EBE26B63DF64B283E375143BF5A58FCBEB44433C0ADFD1E40B72EC2BEA03447BFBE72F13FBEE0753EEEDEA7C0260D3B408F0D963FB9616EBF561FE5BF565814C1AB06C042D3C5D83E6B78C740BAF7F5C1FDDD7440B6BD6340567E6E43A6A73343444E234218604F4107167EBFCFD04BBCA55F69C1AF78FD4086D2AEC1AFE228C14C7A8DC088AB4940C9BC0B402ACEDA41287FEF42EEB27D43BA51F63F0B400CBEA86EAC40EEBAAEC029A32940C18DAA3C8E5F7EBF6EC5DE3EE394A63F308626C0F7F88740781037C11C50CBBF50619A3F5C220CBE33AFD6C0022F5FC1F77B73C1D61796BF583208BFA120ED3FD29A923D51E05B3F4144E3BC1002863F695789BD403C75C348D594430B84E93E70E0C34039F0E73FDD295AC100F7ABBFC704CEC01DCE64C04956A53ED9694D40483624C140DEA7C08D211F40923D2E3F27A5E6BED46252BCD2630540D85A30BF54FFCABFF13513C0CBD170BFABDB9540950312C1BD295542551183C24181AF3E344606BD3F65643E34BA24C13525FC3FA8712CC0110274C18EA505C191E5903E66F2F0BFB709F43FEB4B0BC0B87B46C0B2A2F73F602E5BC0852A024061D3A8BDE3D23F401F2ECB40DABD514020ADA33FD4190CBF030B8FC0E374A8403B363AC2E452A6C15F03DF3F7762513F7FE47E3FFB3410BC561F86409C4617C1531F73BFAAACE3BFDA208A3F011103C06FE8653E510876C1BAF82EC08E3150C095E6BF45A89ED345DE3A0E407D6B4C403086743F754397BBA0DB2B4265B3A14169762E40A6B406BFB7E876BFB0A1313E"> : tensor<20x20xcomplex<f32>>
    return %0 : tensor<20x20xcomplex<f32>>
  }
}

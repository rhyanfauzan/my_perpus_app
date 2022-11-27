import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/provider/admin.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/search_bar.dart';
import 'package:my_perpus/ui/widget/small_button.dart';
import 'package:my_perpus/ui/widget/status_container.dart';
import 'package:provider/provider.dart';

class AdminCheckUserPage extends StatefulWidget {
  const AdminCheckUserPage({Key? key}) : super(key: key);

  @override
  _AdminCheckUserPageState createState() => _AdminCheckUserPageState();
}

class _AdminCheckUserPageState extends State<AdminCheckUserPage> {
  bool getData = true;
  bool userValidated = true;

  @override
  void initState() {
    if (getData) {
      // EasyLoading.show(status: "Loading");
      // Provider.of<AdminProvider>(context, listen: false).getAllUser();
      getData = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.generalBackgroundColor,
        appBar: AppBar(
          backgroundColor: ColorPalette.generalBackgroundColor,
          title: Text(
            "Anggota",
            style: TextStyle(color: ColorPalette.generalPrimaryColor),
          ),
        ),
        body: Consumer<AdminProvider>(builder: (context, valueAdmin, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                SearchBar(
                  title: "Cari nomor anggota",
                  enable: true,
                  onSubmit: (val) {
                    Provider.of<AdminProvider>(context, listen: false)
                        .searchAnggota(val);
                  },
                  onTapReset: ()=>Provider.of<AdminProvider>(context,listen: false).resetSearchAnggota(),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: SmallButton(
                          text: 'Tervalidasi',
                          invert: userValidated==true,
                          onPressed: () {
                            setState(() {
                              userValidated = true;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SmallButton(
                          text: 'Belum Tervalidasi',
                          invert: userValidated==false,
                          onPressed: () {
                            setState(() {
                              userValidated = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: valueAdmin.listAnggotaSearch.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var anggota = valueAdmin.listAnggotaSearch[index];
                    return userValidated == anggota.isValid
                        ? GestureDetector(
                            onTap: () {
                              Provider.of<AdminProvider>(context, listen: false)
                                  .selectDetailAnggota(anggota);
                              Get.toNamed(Routes.adminDetailAnggota);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.all(10),
                              decoration: kRoundedContainer.copyWith(
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "ID : " + anggota.uuid,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: anggota.isValid
                                                ? ColorPalette.generalSoftGreen
                                                : ColorPalette.generalSoftRed),
                                        child: Text(
                                          anggota.isValid
                                              ? "Tervalidasi"
                                              : "Belum Tervalidasi",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    anggota.namaLengkap,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    anggota.email,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          )
                        : SizedBox();
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

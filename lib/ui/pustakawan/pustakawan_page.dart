import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/provider/admin.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/small_button.dart';
import 'package:my_perpus/ui/widget/status_peminjaman.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PustakawanPage extends StatefulWidget {
  const PustakawanPage({Key? key}) : super(key: key);

  @override
  _PustakawanPageState createState() => _PustakawanPageState();
}

class _PustakawanPageState extends State<PustakawanPage> {

  bool getData = true;
  int selectedIndex = 0;

  @override
  void initState() {
    if (getData) {
      // EasyLoading.show(status: "Loading");
      Provider.of<AdminProvider>(context, listen: false).getAllPeminjaman();
      getData = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AdminProvider>(builder: (context, valueAdmin, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorPalette.generalBackgroundColor,
            title: Text(
              "Pustakawan",
              style: TextStyle(color: ColorPalette.generalPrimaryColor),
            ),
            actions: [
              GestureDetector(
                onTap: () => doSignOut(context),
                child: Icon(
                  Icons.logout,
                  color: ColorPalette.generalPrimaryColor,
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
          backgroundColor: ColorPalette.generalBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Expanded(
                        child: SmallButton(
                          text: "Booking",
                          onPressed: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          invert: selectedIndex == 0,
                        )),
                    SizedBox(width: 10,),
                    Expanded(
                        child: SmallButton(
                          text: "Dikonfirmasi",
                          onPressed: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          invert: selectedIndex == 1,
                        )),
                    SizedBox(width: 20,),
                  ],
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: valueAdmin.listPeminjaman.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return  valueAdmin.listPeminjaman[index].status==selectedIndex? GestureDetector(
                      onTap: (){
                        Provider.of<AdminProvider>(context,listen: false).onClickDetailPeminjaman(valueAdmin.listPeminjaman[index]);
                        Get.toNamed(Routes.adminDetail);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        child: StatusPeminjaman(
                          peminjamanModel: valueAdmin.listPeminjaman[index],
                        ),
                      ),
                    ):SizedBox();
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  doSignOut(BuildContext context) async {
    EasyLoading.show(status: "Loading...");
    var result =
    await Provider.of<AuthProvider>(context, listen: false).doSignOut();
    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        desc: l,
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
          ),
        ],
      ).show();
    }, (r) {
      EasyLoading.dismiss();
      Get.offAllNamed(Routes.login);
    });
  }
}

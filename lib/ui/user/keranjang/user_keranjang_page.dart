import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/provider/peminjaman.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/horizontal_book.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserKeranjangPage extends StatefulWidget {
  const UserKeranjangPage({Key? key}) : super(key: key);

  @override
  _UserKeranjangPageState createState() => _UserKeranjangPageState();
}

class _UserKeranjangPageState extends State<UserKeranjangPage> {
  // DateTime? tanggalPeminjaman = null;
  DateTime tanggalPeminjaman = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Consumer<PeminjamanProvider>(builder: (context, valuePeminjaman, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Keranjang",
              style: TextStyle(color: ColorPalette.generalPrimaryColor),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: valuePeminjaman.keranjang.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: HorizontalBook(
                              bukuModel: valuePeminjaman.keranjang[index],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Provider.of<PeminjamanProvider>(
                                    context,
                                    listen: false)
                                .hapusItemDalamKeranjang(
                                    valuePeminjaman.keranjang[index].id!),
                            child: Icon(
                              Icons.delete,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (valuePeminjaman.keranjang.isNotEmpty)
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                //   child: GestureDetector(
                //     onTap: () {
                //       DatePicker.showDatePicker(
                //         context,
                //         onChanged: (val) {},
                //         onConfirm: (val) {
                //           setState(() {
                //             tanggalPeminjaman = val;
                //           });
                //         },
                //       );
                //     },
                //     child: Container(
                //       width: double.infinity,
                //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                //       decoration: kRoundedContainer,
                //       child: Text(
                //           tanggalPeminjaman != null
                //               ? "${tanggalPeminjaman?.day}/${tanggalPeminjaman?.month}/${tanggalPeminjaman?.year}"
                //               : "Tanggal Peminjaman",
                //           style: TextStyle(
                //               color: ColorPalette.generalPrimaryColor,
                //               fontSize: 16)),
                //     ),
                //   ),
                // ),
                if (valuePeminjaman.keranjang.isNotEmpty &&
                    tanggalPeminjaman != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonRounded(
                      text: "Konfirmasi Peminjaman",
                      onPressed: () => doPeminjaman(context),
                    ),
                  ),
            ],
          ),
        );
      }),
    );
  }

  doPeminjaman(BuildContext context) async {
    EasyLoading.show(status: "Loading");
    var user = Provider.of<AuthProvider>(context, listen: false).user;
    var result = await Provider.of<PeminjamanProvider>(context, listen: false)
        .doPeminjaman(user, tanggalPeminjaman!);
    await Provider.of<AuthProvider>(context, listen: false).userIsOrderBook();

    result.fold(
      (l) {
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.error,
          title: "Gagal melakukan peminjaman",
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
      },
      (r) async {
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.success,
          title: "Sukses",
          desc: "Menunggu pengambilan buku dari pustakawan",
          buttons: [
            DialogButton(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                Get.back();
              },
              color: ColorPalette.generalPrimaryColor,
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show();
      },
    );
  }
}

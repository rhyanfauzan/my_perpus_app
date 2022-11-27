import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/provider/admin.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/horizontal_book.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminListBukuPage extends StatelessWidget {
  const AdminListBukuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.generalBackgroundColor,
          title: Text(
            "List Buku",
            style: TextStyle(color: ColorPalette.generalPrimaryColor),
          ),
        ),
        body: Consumer2<BukuProvider, AdminProvider>(
            builder: (context, valueBuku, valueAdmin, _) {
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
              itemCount: valueBuku.listBuku.length,
              itemBuilder: (context, index) {
                var buku = valueBuku.listBuku[index];
                bool isEmpty = true;

                for(int i = 0;i<valueAdmin.listPeminjaman.length;i++){

                  if(valueAdmin.listPeminjaman[i].status==2)
                  for(int j = 0;j<valueAdmin.listPeminjaman[i].bukuModel.length;j++){

                    print("[HEHEHEE] ${buku.judul}");
                    if(valueAdmin.listPeminjaman[i].bukuModel[j].id==buku.id){
                      print("${buku.judul}");
                      isEmpty = false;
                      break;
                    }
                  }
                  if(isEmpty==false){
                    break;
                  }
                }


                return InkWell(
                  onTap: () {
                    valueBuku.bukuDetail = buku;
                    Get.toNamed(Routes.adminDetailBuku, arguments: buku);
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: HorizontalBook(bukuModel: buku),
                          ),
                          if (isEmpty)
                            InkWell(
                              onTap: () {
                                doDeleteBuku(buku.id!, context);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  doDeleteBuku(String id, BuildContext context) async {
    EasyLoading.show(status: "Loading");
    var result = await Provider.of<BukuProvider>(context, listen: false)
        .doDeleteBuku(id);

    result.fold(
      (l) {
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.error,
          title: "Error Delete",
          desc: l,
          buttons: [
            DialogButton(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: ColorPalette.generalPrimaryColor,
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show();
      },
      (r) {
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.success,
          title: "Berhasil",
          desc: "Berhasil menghapus buku",
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
    );
  }
}

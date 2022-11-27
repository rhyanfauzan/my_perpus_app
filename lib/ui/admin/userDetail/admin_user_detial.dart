import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/provider/admin.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/vertical_title_value.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminUserDetailPage extends StatefulWidget {
  const AdminUserDetailPage({Key? key}) : super(key: key);

  @override
  _AdminUserDetailState createState() => _AdminUserDetailState();
}

class _AdminUserDetailState extends State<AdminUserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AdminProvider>(builder: (context, value, _) {
        bool canCancelUser = true;
        for(int i = 0;i<value.listPeminjaman.length;i++){
          if(value.listPeminjaman[i].idUser==value.selectedAnggota.id && value.listPeminjaman[i].status==2){
            canCancelUser = false;
            break;
          }
        }
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: kRoundedContainer.copyWith(
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  value.selectedAnggota.photoProfile ?? "",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 40,
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Text(
                                        "ID",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(width: 10),
                                      Text(value.selectedAnggota.uuid)
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: value.selectedAnggota.isValid
                                          ? ColorPalette.generalSoftGreen
                                          : ColorPalette.generalSoftRed),
                                  child: Text(
                                    value.selectedAnggota.isValid
                                        ? "Tervalidasi"
                                        : "Belum Tervalidasi",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Nama Lengkap',
                                value: value.selectedAnggota.namaLengkap),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Email',
                                value: value.selectedAnggota.email),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Jenis Identitas',
                                value: value.selectedAnggota.jenisIdentitas),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Nomor Identitas',
                                value: value.selectedAnggota.nomorIdentitas),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Agama',
                                value: value.selectedAnggota.agama),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Tempat Lahir',
                                value: value.selectedAnggota.tempatLahir),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Tanggal Lahir',
                                value: parseDate(value
                                    .selectedAnggota.tanggalLahir
                                    .toString())),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Status Perkawinan',
                                value: value.selectedAnggota.statusPerkawinan),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Alamat',
                                value: value.selectedAnggota.alamat),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Provinsi',
                                value: value.selectedAnggota.provinsi),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Kabupaten/Kota',
                                value: value.selectedAnggota.kota),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Kecamatan',
                                value: value.selectedAnggota.kecamatan ?? "-"),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'Kelurahan',
                                value: value.selectedAnggota.kelurahan ?? "-"),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'RT',
                                value: value.selectedAnggota.rt ?? "-"),
                            SizedBox(height: 15),
                            VerticalTitleValue(
                                title: 'RW',
                                value: value.selectedAnggota.rw ?? "-"),
                            SizedBox(height: 15),
                            GestureDetector(
                              onTap:(){
                                Get.toNamed(Routes.webView,arguments: "https://drive.google.com/file/d/17HaPadWd6FOqZ5nUGiN8vx41eGnbFr_-/view?usp=sharing");
                              },child: VerticalTitleValue(
                                title: 'File Persyaratan',
                                value: "Klik File persyaratan.pdf"),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!value.selectedAnggota.isValid)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ButtonRounded(
                    text: "Konfirmasi Anggota",
                    onPressed: ()=>doKonfirmasiAnggota(value.selectedAnggota),
                  ),
                ),
              if (value.selectedAnggota.isValid && canCancelUser)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ButtonRounded(
                    text: "Batalkan Konfirmasi Anggota",
                    invert: true,
                    onPressed: ()=>doBatalkanKonfirmasiAnggota(value.selectedAnggota),
                  ),
                )
            ],
          ),
        );
      }),
    );
  }

  doKonfirmasiAnggota(UserModel userModel) async {
    EasyLoading.show(status: "Loading...");
    var result = await Provider.of<AdminProvider>(context, listen: false)
        .konfirmasiAnggota(userModel);

    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal",
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
      Alert(
        context: context,
        type: AlertType.success,
        title: "Sukses",
        desc: "Anggota ${userModel.namaLengkap} sudah tervalidasi",
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
    });
  }

  doBatalkanKonfirmasiAnggota(UserModel userModel) async {
    EasyLoading.show(status: "Loading...");
    var result = await Provider.of<AdminProvider>(context, listen: false)
        .batalkanKonfirmasiAnggota(userModel);

    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal",
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
      Alert(
        context: context,
        type: AlertType.success,
        title: "Sukses",
        desc: "Anggota ${userModel.namaLengkap} berhasil dibatalkan",
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
    });
  }
}

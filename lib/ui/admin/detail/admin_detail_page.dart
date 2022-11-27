import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/provider/admin.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/horizontal_book.dart';
import 'package:my_perpus/ui/widget/status_container.dart';
import 'package:my_perpus/ui/widget/vertical_title_value.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../model/peminjaman_model.dart';
import '../../../provider/peminjaman.dart';
import '../../../service/peminjaman_service.dart';
import '../../widget/input_field_rounded.dart';

class AdminDetailPage extends StatefulWidget {
  const AdminDetailPage({Key? key}) : super(key: key);

  @override
  _AdminDetailPageState createState() => _AdminDetailPageState();
}

class _AdminDetailPageState extends State<AdminDetailPage> {
  PeminjamanService _peminjamanService = PeminjamanService();
  @override
  Widget build(BuildContext context) {
    String noHp = '081234567890';
    String? code;
    return SafeArea(
      child: Consumer<AdminProvider>(builder: (context, valueAdmin, _) {
        // code = valueAdmin.
        return Scaffold(
          backgroundColor: ColorPalette.generalBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                valueAdmin.detailPeminjaman.bukuModel.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.detailBukuGeneral,
                                        arguments: valueAdmin
                                            .detailPeminjaman.bukuModel[index]);
                                  },
                                  child: HorizontalBook(
                                      bukuModel: valueAdmin
                                          .detailPeminjaman.bukuModel[index]),
                                ),
                              );
                            }),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: VerticalTitleValue(
                                  title: 'ID Peminjaman',
                                  value: valueAdmin.detailPeminjaman.id ?? "-"),
                            ),
                            StatusContainer(
                                status: valueAdmin.detailPeminjaman.status)
                          ],
                        ),
                        const SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Nama Peminjam',
                            value: valueAdmin
                                .detailPeminjaman.userModel.namaLengkap),
                        const SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Email Peminjam',
                            value: valueAdmin.detailPeminjaman.userModel.email),
                        const SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Jenis Identitas Peminjaman',
                            value: valueAdmin
                                .detailPeminjaman.userModel.jenisIdentitas),
                        const SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Identitas Peminjaman',
                            value: valueAdmin
                                .detailPeminjaman.userModel.nomorIdentitas),
                        const SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Tanggal Peminjaman',
                            value: parseDate(valueAdmin
                                .detailPeminjaman.tanggalPeminjaman
                                .toString())),
                        const SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Tanggal Pengembalian',
                            value: parseDate(valueAdmin
                                .detailPeminjaman.tanggalPengembalian
                                .toString())),
                        const SizedBox(height: 15),
                        for (int i = 0;
                            i < valueAdmin.detailPeminjaman.bukuModel.length;
                            i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: VerticalTitleValue(
                                title: 'Nomor Panggil',
                                value:
                                    '${valueAdmin.detailPeminjaman.bukuModel[i].noPanggil} (${valueAdmin.detailPeminjaman.bukuModel[i].judul})'),
                          ),
                        // if (valueAdmin.detailPeminjaman.status == 0)
                        //   Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       const VerticalTitleValue(
                        //           title: 'Nomor Panggil',
                        //           value:
                        //               'Masukan nomor panggil terlebih dahulu!'),
                        //       InputFieldRounded(
                        //         label: "Masukan Nomor Panggil",
                        //         hint: "Masukan Nomor Panggil",
                        //         onChange: (val) {
                        //           noHp = val;
                        //         },
                        //         secureText: false,
                        //       ),
                        //     ],
                        //   ),
                        // if (valueAdmin.detailPeminjaman.status != 0)
                        //   VerticalTitleValue(
                        //       title: 'Nomor Panggil',
                        //       value: '${valueAdmin.detailPeminjaman.noHp}'),
                      ],
                    ),
                  ),
                ),
                if (valueAdmin.detailPeminjaman.status == 0)
                  ButtonRounded(
                    text: "Konfirmasi Pengambilan Buku",
                    onPressed: () async {
                      if (noHp != null) {
                        var result = await Provider.of<PeminjamanProvider>(
                                context,
                                listen: false)
                            .setNoHpPeminjaman(
                                noHp, valueAdmin.detailPeminjaman);
                        result.fold((l) {
                          print('Gagal, no Hp: $noHp');
                        }, (r) {
                          print('Berhasil, no Hp: $noHp');
                        });
                        doKonfirmasiPengambilan(context, noHp);
                        // await _peminjamanService.setNoHp(
                        //     noHp, valueAdmin.detailPeminjaman);
                      } else {
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "Gagal Konfirmasi",
                          desc: "Masukan Nomor Panggil terlebih dahulu!",
                          buttons: [
                            DialogButton(
                              child: const Text(
                                "Close",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: ColorPalette.generalPrimaryColor,
                              radius: BorderRadius.circular(0.0),
                            ),
                          ],
                        ).show();
                      }
                    },
                  ),
                if (valueAdmin.detailPeminjaman.status == 1)
                  Row(
                    children: [
                      Expanded(
                        child: ButtonRounded(
                          text: "Konfirmasi",
                          onPressed: () => doKonfirmasiPeminjaman(context),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ButtonRounded(
                          text: "Batalkan",
                          invert: true,
                          onPressed: () => doKonfirmasiPembatalan(context),
                        ),
                      ),
                    ],
                  ),
                if (valueAdmin.detailPeminjaman.status == 2)
                  ButtonRounded(
                    text: "Konfirmasi Pengembalian",
                    onPressed: () => doKonfirmasiPengembalian(context),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  doKonfirmasiPeminjaman(BuildContext context) async {
    EasyLoading.show(status: "Loading");
    var result = await Provider.of<AdminProvider>(context, listen: false)
        .doKonfirmasiPeminjaman();

    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal",
        desc: l,
        buttons: [
          DialogButton(
            child: const Text(
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
        desc: "Sukses konfirmasi peminjaman",
        buttons: [
          DialogButton(
            child: const Text(
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

  doKonfirmasiPengambilan(
    BuildContext context,
    String noHp,
  ) async {
    EasyLoading.show(status: "Loading");

    var result = await Provider.of<AdminProvider>(context, listen: false)
        .doKonfirmasiPengambilan();

    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal",
        desc: l,
        buttons: [
          DialogButton(
            child: const Text(
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
        desc: "Sukses konfirmasi pengambilan",
        buttons: [
          DialogButton(
            child: const Text(
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

  doKonfirmasiPengembalian(BuildContext context) async {
    EasyLoading.show(status: "Loading");
    var result = await Provider.of<AdminProvider>(context, listen: false)
        .doKonfirmasiPengembalian();

    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal",
        desc: l,
        buttons: [
          DialogButton(
            child: const Text(
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
        desc: "Sukses konfirmasi pengembalian",
        buttons: [
          DialogButton(
            child: const Text(
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

  doKonfirmasiPembatalan(BuildContext context) async {
    EasyLoading.show(status: "Loading");
    var result = await Provider.of<AdminProvider>(context, listen: false)
        .doKonfirmasiPembatalan();

    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal",
        desc: l,
        buttons: [
          DialogButton(
            child: const Text(
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
        desc: "Sukses konfirmasi pembatalan",
        buttons: [
          DialogButton(
            child: const Text(
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    String? noPanggil1;
    String? noPanggil2;
    String? noPanggil3;
    bool isEmpty = false;
    String? code;

    return SafeArea(
      child: Consumer<AdminProvider>(builder: (context, valueAdmin, _) {
        // code = valueAdmin.
        List<TextEditingController> _controller = [
          for (int i = 0; i < valueAdmin.detailPeminjaman.bukuModel.length; i++)
            TextEditingController()
        ];
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
                        if (valueAdmin.detailPeminjaman.status == 0)
                          for (int i = 0;
                              i < valueAdmin.detailPeminjaman.bukuModel.length;
                              i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VerticalTitleValue(
                                    title: 'Nomor Panggil',
                                    value:
                                        'Buku ${valueAdmin.detailPeminjaman.bukuModel[i].judul}'),
                                const SizedBox(
                                  height: 6,
                                ),
                                TextFormField(
                                  controller: _controller[i],
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Masukan Nomor Panggil',
                                    // labelText: 'Nomor Panggil',
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                        if (valueAdmin.detailPeminjaman.status != 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (valueAdmin.detailPeminjaman.noPanggil1 !=
                                  null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: VerticalTitleValue(
                                      title:
                                          'Nomor Panggil (${valueAdmin.detailPeminjaman.noPanggil1})',
                                      value:
                                          'Buku ${valueAdmin.detailPeminjaman.bukuModel[0].judul}'),
                                ),
                              if (valueAdmin.detailPeminjaman.noPanggil2 !=
                                  null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: VerticalTitleValue(
                                      title:
                                          'Nomor Panggil (${valueAdmin.detailPeminjaman.noPanggil2})',
                                      value:
                                          'Buku ${valueAdmin.detailPeminjaman.bukuModel[1].judul}'),
                                ),
                              if (valueAdmin.detailPeminjaman.noPanggil3 !=
                                  null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: VerticalTitleValue(
                                      title:
                                          'Nomor Panggil (${valueAdmin.detailPeminjaman.noPanggil3})',
                                      value:
                                          'Buku ${valueAdmin.detailPeminjaman.bukuModel[2].judul}'),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                if (valueAdmin.detailPeminjaman.status == 0)
                  ButtonRounded(
                    text: "Konfirmasi Pengambilan Buku",
                    onPressed: () async {
                      int i = 0;
                      while (i < valueAdmin.detailPeminjaman.bukuModel.length) {
                        if (_controller[i].text.isEmpty) {
                          isEmpty = true;
                          print('Jadi true');
                        }
                        if (i == 0) {
                          noPanggil1 = _controller[i].text;
                          print('value np $i : $noPanggil1');
                          print('controller $i : ${_controller[i].text}');
                        } else if (i == 1) {
                          noPanggil2 = _controller[i].text;
                          print('value np $i : $noPanggil2');
                          print('controller $i : ${_controller[i].text}');
                        } else if (i == 2) {
                          noPanggil3 = _controller[i].text;
                          print('value np $i : $noPanggil3');
                          print('controller $i : ${_controller[i].text}');
                        }

                        i++;
                      }
                      print('isEmpty $isEmpty');

                      if (isEmpty == false) {
                        var result = await Provider.of<PeminjamanProvider>(
                                context,
                                listen: false)
                            .setNoHpPeminjaman(noPanggil1, noPanggil2,
                                noPanggil3, valueAdmin.detailPeminjaman);
                        result.fold((l) {
                          print('Gagal, np : $noPanggil1');
                        }, (r) {
                          print('Berhasil, np: $noPanggil1');
                        });
                        doKonfirmasiPengambilan(context, noPanggil1!);
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
                              onPressed: () {
                                Navigator.pop(context);
                                isEmpty = false;
                              },
                              color: ColorPalette.generalPrimaryColor,
                              radius: BorderRadius.circular(0.0),
                              child: const Text(
                                "Close",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
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
            onPressed: () => Navigator.pop(context),
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
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
            onPressed: () {
              Navigator.pop(context);
              Get.back();
            },
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show();
    });
  }

  doKonfirmasiPengambilan(BuildContext context, String noPanggil1) async {
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
            onPressed: () => Navigator.pop(context),
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
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
            onPressed: () {
              Navigator.pop(context);
              Get.back();
            },
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
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
            onPressed: () => Navigator.pop(context),
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
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
            onPressed: () {
              Navigator.pop(context);
              Get.back();
            },
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
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
            onPressed: () => Navigator.pop(context),
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
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
            onPressed: () {
              Navigator.pop(context);
              Get.back();
            },
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show();
    });
  }
}

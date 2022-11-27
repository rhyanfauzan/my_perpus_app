import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/ui/widget/button_picker.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/input_field_rounded.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminTambahBukuPage extends StatefulWidget {
  const AdminTambahBukuPage({Key? key}) : super(key: key);

  @override
  _AdminTambahBukuPageState createState() => _AdminTambahBukuPageState();
}

class _AdminTambahBukuPageState extends State<AdminTambahBukuPage> {
  File? imageCoverFile = null;
  String? judul = null;
  String? anakJudul = null;
  String? pengarang = null;
  String? pengarangTambahan = null;
  String? penerbit = null;
  String? tempatTerbit= null;
  String? tahunTerbit= null;

  int? jumlahHalaman= null;
  String? keteranganIlustrasi= null;
  String? dimensi= null;
  String? edisi= null;
  String? subjek= null;
  String? noKlass= null;
  String? noPanggil= null;
  String? ISBN= null;
  String? bahasa= null;
  String? bentukKaryaTulis= null;
  String? kelompokSasaran= null;
  String? lokasiKoleksiDaring= null;

  int? stok= null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Tambah Buku",
            style: TextStyle(color: ColorPalette.generalPrimaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                InputFieldRounded(
                  label: "Judul Buku",
                  hint: "Judul Buku",
                  onChange: (val) {
                    judul = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Anak Judul",
                  hint: "Anak Judul",
                  onChange: (val) {
                    anakJudul = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Pengarang",
                  hint: "pengarang",
                  onChange: (val) {
                    pengarang = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Pengarang Tambahan",
                  hint: "Pengarang Tambahan",
                  onChange: (val) {
                    pengarangTambahan = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Penerbit",
                  hint: "Penerbit",
                  onChange: (val) {
                    penerbit = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Tempat Terbit",
                  hint: "Tempat Terbit",
                  onChange: (val) {
                    tempatTerbit = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Tahun Terbit",
                  hint: "Tahun Terbit",
                  onChange: (val) {
                    tahunTerbit = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Jumlah Halaman",
                  hint: "Jumlah Halaman",
                  onChange: (val) {
                    jumlahHalaman = int.parse(val);
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Keterangn Ilustrasi",
                  hint: "Keterangan Ilustrasi",
                  onChange: (val) {
                    keteranganIlustrasi = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Dimensi",
                  hint: "Dimensi",
                  onChange: (val) {
                    dimensi = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label:"Edisi",
                  hint: "Edisi",
                  onChange: (val) {
                    edisi = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Subjek",
                  hint: "Subjek",
                  onChange: (val) {
                    subjek = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "No Klass",
                  hint: "No Klass",
                  onChange: (val) {
                    noKlass = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "No Panggil",
                  hint: "No Panggil",
                  onChange: (val) {
                    noPanggil = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "ISBN",
                  hint: "ISBN",
                  onChange: (val) {
                    ISBN = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Bahasa",
                  hint: "Bahasa",
                  onChange: (val) {
                    bahasa = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Bentuk Karya Tulis",
                  hint: "Bentuk Karya Tulis",
                  onChange: (val) {
                    bentukKaryaTulis = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Kelompok Sasaran",
                  hint: "Kelompok Sasaran",
                  onChange: (val) {
                    kelompokSasaran = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Lokasi Koleksi Daring",
                  hint: "Lokasi Koleksi Daring",
                  onChange: (val) {
                    lokasiKoleksiDaring = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Stok Buku",
                  hint: "Stok Buku",
                  keyboardType: TextInputType.number,
                  onChange: (val) {
                    stok = int.parse(val);
                  },
                  secureText: false,
                ),
                imageCoverFile != null
                    ? Container(
                        margin: EdgeInsets.only(top: 15, bottom: 30),
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(imageCoverFile!),
                          ),
                        ),
                      )
                    : ButtonPicker(
                        onTap: () => doImagePicker(),
                      ),
                ButtonRounded(
                  text: "Tambah",
                  onPressed: () => doTambahBuku(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  doImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        imageCoverFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  doTambahBuku() async {
    if (judul != null &&
        anakJudul != null &&
        stok != null &&
        pengarang != null &&
        pengarangTambahan != null &&
        tempatTerbit != null &&
        tahunTerbit != null &&
        jumlahHalaman != null &&
        keteranganIlustrasi != null &&
        dimensi != null &&
        edisi != null &&
        subjek != null &&
        noKlass != null &&
        noPanggil != null &&
        ISBN != null &&
        bahasa != null &&
        bentukKaryaTulis != null &&
        kelompokSasaran != null &&
        lokasiKoleksiDaring != null) {
      var buku = BukuModel(
        judul: judul!,
        anakJudul: anakJudul!,
        pengarang: pengarang!,
        pengarangTambahan: pengarangTambahan!,
        penerbit: penerbit!,
        tempatTerbit: tempatTerbit!,
        tahunTerbit: tahunTerbit!,
        jumlahHalaman: jumlahHalaman!,
        keteranganIlustrasi: keteranganIlustrasi!,
        dimensi: dimensi!,
        edisi: edisi!,
        subjek: subjek!,
        noKlass: noKlass!,
        noPanggil: noPanggil!,
        ISBN: ISBN!,
        bahasa: bahasa!,
        bentukKaryaTulis: bentukKaryaTulis!,
        kelompokSasaran: kelompokSasaran!,
        lokasiKoleksiDaring: lokasiKoleksiDaring!,
        stok: stok!,
      );

      EasyLoading.show(status: "Loading");

      var result = await Provider.of<BukuProvider>(context, listen: false)
          .doTambahBuku(buku: buku, coverBuku: imageCoverFile);

      result.fold((l){
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.error,
          title: "Gagal menambahkan buku",
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
      }, (r){
        EasyLoading.dismiss();
        Get.back();
      });

    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal menambahkan buku",
        desc: "Harap isi seluruh formulir",
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
    }
  }
}

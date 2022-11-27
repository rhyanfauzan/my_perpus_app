import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/ui/widget/button_picker.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/input_field_rounded.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminDetailBuku extends StatefulWidget {
  const AdminDetailBuku({Key? key}) : super(key: key);

  @override
  State<AdminDetailBuku> createState() => _AdminDetailBukuState();
}

class _AdminDetailBukuState extends State<AdminDetailBuku> {

  File? imageCoverFile = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Edit Buku",
          style: TextStyle(color: ColorPalette.generalPrimaryColor),
        ),
      ),
      backgroundColor: ColorPalette.generalBackgroundColor,
      body: SafeArea(
        child: Consumer<BukuProvider>(
          builder: (context,valueBuku,_) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    InputFieldRounded(
                      label: "Judul Buku",
                      hint: "Judul Buku",
                      initialValue: valueBuku.bukuDetail?.judul??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.judul = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Anak Judul",
                      hint: "Anak Judul",
                      initialValue: valueBuku.bukuDetail?.anakJudul??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.anakJudul = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Pengarang",
                      hint: "pengarang",
                      initialValue: valueBuku.bukuDetail?.pengarang??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.pengarang = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Pengarang Tambahan",
                      hint: "Pengarang Tambahan",
                      initialValue: valueBuku.bukuDetail?.pengarangTambahan??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.pengarangTambahan = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Penerbit",
                      hint: "Penerbit",
                      initialValue: valueBuku.bukuDetail?.penerbit??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.penerbit = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Tempat Terbit",
                      hint: "Tempat Terbit",
                      initialValue: valueBuku.bukuDetail?.tempatTerbit??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.tempatTerbit = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Tahun Terbit",
                      hint: "Tahun Terbit",
                      initialValue: valueBuku.bukuDetail?.tahunTerbit??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.tahunTerbit = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Jumlah Halaman",
                      hint: "Jumlah Halaman",
                      initialValue: valueBuku.bukuDetail?.jumlahHalaman.toString()??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.jumlahHalaman = int.parse(val);
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Keterangn Ilustrasi",
                      hint: "Keterangan Ilustrasi",
                      initialValue: valueBuku.bukuDetail?.keteranganIlustrasi??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.keteranganIlustrasi = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Dimensi",
                      hint: "Dimensi",
                      initialValue: valueBuku.bukuDetail?.dimensi??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.dimensi = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label:"Edisi",
                      hint: "Edisi",
                      initialValue: valueBuku.bukuDetail?.edisi??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.edisi = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Subjek",
                      hint: "Subjek",
                      initialValue: valueBuku.bukuDetail?.subjek??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.subjek = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "No Klass",
                      hint: "No Klass",
                      initialValue: valueBuku.bukuDetail?.noKlass??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.noKlass = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "No Panggil",
                      hint: "No Panggil",
                      initialValue: valueBuku.bukuDetail?.noPanggil??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.noPanggil = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "ISBN",
                      hint: "ISBN",
                      initialValue: valueBuku.bukuDetail?.ISBN??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.ISBN = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Bahasa",
                      hint: "Bahasa",
                      initialValue: valueBuku.bukuDetail?.bahasa??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.bahasa = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Bentuk Karya Tulis",
                      hint: "Bentuk Karya Tulis",
                      initialValue: valueBuku.bukuDetail?.bentukKaryaTulis??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.bentukKaryaTulis = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Kelompok Sasaran",
                      hint: "Kelompok Sasaran",
                      initialValue: valueBuku.bukuDetail?.kelompokSasaran??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.kelompokSasaran = val;
                      },
                      secureText: false,
                    ),

                    InputFieldRounded(
                      label: "Lokasi Koleksi Daring",
                      hint: "Lokasi Koleksi Daring",
                      initialValue: valueBuku.bukuDetail?.lokasiKoleksiDaring??"-",
                      onChange: (val) {
                        valueBuku.bukuDetail?.lokasiKoleksiDaring = val;
                      },
                      secureText: false,
                    ),
                    InputFieldRounded(
                      label: "Stok Buku",
                      hint: "Stok Buku",
                      initialValue: valueBuku.bukuDetail?.stok.toString()??"-",
                      keyboardType: TextInputType.number,
                      onChange: (val) {
                        valueBuku.bukuDetail?.stok = int.parse(val);
                      },
                      secureText: false,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 30),
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(valueBuku.bukuDetail?.gambar??""),
                        ),
                      ),
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
                      text: "Update",
                      onPressed: () => doUpdateBuku(),
                    ),
                  ],
                ),
              ),
            );
          }
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

  doUpdateBuku()async{
    EasyLoading.show(status: "Loading");
    var result = await Provider.of<BukuProvider>(context, listen: false)
        .doUpdateBuku(coverBuku: imageCoverFile);

    result.fold(
          (l) {
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.error,
          title: "Error Update",
          desc: l,
          buttons: [
            DialogButton(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: (){
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
          desc: "Berhasil update buku",
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

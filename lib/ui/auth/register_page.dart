import 'dart:io';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/button_picker.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/dropdown_container.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../widget/input_field_rounded.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? photoProfile = null;
  File? pdfPicker = null;
  File? filePicker = null;
  bool secureText = true;
  String? jenisIdentitas = "KTP";
  String? nomorIdentitas = null;
  String? email = null;
  String? password = null;
  DateTime? tanggalLahir = null;
  String? namaLengkap = null;
  String? tempatLahir = null;
  String? alamat = null;
  String? provinsi = null;
  String? kota = null;
  String? kecamatan = null;
  String? kelurahan = null;
  String? rt = null;
  String? rw = null;

  String? agama = null;
  String? statusPerkawinan = "Belum Kawin";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Daftar",
                  style: TextStyle(
                    fontSize: 30,
                    color: ColorPalette.generalPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                DropdownContainer(
                  value: jenisIdentitas ?? "",
                  onChanged: (val) {
                    setState(() {
                      jenisIdentitas = val;
                    });
                  },
                  items: ["KTP", "KIA"],
                  hint: 'Jenis Identitas',
                ),
                SizedBox(height: 10),
                InputFieldRounded(
                  label: "Nomor Identitas",
                  hint: "Nomor Identitas",
                  onChange: (val) {
                    nomorIdentitas = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Nama Lengkap",
                  hint: "Nama Lengkap",
                  onChange: (val) {
                    namaLengkap = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Email",
                  hint: "Email",
                  onChange: (val) {
                    email = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Tempat Lahir",
                  hint: "Tempat Lahir",
                  onChange: (val) {
                    tempatLahir = val;
                  },
                  secureText: false,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      onChanged: (val) {},
                      onConfirm: (val) {
                        setState(() {
                          tanggalLahir = val;
                        });
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: kRoundedContainer,
                    child: Text(
                        tanggalLahir != null
                            ? "${tanggalLahir?.day}/${tanggalLahir?.month}/${tanggalLahir?.year}"
                            : "Tanggal Lahir",
                        style: TextStyle(
                            color: ColorPalette.generalPrimaryColor,
                            fontSize: 16)),
                  ),
                ),
                SizedBox(height: 20),
                DropdownContainer(
                  value: statusPerkawinan ?? "",
                  onChanged: (val) {
                    setState(() {
                      statusPerkawinan = val;
                    });
                  },
                  items: ["Belum Kawin", "Kawin"],
                  hint: 'Status Perkawinan',
                ),
                SizedBox(height: 10),
                InputFieldRounded(
                  label: "Agama",
                  hint: "Agama",
                  onChange: (val) {
                    agama = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Alamat",
                  hint: "Alamat",
                  onChange: (val) {
                    alamat = val;
                  },
                  secureText: false,
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: kRoundedContainer,
                  child: SelectState(
                      onCountryChanged: (val) {},
                      onStateChanged: (val) {
                        provinsi = val;
                      },
                      onCityChanged: (val) {
                        kota = val;
                      }),
                ),
                SizedBox(height: 10),
                InputFieldRounded(
                  label: "Kecamatan (optional)",
                  hint: "Kecamatan (optional)",
                  onChange: (val) {
                    kecamatan = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Kelurahan (optional)",
                  hint: "Kelurahan (optional)",
                  onChange: (val) {
                    kelurahan = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "RT (optional)",
                  hint: "RT (optional)",
                  onChange: (val) {
                    rt = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "RW (optional)",
                  hint: "RW (optional)",
                  onChange: (val) {
                    rw = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  label: "Password",
                  hint: "Password",
                  onChange: (val) {
                    password = val;
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        secureText = !secureText;
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: ColorPalette.generalPrimaryColor,
                    ),
                  ),
                  secureText: secureText,
                ),
                filePicker!= null ?Container(
                  margin: EdgeInsets.only(top: 15, bottom: 30),
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.file_copy_outlined,size: 80,),
                ):ButtonPicker(
                  title: "Upload File Persyaratan (Kota Medan dan Luar Kota Medan)",
                  onTap: () => doPdfPicker(),
                ),
                photoProfile != null
                    ? Container(
                  margin: EdgeInsets.only(top: 15, bottom: 30),
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(photoProfile!),
                    ),
                  ),
                )
                    : ButtonPicker(
                  title: "Photo Profile",
                  onTap: () => doImagePicker(),
                ),

                ButtonRounded(
                  text: "Daftar",
                  onPressed: () {
                    doRegister(
                      context: context,
                      jenisIdentitas: jenisIdentitas,
                      kota: kota,
                      namaLengkap: namaLengkap,
                      nomorIdentitas: nomorIdentitas,
                      provinsi: provinsi,
                      tanggalLahir: tanggalLahir,
                      tempatLahir: tempatLahir,
                      alamat: alamat,
                      email: email,
                      password: password,
                      kecamatan: kecamatan,
                      kelurahan: kelurahan,
                      rt: rt,
                      rw: rw,
                      statusPerkawinan: statusPerkawinan,
                      agama: agama,
                      photoProfile: photoProfile
                    );
                  },
                ),
                SizedBox(height: 30),
                

              ],
            ),
          ),
        ),
      ),
    );
  }

  doFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc',],
    );

    if (result != null) {
      setState(() {
        filePicker = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }


  doImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        photoProfile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  doPdfPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf','jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        pdfPicker = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  doRegister({
    required BuildContext context,
    File? photoProfile,
    String? jenisIdentitas,
    String? nomorIdentitas,
    DateTime? tanggalLahir,
    String? namaLengkap,
    String? tempatLahir,
    String? alamat,
    String? provinsi,
    String? kota,
    String? email,
    String? password,
    String? kecamatan,
    String? kelurahan,
    String? rt,
    String? rw,
    String? statusPerkawinan,
    String? agama,
  }) async {
    if (jenisIdentitas != null &&
        nomorIdentitas != null &&
        photoProfile != null &&
        tanggalLahir != null &&
        namaLengkap != null &&
        tempatLahir != null &&
        alamat != null &&
        provinsi != null &&
        kota != null &&
        email != null &&
        statusPerkawinan != null &&
        agama != null &&
        password != null) {
      EasyLoading.show(status: "Loading...");
      UserModel user = UserModel(
        uuid: "",
        tempatLahir: tempatLahir,
        email: email,
        password: password,
        jenisIdentitas: jenisIdentitas,
        nomorIdentitas: nomorIdentitas,
        tanggalLahir: tanggalLahir,
        namaLengkap: namaLengkap,
        alamat: alamat,
        provinsi: provinsi,
        kota: kota,
        isOrder: false,
        kecamatan: kecamatan??"-",
        kelurahan: kelurahan??"-",
        rt: rt??"-",
        rw: rw??"-",
        statusPerkawinan: statusPerkawinan,
        agama: agama,
        isValid: false,
      );
      var result = await Provider.of<AuthProvider>(context, listen: false)
          .doSignUp(user: user,userProfile: photoProfile);

      result.fold((l) {
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.error,
          title: "Pendaftaran Gagal",
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
        Get.offAllNamed(Routes.mainMenu);
      });
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Pendaftaran Gagal",
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

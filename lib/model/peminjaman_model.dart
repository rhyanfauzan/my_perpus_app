import 'dart:convert';

import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/model/user_model.dart';

class PeminjamanModel {
  String? id;
  String idUser;
  List<BukuModel> bukuModel;
  UserModel userModel;
  int status;
  DateTime? tanggalPeminjaman;
  DateTime? tanggalPengembalian;
  String? noPanggil1;
  String? noPanggil2;
  String? noPanggil3;
  int perpanjang;

  PeminjamanModel(
      {this.id,
      required this.idUser,
      required this.bukuModel,
      required this.userModel,
      required this.status,
      this.tanggalPeminjaman,
      this.tanggalPengembalian,
      this.noPanggil1,
      this.noPanggil2,
      this.noPanggil3,
      required this.perpanjang});

  factory PeminjamanModel.fromjson(Map<String, dynamic> json, String id) {
    var jsonTglPeminjaman = json['tanggalPeminjaman'];
    var jsonTglPengembalian = json['tanggalPengembalian'];
    final bukuDecode = jsonDecode(json['bukuModel']);
    return PeminjamanModel(
        id: id,
        bukuModel: List<BukuModel>.from(
            bukuDecode.map((x) => BukuModel.fromjsonWithId(x))).toList(),
        userModel: UserModel.fromjsonWithId(json['userModel']),
        idUser: json['idUser'],
        status: json['status'],
        tanggalPeminjaman: jsonTglPeminjaman.toDate(),
        tanggalPengembalian: jsonTglPengembalian.toDate(),
        noPanggil1: json['noPanggil1'],
        noPanggil2: json['noPanggil2'],
        noPanggil3: json['noPanggil3'],
        perpanjang: json['perpanjang']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'idUser': idUser,
        'bukuModel': bukuModel,
        'userModel': userModel,
        'status': status,
        'tanggalPeminjaman': tanggalPeminjaman,
        'tanggalPengembalian': tanggalPengembalian,
        'noPanggil1': noPanggil1,
        'noPanggil2': noPanggil2,
        'noPanggil3': noPanggil3,
        'perpanjang': perpanjang,
      };
}

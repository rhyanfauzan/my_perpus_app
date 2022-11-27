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
  String? noHp;
  int perpanjang;

  PeminjamanModel(
      {this.id,
      required this.idUser,
      required this.bukuModel,
      required this.userModel,
      required this.status,
      this.tanggalPeminjaman,
      this.tanggalPengembalian,
      this.noHp,
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
        noHp: json['noHp'],
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
        'noHp': noHp,
        'perpanjang': perpanjang,
      };
}

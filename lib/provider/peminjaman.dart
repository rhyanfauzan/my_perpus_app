import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/local_storage_service.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/model/peminjaman_model.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/service/notification.dart';
import 'package:my_perpus/service/peminjaman_service.dart';
import 'package:my_perpus/setup_locator.dart';

import '../service/riwayat_service.dart';

class PeminjamanProvider extends ChangeNotifier {
  PeminjamanService _peminjamanService = PeminjamanService();
  RiwayatService _riwayatService = RiwayatService();
  List<BukuModel> keranjang = [];

  List<PeminjamanModel> riwayatSaya = [];
  late PeminjamanModel detailRiwayat;

  List<PeminjamanModel> deadlinePengembalian = [];

  var storageService = locator<LocalStorageService>();

  tambahKeKeranjang(BukuModel model) {
    if (keranjang.length < 3) {
      keranjang.add(model);
      notifyListeners();
    }
  }

  Future<Either<String, PeminjamanModel>> perpanjangPeminjaman(
      PeminjamanModel peminjamanModel) async {
    try {
      var result =
          await _peminjamanService.perpanjangPeminjaman(peminjamanModel);
      riwayatSaya[riwayatSaya.indexWhere(
          (element) => element.id == peminjamanModel.id)] = peminjamanModel;
      notifyListeners();
      return right(result);
    } catch (e) {
      return left(e.toString());
    }
  }

  // tambahnohp
  Future<Either<String, PeminjamanModel>> setNoHpPeminjaman(
      Map<String, dynamic> np, String noHp, PeminjamanModel peminjamanModel) async {
    try {
      var result = await _peminjamanService.setNoHp(np, noHp, peminjamanModel);
      riwayatSaya[riwayatSaya.indexWhere(
          (element) => element.id == peminjamanModel.id)] = peminjamanModel;
      for (var i = 0; i < peminjamanModel.bukuModel.length; i++) {
        peminjamanModel.bukuModel[i].noPanggil = np[i];
        notifyListeners();
      }
      peminjamanModel.noHp = noHp;

      for (var i = 0; i < peminjamanModel.bukuModel.length; i++) {
        print(
            'no panggil berhasil ditambahkan ${peminjamanModel.bukuModel[i].noPanggil}');
      }
      return right(result);
    } catch (e) {
      for (var i = 0; i < peminjamanModel.bukuModel.length; i++) {
        peminjamanModel.bukuModel[i].noPanggil = np[i];
        notifyListeners();
      }
      peminjamanModel.noHp = noHp;
      for (var i = 0; i < peminjamanModel.bukuModel.length; i++) {
        print(
            'no panggil ditambahkan ${peminjamanModel.bukuModel[i].noPanggil}');
      }
      return left(e.toString());
    }
  }

  hapusItemDalamKeranjang(String id) {
    keranjang.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  detailRiwayatSaya(PeminjamanModel peminjamanModel) {
    detailRiwayat = peminjamanModel;
  }

  Future<Either<String, List<BukuModel>>> doPeminjaman(
      UserModel user, DateTime tanggalPeminjman) async {
    try {
      List<BukuModel> buku = [];
      await _peminjamanService.setPeminjaman(keranjang, user, tanggalPeminjman);
      buku = keranjang;
      keranjang = [];
      getRiwayatSaya();
      notifyListeners();
      return right(buku);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> getRiwayatSaya() async {
    try {
      var result = await _riwayatService.getMyPeinjaman();
      riwayatSaya = result;

      riwayatSaya.forEach((element) {
        if (getDurationDifferenceInt(
                    DateTime.now(), element.tanggalPengembalian!) <
                2 &&
            element.status == 2) {
          storageService.saveToPref(
              Constants.userModel, element.bukuModel[0].judul);
          showNotification(
              "Buku ${element.bukuModel[0].judul} harus segera dikembalikan sebelum tanggal ${parseDate(element.tanggalPengembalian.toString())}");
        }
      });
      notifyListeners();
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future showNotification(String message) async {
    await NotificationService.flutterLocalNotificationsPlugin.show(
        12345, "Pengembalian Buku", message, platformChannelSpecifics,
        payload: 'data');
  }
}

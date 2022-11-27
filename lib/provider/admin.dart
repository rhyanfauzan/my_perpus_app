import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/model/peminjaman_model.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/service/admin_service.dart';

class AdminProvider extends ChangeNotifier {
  AdminService _adminService = AdminService();
  List<PeminjamanModel> listPeminjaman = [];
  List<UserModel> listAnggota = [];
  List<UserModel> listAnggotaSearch = [];
  late UserModel selectedAnggota;
  PeminjamanModel? searchPeminjaman = null;
  late PeminjamanModel detailPeminjaman;

  Future<Either<String, List<PeminjamanModel>>> getAllPeminjaman() async {
    try {
      listPeminjaman = [];
      var result = await _adminService.getAllPeminjaman();
      listPeminjaman = result;
      notifyListeners();
      return right(result);
    } catch (e) {
      print("MY ERROR ${e}");
      return left(e.toString());
    }
  }

  onClickDetailPeminjaman(PeminjamanModel peminjaman) {
    detailPeminjaman = peminjaman;
    notifyListeners();
  }

  Future<Either<String, bool>> doKonfirmasiPeminjaman() async {
    try {
      await _adminService.konfirmasiPeminjaman(detailPeminjaman);
      detailPeminjaman.status = 2;
      listPeminjaman[listPeminjaman.indexWhere(
          (element) => element.id == detailPeminjaman.id)] = detailPeminjaman;
      notifyListeners();
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> doKonfirmasiPengambilan() async {
    try {
      await _adminService.konfirmasiPengambilan(detailPeminjaman);
      detailPeminjaman.status = 1;
      listPeminjaman[listPeminjaman.indexWhere(
          (element) => element.id == detailPeminjaman.id)] = detailPeminjaman;
      notifyListeners();
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> doKonfirmasiPengembalian() async {
    try {
      await _adminService.konfirmasiPengembalian(detailPeminjaman);
      detailPeminjaman.status = 3;
      listPeminjaman[listPeminjaman.indexWhere(
          (element) => element.id == detailPeminjaman.id)] = detailPeminjaman;
      notifyListeners();
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> doKonfirmasiPembatalan() async {
    try {
      await _adminService.konfirmasiPembatalan(detailPeminjaman);
      detailPeminjaman.status = 4;
      listPeminjaman[listPeminjaman.indexWhere(
              (element) => element.id == detailPeminjaman.id)] = detailPeminjaman;
      notifyListeners();
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> searchPeminjamanById(String nomorPeminjaman) async {
    searchPeminjaman = null;
    notifyListeners();
    searchPeminjaman = await listPeminjaman
        .firstWhere((element) => element.id == nomorPeminjaman);
    notifyListeners();
  }

  Future<Either<String, List<UserModel>>> getAllUser() async {
    try {
      listAnggota = [];
      var result = await _adminService.getAllAnggota();
      listAnggota = result;
      listAnggotaSearch = result;
      notifyListeners();
      return right(result);
    } catch (e) {
      return left(e.toString());
    }
  }

  searchAnggota(String id)async{
    listAnggotaSearch = await listAnggota.where((element) => element.uuid==id).toList();
    notifyListeners();
  }

  resetSearchAnggota(){
    listAnggotaSearch = listAnggota;
    notifyListeners();
  }

  selectDetailAnggota(UserModel userModel){
    selectedAnggota = userModel;
    notifyListeners();
  }

  Future<Either<String,bool>> konfirmasiAnggota(UserModel userModel)async{
    try{
      await _adminService.konfirmasiAnggota(userModel);
      userModel.isValid = true;
      listAnggota[listAnggota.indexWhere(
              (element) => element.id == userModel.id)] = userModel;
      notifyListeners();
      listAnggotaSearch = listAnggota;
      notifyListeners();
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,bool>> batalkanKonfirmasiAnggota(UserModel userModel)async{
    try{
      await _adminService.batalkanKonfirmasiAnggota(userModel);
      userModel.isValid = false;
      listAnggota[listAnggota.indexWhere(
              (element) => element.id == userModel.id)] = userModel;
      notifyListeners();
      listAnggotaSearch = listAnggota;
      notifyListeners();
      return right(true);
    }catch(e){
      return left(e.toString());
    }
  }

}

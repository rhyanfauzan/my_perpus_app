import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/model/peminjaman_model.dart';
import 'package:my_perpus/model/user_model.dart';

import '../helper/constants.dart';

class AdminService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _peminjamanReference =
  FirebaseFirestore.instance.collection('Peminjaman');

  final CollectionReference _bukuReference =
  FirebaseFirestore.instance.collection('Buku');

  final CollectionReference _userReference =
  FirebaseFirestore.instance.collection('Users');


  Future<List<PeminjamanModel>> getAllPeminjaman()async{
    try{
      QuerySnapshot result = await _peminjamanReference.get();
      List<PeminjamanModel> listPeminjaman = result.docs.map((e){
        return PeminjamanModel.fromjson(e.data() as Map<String, dynamic>, e.id);
      }).toList();
      print("Get Peminjaman From Firebase ${listPeminjaman.length}");
      return listPeminjaman;
    }catch(e){
      rethrow;
    }
  }

  konfirmasiPeminjaman(PeminjamanModel peminjaman)async{
      try{
        var peminjamanById = await _peminjamanReference.doc(peminjaman.id);
        peminjamanById.update({
          "status":2
        });

        // var bukuById = await _bukuReference.doc(peminjaman.bukuModel.id);
        // bukuById.update({
        //   "isAvailable":false
        // });
      }catch(e){
        rethrow;
      }
  }

  konfirmasiPengambilan(PeminjamanModel peminjaman)async{
    try{
      var peminjamanById = await _peminjamanReference.doc(peminjaman.id);
      peminjamanById.update({
        "status":1
      });
    }catch(e){
      rethrow;
    }
  }

  konfirmasiPengembalian(PeminjamanModel peminjaman)async{
    try{
      var peminjamanById = await _peminjamanReference.doc(peminjaman.id);
      peminjamanById.update({
        "status":3
      });

      var isPinalty = getDurationDifferenceInt(DateTime.now(), peminjaman.tanggalPengembalian!);

      peminjaman.bukuModel.forEach((element) async{
        var bukuById = await _bukuReference.doc(element.id);
        var bukumodel = await getBukuById(element.id!);
        int stokBuku = bukumodel.stok+1;
        bukuById.update({
          "stok":stokBuku
        });

      });

      var userById = await _userReference.doc(peminjaman.idUser);

      userById.update({
        "isOrder":false,
      });

      if(isPinalty<=0){
        isPinalty *= -1;
        DateTime pinaltyUntil = DateTime.now().add(Duration(days: isPinalty));
        userById.update({
          "pinalty":pinaltyUntil,
        });
      }


    }catch(e){
      rethrow;
    }
  }


  konfirmasiPembatalan(PeminjamanModel peminjaman)async{
    try{
      var peminjamanById = await _peminjamanReference.doc(peminjaman.id);
      peminjamanById.update({
        "status":4
      });

      peminjaman.bukuModel.forEach((element) async{
        var bukuById = await _bukuReference.doc(element.id);
        var bukumodel = await getBukuById(element.id!);
        int stokBuku = bukumodel.stok+1;
        bukuById.update({
          "stok":stokBuku
        });

      });


      var userById = await _userReference.doc(peminjaman.idUser);
      userById.update({
        "isOrder":false
      });


    }catch(e){
      rethrow;
    }
  }

  Future<BukuModel> getBukuById(String id) async {
    try {
      DocumentSnapshot snapshot = await _bukuReference.doc(id).get();
      return BukuModel.fromjson(snapshot.data() as Map<String, dynamic> , id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getAllAnggota()async{
    try{
      QuerySnapshot result = await _userReference.where("role",isEqualTo: 0).get();
      print(result.size);
      List<UserModel> listAnggota = result.docs.map((e){
        return UserModel.fromjsonWithTimeStamp(e.data() as Map<String, dynamic>, e.id);
      }).toList();
      return listAnggota;
    }catch(e){
      print(e);
      rethrow;
    }
  }

  Future<void> konfirmasiAnggota(UserModel userModel)async{
    try{
      var userById = await _userReference.doc(userModel.id);
      userById.update({
        "isValid":true
      });
    }catch(e){
      rethrow;
    }
  }

  Future<void> batalkanKonfirmasiAnggota(UserModel userModel)async{
    try{
      var userById = await _userReference.doc(userModel.id);
      userById.update({
        "isValid":false
      });
    }catch(e){
      rethrow;
    }
  }

}
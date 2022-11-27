

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_perpus/model/user_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('Users');

  Reference ref = FirebaseStorage.instance.ref("Profile");

  Future<String> simpanGambar(File photoProfile) async {
    try {

      final metadata = SettableMetadata(
        customMetadata: {'picked-file-path': photoProfile.path},
      );

      String fileName =
          "${DateTime.now().millisecond}-${DateTime.now().minute}-${DateTime.now().hour}-${DateTime.now().day}-${DateTime.now().month}-profile";
      fileName += photoProfile.path.split('/').last;
      var result = await ref.child(fileName).putFile(photoProfile, metadata);
      String path = await result.ref.getDownloadURL();
      String profilePath = path;
      return profilePath;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> setUser(UserModel user,File photoProfile) async {

    String path = await simpanGambar(photoProfile);
    Random random = new Random();
    DateTime pinalty = DateTime(2000);
    int randomNumber = random.nextInt(100);
    String code = "${randomNumber}${DateTime.now().millisecond}${DateTime.now().second}${DateTime.now().minute}${DateTime.now().month}${DateTime.now().year}";
    user.photoProfile = path;
    user.uuid = code;
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'uuid': code,
        'namaLengkap': user.namaLengkap,
        'alamat': user.alamat,
        'jenisIdentitas': user.jenisIdentitas,
        'provinsi': user.provinsi,
        'role': 0,
        'pinalty':pinalty,
        'photoProfile': path,
        'kota': user.kota,
        'tempatLahir': user.tempatLahir,
        'tanggalLahir': user.tanggalLahir,
        'nomorIdentitas': user.nomorIdentitas,
        'isOrder': false,
        'kecamatan': user.kecamatan,
        'kelurahan': user.kelurahan,
        'rt': user.rt,
        'rw': user.rw,
        'statusPerkawinan': user.statusPerkawinan,
        'agama': user.agama,
        'isValid': false,
      });
      return user;
    } catch (e) {
      rethrow;
    }
  }


  Future<void> updateProfile(UserModel user)async{
    try{
      var userById = await _userReference.doc(user.id);
      await userById.update({
        'namaLengkap': user.namaLengkap,
        'alamat': user.alamat,
        'provinsi': user.provinsi,
        'kota': user.kota,
        'kecamatan': user.kecamatan,
        'kelurahan': user.kelurahan,
        'rt': user.rt,
        'rw': user.rw,
        'statusPerkawinan': user.statusPerkawinan,
        'agama': user.agama,
      });

    }catch(e){
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      var tanggalLahir = snapshot['tanggalLahir'];
      DateTime date = tanggalLahir.toDate();
      var tanggalPinalty = snapshot['pinalty']??null;
      DateTime? tglPinaltyToDateTime = tanggalPinalty!=null? tanggalPinalty.toDate():null;
      return UserModel(
        id: id,
        uuid: snapshot['uuid'],
        email: snapshot['email'],
        namaLengkap: snapshot['namaLengkap'],
        password: '',
        pinalty: tglPinaltyToDateTime,
        jenisIdentitas: snapshot['jenisIdentitas'],
        provinsi: snapshot['provinsi'],
        kota: snapshot['kota'],
        role: snapshot['role'],
        photoProfile: snapshot['photoProfile'],
        alamat: snapshot['alamat'],
        nomorIdentitas: snapshot['nomorIdentitas'],
        tanggalLahir: date,
        tempatLahir: snapshot['tempatLahir'],
        isOrder: snapshot['isOrder'],
        kecamatan: snapshot['kecamatan'],
        kelurahan: snapshot['kelurahan'],
        rt: snapshot['rt'],
        rw: snapshot['rw'],
        statusPerkawinan: snapshot['statusPerkawinan'],
        agama: snapshot['agama'],
        isValid: snapshot['isValid'],
      );
    } catch (e) {
      rethrow;
    }
  }
}

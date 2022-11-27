import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_perpus/model/buku_model.dart';

class BukuService {
  final CollectionReference _bukuReference =
      FirebaseFirestore.instance.collection('Buku');
  Reference ref = FirebaseStorage.instance.ref();

  Future<BukuModel> simpanGambar(BukuModel buku, File coverFile) async {
    try {

      final metadata = SettableMetadata(
        customMetadata: {'picked-file-path': coverFile.path},
      );

      String fileName =
          "${DateTime.now().millisecond}-${DateTime.now().minute}-${DateTime.now().hour}-${DateTime.now().day}-${DateTime.now().month}-buku";
      fileName += coverFile.path.split('/').last;
      var result = await ref.child(fileName).putFile(coverFile, metadata);
      result.ref.getDownloadURL();

      String path = await result.ref.getDownloadURL();
      buku.gambar = path;
      return buku;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setBuku(BukuModel bukuModel)async{
      try{
       await  _bukuReference.doc().set({
         'gambar': bukuModel.gambar,
         'judul': bukuModel.judul,
         'anakJudul': bukuModel.anakJudul,
         'pengarang': bukuModel.pengarang,
         'pengarangTambahan': bukuModel.pengarangTambahan,
         'penerbit': bukuModel.penerbit,
         'tempatTerbit': bukuModel.tempatTerbit,
         'tahunTerbit': bukuModel.tahunTerbit,
         'jumlahHalaman': bukuModel.jumlahHalaman,
         'keteranganIlustrasi': bukuModel.keteranganIlustrasi,
         'dimensi': bukuModel.dimensi,
         'edisi': bukuModel.edisi,
         'subjek': bukuModel.subjek,
         'noKlass': bukuModel.noKlass,
         'noPanggil': bukuModel.noPanggil,
         'ISBN': bukuModel.ISBN,
         'bahasa': bukuModel.bahasa,
         'bentukKaryaTulis': bukuModel.bentukKaryaTulis,
         'kelompokSasaran': bukuModel.kelompokSasaran,
         'lokasiKoleksiDaring': bukuModel.lokasiKoleksiDaring,
         'stok': bukuModel.stok
        });
      }catch(e){
        rethrow;
      }
  }

  Future<void> deleteBuku(String id)async{
    try{
      var bukuById = await _bukuReference.doc(id);
      bukuById.delete();
    }catch(e){
      rethrow;
    }
  }

  Future<void> updateBuku(BukuModel bukuModel)async{
    try{
      var bukuById = await _bukuReference.doc(bukuModel.id);
      await bukuById.update({
        'gambar': bukuModel.gambar,
        'judul': bukuModel.judul,
        'anakJudul': bukuModel.anakJudul,
        'pengarang': bukuModel.pengarang,
        'pengarangTambahan': bukuModel.pengarangTambahan,
        'penerbit': bukuModel.penerbit,
        'tempatTerbit': bukuModel.tempatTerbit,
        'tahunTerbit': bukuModel.tahunTerbit,
        'jumlahHalaman': bukuModel.jumlahHalaman,
        'keteranganIlustrasi': bukuModel.keteranganIlustrasi,
        'dimensi': bukuModel.dimensi,
        'edisi': bukuModel.edisi,
        'subjek': bukuModel.subjek,
        'noKlass': bukuModel.noKlass,
        'noPanggil': bukuModel.noPanggil,
        'ISBN': bukuModel.ISBN,
        'bahasa': bukuModel.bahasa,
        'bentukKaryaTulis': bukuModel.bentukKaryaTulis,
        'kelompokSasaran': bukuModel.kelompokSasaran,
        'lokasiKoleksiDaring': bukuModel.lokasiKoleksiDaring,
        'stok': bukuModel.stok
      });

    }catch(e){
      rethrow;
    }
  }

  Future<List<BukuModel>> getAllBuku()async{
    try{
      print("Get Buku From Firbase");
      QuerySnapshot result = await _bukuReference.get();
      List<BukuModel> bukuFromFirebase = result.docs.map((e){
        return BukuModel.fromjson(e.data() as Map<String, dynamic>, e.id);
      }).toList();

      return bukuFromFirebase;
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

}

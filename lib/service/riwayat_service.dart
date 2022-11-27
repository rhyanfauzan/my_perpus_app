import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_perpus/model/peminjaman_model.dart';

class RiwayatService{
  final CollectionReference _peminjamanReference =
  FirebaseFirestore.instance.collection('Peminjaman');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _bukuReference =
  FirebaseFirestore.instance.collection('Buku');

  Future<List<PeminjamanModel>> getMyPeinjaman()async{
    try{
      var myId = _auth.currentUser!.uid;
      QuerySnapshot result = await _peminjamanReference.where("idUser",isEqualTo: myId).get();
      print(result.size);
      List<PeminjamanModel> listPeminjaman = result.docs.map((e){
        return PeminjamanModel.fromjson(e.data() as Map<String, dynamic>, e.id);
      }).toList();
      return listPeminjaman;
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

}
class BukuModel {
  String? id;
  String? gambar;
  int stok;
  String judul;
  String anakJudul;
  String pengarang;
  String? pengarangTambahan;
  String penerbit;
  String tempatTerbit;
  String tahunTerbit;
  int jumlahHalaman;
  String keteranganIlustrasi;
  String dimensi;
  String edisi;
  String subjek;
  String noKlass;
  String noPanggil;
  String ISBN;
  String bahasa;
  String bentukKaryaTulis;
  String kelompokSasaran;
  String lokasiKoleksiDaring;

  BukuModel({
    this.id,
    this.gambar,
    required this.stok,
    required this.judul,
    required this.anakJudul,
    required this.pengarang,
    this.pengarangTambahan,
    required this.penerbit,
    required this.tempatTerbit,
    required this.tahunTerbit,
    required this.jumlahHalaman,
    required this.keteranganIlustrasi,
    required this.dimensi,
    required this.edisi,
    required this.subjek,
    required this.noKlass,
    required this.noPanggil,
    required this.ISBN,
    required this.bahasa,
    required this.bentukKaryaTulis,
    required this.kelompokSasaran,
    required this.lokasiKoleksiDaring,
  });

  factory BukuModel.fromjson(Map<String, dynamic> json, String id) {
    return BukuModel(
      id: id,
      gambar: json['gambar'],
      judul: json['judul'],
      anakJudul: json['anakJudul'],
      pengarang: json['pengarang'],
      pengarangTambahan: json['pengarangTambahan'],
      penerbit: json['penerbit'],
      tempatTerbit: json['tempatTerbit'],
      tahunTerbit: json['tahunTerbit'],
      jumlahHalaman: json['jumlahHalaman'],
      keteranganIlustrasi: json['keteranganIlustrasi'],
      dimensi: json['dimensi'],
      edisi: json['edisi'],
      subjek: json['subjek'],
      noKlass: json['noKlass'],
      noPanggil: json['noPanggil'],
      ISBN: json['ISBN'],
      bahasa: json['bahasa'],
      bentukKaryaTulis: json['bentukKaryaTulis'],
      kelompokSasaran: json['kelompokSasaran'],
      lokasiKoleksiDaring: json['lokasiKoleksiDaring'],
      stok: json['stok'],
    );
  }

  factory BukuModel.fromjsonWithId(Map<String, dynamic> json) {
    return BukuModel(
      id: json['id'],
      gambar: json['gambar'],
      judul: json['judul'],
      anakJudul: json['anakJudul'],
      pengarang: json['pengarang'],
      pengarangTambahan: json['pengarangTambahan'],
      penerbit: json['penerbit'],
      tempatTerbit: json['tempatTerbit'],
      tahunTerbit: json['tahunTerbit'],
      jumlahHalaman: json['jumlahHalaman'],
      keteranganIlustrasi: json['keteranganIlustrasi'],
      dimensi: json['dimensi'],
      edisi: json['edisi'],
      subjek: json['subjek'],
      noKlass: json['noKlass'],
      noPanggil: json['noPanggil'],
      ISBN: json['ISBN'],
      bahasa: json['bahasa'],
      bentukKaryaTulis: json['bentukKaryaTulis'],
      kelompokSasaran: json['kelompokSasaran'],
      lokasiKoleksiDaring: json['lokasiKoleksiDaring'],
      stok: json['stok'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'gambar': gambar,
        'judul': judul,
        'anakJudul': anakJudul,
        'pengarang': pengarang,
        'pengarangTambahan': pengarangTambahan,
        'penerbit': penerbit,
        'tempatTerbit': tempatTerbit,
        'tahunTerbit': tahunTerbit,
        'jumlahHalaman': jumlahHalaman,
        'keteranganIlustrasi': keteranganIlustrasi,
        'dimensi': dimensi,
        'edisi': edisi,
        'subjek': subjek,
        'noKlass': noKlass,
        'noPanggil': noPanggil,
        'ISBN': ISBN,
        'bahasa': bahasa,
        'bentukKaryaTulis': bentukKaryaTulis,
        'kelompokSasaran': kelompokSasaran,
        'lokasiKoleksiDaring': lokasiKoleksiDaring,
        'stok': stok
      };
}

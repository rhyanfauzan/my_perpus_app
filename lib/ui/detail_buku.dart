import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/ui/widget/vertical_title_value.dart';

class BukuDetailPage extends StatefulWidget {
  const BukuDetailPage({Key? key}) : super(key: key);

  @override
  _BukuDetailPageState createState() => _BukuDetailPageState();
}

class _BukuDetailPageState extends State<BukuDetailPage> {
  BukuModel bukuDetail = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CachedNetworkImage(
                      imageUrl: bukuDetail.gambar!,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fitHeight),
                        ),
                        foregroundDecoration: bukuDetail.stok > 0
                            ?
                        BoxDecoration()
                            : BoxDecoration(
                          color: ColorPalette.generalSoftGrey,
                          backgroundBlendMode: BlendMode.saturation,
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      bukuDetail.judul,
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    VerticalTitleValue(
                        title: 'Anak Judul',
                        value: bukuDetail.anakJudul),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Keterangan Ilustasi',
                        value:  bukuDetail.keteranganIlustrasi),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Subjek',
                        value:  bukuDetail.subjek),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Pengarang',
                        value: bukuDetail.pengarang),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Pengarang Tambahan',
                        value: bukuDetail.pengarangTambahan??"-"),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Penerbit',
                        value: bukuDetail.penerbit),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Jenis Buku',
                        value: bukuDetail.bentukKaryaTulis),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Tahun Terbit',
                        value:  bukuDetail.tahunTerbit),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Tempat Terbit',
                        value:  bukuDetail.tempatTerbit),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Bentuk Karya Tulis',
                        value:  bukuDetail.bentukKaryaTulis),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'ISBN',
                        value:  bukuDetail.ISBN),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Bahasa',
                        value:  bukuDetail.bahasa),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Dimensi',
                        value:  bukuDetail.dimensi),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Edisi',
                        value:  bukuDetail.edisi),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Jumlah Halaman',
                        value:  bukuDetail.jumlahHalaman.toString()),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Kelompok Sasaran',
                        value:  bukuDetail.kelompokSasaran),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'No Klass',
                        value:  bukuDetail.noKlass),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'No Panggil',
                        value:  bukuDetail.noPanggil),
                    SizedBox(height: 15),
                    VerticalTitleValue(
                        title: 'Lokasi Koleksi Daring',
                        value:  bukuDetail.lokasiKoleksiDaring),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

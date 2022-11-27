import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/provider/peminjaman.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/horizontal_book.dart';
import 'package:my_perpus/ui/widget/vertical_title_value.dart';
import 'package:provider/provider.dart';

class UserDetailBukuPage extends StatelessWidget {
  const UserDetailBukuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer3<BukuProvider, PeminjamanProvider, AuthProvider>(
            builder: (context, valueBuku, valuePeminjaman, valuAuth, _) {
          return Padding(
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
                          imageUrl: valueBuku.bukuDetail!.gambar!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fitHeight),
                            ),
                            foregroundDecoration: valueBuku.bukuDetail!.stok > 0
                                ? BoxDecoration()
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
                          valueBuku.bukuDetail!.judul,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        VerticalTitleValue(
                            title: 'Anak Judul',
                            value: valueBuku.bukuDetail!.anakJudul),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Keterangan Ilustasi',
                            value: valueBuku.bukuDetail!.keteranganIlustrasi),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Subjek',
                            value: valueBuku.bukuDetail!.subjek),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Pengarang',
                            value: valueBuku.bukuDetail!.pengarang),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Pengarang Tambahan',
                            value:
                                valueBuku.bukuDetail!.pengarangTambahan ?? "-"),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Penerbit',
                            value: valueBuku.bukuDetail!.penerbit),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Jenis Buku',
                            value: valueBuku.bukuDetail!.bentukKaryaTulis),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Tahun Terbit',
                            value: valueBuku.bukuDetail!.tahunTerbit),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Tempat Terbit',
                            value: valueBuku.bukuDetail!.tempatTerbit),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Bentuk Karya Tulis',
                            value: valueBuku.bukuDetail!.bentukKaryaTulis),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'ISBN', value: valueBuku.bukuDetail!.ISBN),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Bahasa',
                            value: valueBuku.bukuDetail!.bahasa),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Dimensi',
                            value: valueBuku.bukuDetail!.dimensi),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Edisi', value: valueBuku.bukuDetail!.edisi),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Jumlah Halaman',
                            value:
                                valueBuku.bukuDetail!.jumlahHalaman.toString()),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Kelompok Sasaran',
                            value: valueBuku.bukuDetail!.kelompokSasaran),
                        SizedBox(height: 15),
                        VerticalTitleValue(
                            title: 'Stok Buku',
                            value: valueBuku.bukuDetail!.stok.toString()),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                  if (valuAuth.user.isValid)
                    if (!valuePeminjaman.riwayatSaya
                            .any((element) => element.status < 3) ||
                        valuePeminjaman.riwayatSaya.isEmpty)
                      if (valueBuku.bukuDetail!.stok > 0)
                        if (valuePeminjaman.keranjang.length < 3)
                          if (!valuePeminjaman.keranjang.any((element) =>
                              element.id == valueBuku.bukuDetail!.id))
                            if (valuAuth.user.pinalty != null &&
                                getDurationDifferenceInt(DateTime.now(),
                                        valuAuth.user.pinalty!) <
                                    0)
                              ButtonRounded(
                                text: "Tambah Buku",
                                onPressed: () {
                                  Provider.of<PeminjamanProvider>(context,
                                          listen: false)
                                      .tambahKeKeranjang(valueBuku.bukuDetail!);
                                  Get.back();
                                },
                              )
              ],
            ),
          );
        }),
      ),
    );
  }
}

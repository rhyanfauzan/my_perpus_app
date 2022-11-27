import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/provider/peminjaman.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/book_container.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    final _refreshController = RefreshController();
    return Scaffold(
      body: Consumer3<BukuProvider, PeminjamanProvider,AuthProvider>(
          builder: (context, valueBuku, valuePeminjaman,valueAuth, child) {
        return SmartRefresher(
          controller: _refreshController,
          onRefresh: () async {
            await Provider.of<BukuProvider>(context, listen: false)
                .doGetAllBook();
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
          },
          onLoading: () async {
            await Provider.of<BukuProvider>(context, listen: false)
                .doGetAllBook();
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(!valueAuth.user.isValid)
                Container(
                  padding: EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(color: ColorPalette.generalSoftYellow),
                  child: Text(
                    "Keanggotan anda belum tervalidasi oleh admin. anda hanya bisa melihat buku yang tersedia pada aplikasi ini.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                if(valueAuth.user.pinalty!=null && getDurationDifferenceInt(DateTime.now(), valueAuth.user.pinalty!)>=0)
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration:
                    BoxDecoration(color: ColorPalette.generalSoftYellow),
                    child: Text(
                      "Maaf anda tidak dapat meminjam buku sampai tanggal ${parseDate(valueAuth.user.pinalty.toString())} dikarenakan "
                          "keterlambatan pengembalian buku",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        onTapSearch: () => Get.toNamed(Routes.search),
                        enable: false,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.userKeranjang),
                      child: Stack(
                        children: [
                          if (valuePeminjaman.keranjang.isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              child: Text(
                                valuePeminjaman.keranjang.length.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12, left: 5),
                            child: Icon(
                              Icons.card_travel,
                              color: ColorPalette.generalPrimaryColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15)
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Buku",
                    style: TextStyle(
                      fontSize: 24,
                      color: ColorPalette.generalPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: valueBuku.listBuku.length,
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 20),
                        child: BookContainer(
                          bukuModel: valueBuku.listBuku[index],
                          onTapBook: () {
                            Provider.of<BukuProvider>(context, listen: false)
                                .clickBukuDetail(valueBuku.listBuku[index]);
                            Get.toNamed(Routes.detailBuku);
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "lebih banyak buku",
                    style: TextStyle(
                      fontSize: 24,
                      color: ColorPalette.generalPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.45,
                        crossAxisSpacing: 20,
                    ),
                    itemCount: valueBuku.listBuku.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BookContainer(
                        imageHeight: 180,
                        bukuModel: valueBuku.listBuku[index],
                        onTapBook: () {
                          Provider.of<BukuProvider>(context, listen: false)
                              .clickBukuDetail(valueBuku.listBuku[index]);
                          Get.toNamed(Routes.detailBuku);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

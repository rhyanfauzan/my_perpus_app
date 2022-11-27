import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_perpus/provider/admin.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/search_bar.dart';
import 'package:my_perpus/ui/widget/status_peminjaman.dart';
import 'package:provider/provider.dart';

class AdminSearchPage extends StatelessWidget {
  const AdminSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<AdminProvider>(builder: (context, value, _) {
          return Column(
            children: [
              SizedBox(height: 15),
              SearchBar(
                title: "Cari nomor peminjaman",
                onSubmit: (val) {
                  Provider.of<AdminProvider>(context, listen: false)
                      .searchPeminjamanById(val);
                },
              ),
              SizedBox(height: 15),
              if(value.searchPeminjaman!=null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: (){
                      Provider.of<AdminProvider>(context, listen: false)
                          .onClickDetailPeminjaman(
                          value.searchPeminjaman!);
                      Get.toNamed(Routes.adminDetail);
                    },
                    child: StatusPeminjaman(
                      peminjamanModel:value.searchPeminjaman!,
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

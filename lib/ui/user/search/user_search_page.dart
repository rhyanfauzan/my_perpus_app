import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/horizontal_book.dart';
import 'package:my_perpus/ui/widget/search_bar.dart';
import 'package:provider/provider.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({Key? key}) : super(key: key);

  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<BukuProvider>(builder: (context, value, _) {
          return Column(
            children: [
              SizedBox(height: 15),
              SearchBar(
                onChanged: (val) {
                  Provider.of<BukuProvider>(context, listen: false)
                      .searchBook(val);
                },
              ),
              SizedBox(height: 15),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.searchResult.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: GestureDetector(
                              onTap: (){
                                Provider.of<BukuProvider>(context,listen: false).clickBukuDetail( value.searchResult[index]);
                                Get.toNamed(Routes.detailBuku);
                              },
                              child: HorizontalBook(
                                bukuModel: value.searchResult[index],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

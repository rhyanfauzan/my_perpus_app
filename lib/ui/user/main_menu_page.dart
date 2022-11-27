import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/provider/peminjaman.dart';
import 'package:my_perpus/service/notification.dart';
import 'package:my_perpus/ui/user/home/user_home_page.dart';
import 'package:my_perpus/ui/user/profile/user_profile_page.dart';
import 'package:my_perpus/ui/user/riwayat/user_riwayat_page.dart';
import 'package:provider/provider.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);


  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int _selectedIndex = 0;
  bool getData = true;

  @override
  void initState() {
    if(getData){
      Provider.of<BukuProvider>(context, listen: false).doGetAllBook();
      Provider.of<PeminjamanProvider>(context, listen: false).getRiwayatSaya();
      getData = false;



    }
    super.initState();
  }



  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _pageption = <Widget>[
    UserHomePage(),
    UserRiwayatPage(),
    UserProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<PeminjamanProvider>(
      builder: (context,peminjaman,_) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorPalette.generalPrimaryColor,
            selectedItemColor: ColorPalette.generalWhite,
            unselectedItemColor: Colors.grey,
            onTap: (index){
              _onItemTap(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
          body: SafeArea(
            child: _pageption[_selectedIndex],
          ),
        );
      }
    );
  }
}

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/local_storage_service.dart';
import 'package:my_perpus/model/user_model.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/setup_locator.dart';
import 'package:provider/provider.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    navigated(context);
    return Scaffold(
      backgroundColor: ColorPalette.generalBackgroundColor,
      body: Center(
        child: Text(
          "MyPerpus",
          style: TextStyle(
            color: ColorPalette.generalPrimaryColor,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  navigated(BuildContext context) async {
    var storageService = locator<LocalStorageService>();
    var role = storageService.getIntFromPref(Constants.role);
    String? userJson = storageService.getStringFromPref(Constants.userModel);

    var user = await FirebaseAuth.instance.currentUser??null;

    await Future.delayed(const Duration(seconds: 2), () async {
      if (user==null) {
        Get.offAllNamed(Routes.login);
      } else if(role==1){
        UserModel userModel = UserModel.fromjson(jsonDecode(userJson!), user.uid);
        Provider.of<AuthProvider>(context,listen: false).setUserModelFromPref(userModel);
        Get.offAllNamed(Routes.adminInfo);
      }else if(role==2){
        UserModel userModel = UserModel.fromjson(jsonDecode(userJson!), user.uid);
        Provider.of<AuthProvider>(context,listen: false).setUserModelFromPref(userModel);
        Get.offAllNamed(Routes.pustawakan);
      }else{
        UserModel? userModel = UserModel.fromjson(jsonDecode(userJson!), user.uid);
        Provider.of<AuthProvider>(context,listen: false).setUserModelFromPref(userModel);
        Get.offAllNamed(Routes.mainMenu);
      }
    });
  }
}

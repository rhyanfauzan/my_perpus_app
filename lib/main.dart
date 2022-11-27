import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/injection.dart';
import 'package:my_perpus/local_storage_service.dart';
import 'package:my_perpus/provider/admin.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/provider/peminjaman.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/setup_locator.dart';
import 'package:provider/provider.dart';

import 'service/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection();
  await NotificationService().init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  setupLocator().then((value) {
    // Workmanager().initialize(
    //     callbackDispatcher, // The top level function, aka callbackDispatcher
    //     isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
    // );
    // Workmanager().registerPeriodicTask("peminjaman", "peminjaman",frequency: Duration(minutes: 1));
    runApp(MyApp());
    runApp(const MyApp());
  });
}

setUpNotification() async {
  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: null);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => BukuProvider()),
        ChangeNotifierProvider(create: (context) => PeminjamanProvider()),
        ChangeNotifierProvider(create: (context) => AdminProvider()),
      ],
      child: GetMaterialApp(
        builder: EasyLoading.init(),
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        color: ColorPalette.generalBackgroundColor,
        title: 'MyPerpus',
        initialRoute: Routes.navigator,
        getPages: Routes.newRoutes,
        theme: ThemeData(
          primaryColor: ColorPalette.generalPrimaryColor,
          backgroundColor: ColorPalette.generalBackgroundColor,
          appBarTheme: AppBarTheme(
              color: ColorPalette.generalPrimaryColor,
              iconTheme:
                  IconThemeData(color: ColorPalette.generalPrimaryColor)),
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }
}

void callbackDispatcher() {
  // var storageService = locator<LocalStorageService>();
  // var bookName =storageService.getStringFromPref(Constants.notifikasiPengembalian);
  // if(bookName!=null){
  //   Workmanager().executeTask((task, inputData) async{
  //     await NotificationService.flutterLocalNotificationsPlugin.show(
  //         12345,
  //         "Pengembalian Buku",
  //         "Harap mengembalikan buku $bookName",
  //         platformChannelSpecifics,);
  //     return Future.value(true);
  //   });
  // }

  // Workmanager().executeTask((task, inputData) async{
  //   await NotificationService.flutterLocalNotificationsPlugin.show(
  //     12345,
  //     "Pengembalian Buku",
  //     "Harap mengembalikan buku",
  //     platformChannelSpecifics,);
  //   return Future.value(true);
  // });
}

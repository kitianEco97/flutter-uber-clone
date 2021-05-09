import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:clone_uber_app/src/pages/home/home_page.dart';
import 'package:clone_uber_app/src/pages/login/login_page.dart';
import 'package:clone_uber_app/src/pages/client/register/client_register_page.dart';
import 'package:clone_uber_app/src/pages/driver/register/driver_register_page.dart';
import 'package:clone_uber_app/src/pages/client/map/client_map_page.dart';
import 'package:clone_uber_app/src/pages/driver/map/driver_map_page.dart';

import 'package:clone_uber_app/src/utils/colors.dart' as utils;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Uber Clone',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      theme: ThemeData(
          fontFamily: 'NimbusSans',
          appBarTheme: AppBarTheme(
              elevation: 0
          ),
          primaryColor: utils.Colors.uber_clone_color
      ),
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'login': (BuildContext context) => LoginPage(),
        'client/register': (BuildContext context) => ClientRegisterPage(),
        'driver/register': (BuildContext context) => DriverRegisterPage(),
        'driver/map': (BuildContext context) => DriverMapPage(),
        'client/map': (BuildContext context) => ClientMapPage(),
      },
    );
  }
}

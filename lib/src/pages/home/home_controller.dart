import 'package:flutter/material.dart';
import 'package:clone_uber_app/src/utils/shared_pref.dart';
import 'package:clone_uber_app/src/providers/auth_provider.dart';

class HomeController {

  BuildContext context;
  SharedPref _sharedPref;

  AuthProvider _authProvider;
  String _typeUser;

  Future init(BuildContext context) async {
    this.context = context;
    _sharedPref = new SharedPref();
    _authProvider = new AuthProvider();

    _typeUser = await _sharedPref.read('typeUser');
    //checkIfUserIsAuth();
  }

  void checkIfUserIsAuth() {
    bool isSigned = _authProvider.isSignedIn();
    if (isSigned) {
      print('SI ESTA LOEGADO');
      if (_typeUser == 'client') {
        Navigator.pushNamedAndRemoveUntil(context, 'client/map', (route) => false);
      }
      else {
        Navigator.pushNamedAndRemoveUntil(context, 'driver/map', (route) => false);
      }
    }
    else {
      print('NO ESTA LOGEADO');
    }
  }

  void goToLoginPage(String typeUser) {
    saveTypeUser(typeUser);
    Navigator.pushNamed(context, 'login');
  }

  void saveTypeUser(String typeUser) async {
    await _sharedPref.save('typeUser', typeUser);
  }

}
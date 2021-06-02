import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

import 'package:clone_uber_app/src/providers/auth_provider.dart';
import 'package:clone_uber_app/src/providers/client_provider.dart';
import 'package:clone_uber_app/src/providers/storage_provider.dart';

import 'package:clone_uber_app/src/utils/snackbar.dart' as utils;
import 'package:clone_uber_app/src/utils/my_progress_dialog.dart';

import 'package:clone_uber_app/src/models/client.dart';

class ClientEditController {

  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  AuthProvider _authProvider;
  ClientProvider _clientProvider;
  ProgressDialog _progressDialog;
  StorageProvider _storageProvider;

  PickedFile pickedFile;
  File imageFile;

  Future init (BuildContext context, Function refresh){
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _storageProvider = new StorageProvider();
    _progressDialog = MyProgressDialog.createProgressDialog(context, "Espere un momento...");
  }

  void showAlertDialog() {

    Widget galleryButton = FlatButton(
        onPressed: (){
          getImageFromGallery(ImageSource.gallery);
        },
        child: Text('GALERIA'),
    );

    Widget cameraButton = FlatButton(
      onPressed: (){
        getImageFromGallery(ImageSource.camera);
      },
      child: Text('CAMARA'),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );
    
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }

  void update() async {
    String username = usernameController.text;

    if(username.isEmpty){
      print('debes ingresar todos los campos');
      utils.Snackbar.showSnackbar(context, key, 'debes ingresar todos los campos');
      return;
    }

    _progressDialog.show();
    TaskSnapshot snapshot = await _storageProvider.uploadFile(pickedFile);
    String imageUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> data = {
      'image' : imageUrl
    };

    await _clientProvider.update(data, _authProvider.getUser().uid);
    _progressDialog.hide();
    utils.Snackbar.showSnackbar(context, key, 'Los datos se actualizarón');
  }

  Future getImageFromGallery(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile != null) {
      imageFile = File(pickedFile.path);
    } else {
      print('No se selecciono ninguna imagen');
    }

    Navigator.pop(context);
    refresh();
  }

}
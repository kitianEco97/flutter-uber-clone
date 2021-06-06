import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:clone_uber_app/src/utils/otp_widget.dart';

import 'package:clone_uber_app/src/pages/driver/edit/driver_edit_controller.dart';

import 'package:clone_uber_app/src/utils/colors.dart' as utils;

import 'package:clone_uber_app/src/widgets/button_app.dart';

class DriverEditPage extends StatefulWidget {
  @override
  _DriverEditPageState createState() => _DriverEditPageState();
}

class _DriverEditPageState extends State<DriverEditPage> {

  DriverEditController _controller = new DriverEditController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('InitState');

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.key,
      appBar: AppBar(),
      bottomNavigationBar: _buttonRegister(),
      body: SingleChildScrollView(
        child: Column(
          children: [

            _bannerApp(),

            _textLogin(),

             _textLicencePlate(),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: OTPFields(
                pin1: _controller.pin1Controller,
                pin2: _controller.pin2Controller,
                pin3: _controller.pin3Controller,
                pin4: _controller.pin4Controller,
                pin5: _controller.pin5Controller,
                pin6: _controller.pin6Controller,
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            _textFieldUserName(),

          ],
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 25
      ),
      child: ButtonApp(
        onPressed: _controller.update,
        text:  'Actualizar ahora',
        color: utils.Colors.uber_clone_color,
        textColor: Colors.white,
      ),
    );
  }

  Widget _textFieldUserName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _controller.usernameController,
        decoration: InputDecoration(
            hintText: 'kitian perez',
            labelText: 'Nombre de usuario',
            suffixIcon: Icon(
              Icons.person_outline,
              color: utils.Colors.uber_clone_color,
            )
        ),
      ),
    );
  }

  Widget _textLicencePlate(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Placa del vehiculo',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 17
        ),
      ),
    );
  }

  Widget _textLogin(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: Text(
        'Registro',
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25
        ),
      ),
    );
  }

  Widget _bannerApp() {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: utils.Colors.uber_clone_color,
        height: MediaQuery.of(context).size.height * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            GestureDetector(
              onTap: _controller.showAlertDialog,
              child: CircleAvatar(
                backgroundImage: _controller.imageFile != null ?
                AssetImage(_controller.imageFile?.path?? 'assets/img/profile.jpg') :
                _controller.driver?.image != null
                    ? NetworkImage(_controller.driver?.image)
                    : AssetImage(_controller.imageFile?.path?? 'assets/img/profile.jpg'),
                radius: 50,
              ),
            ),

            Container(
              margin: EdgeInsets.only(top:30),
              child: Text(
                _controller.driver?.email ?? '',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {

    });
  }

}

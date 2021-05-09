import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:clone_uber_app/src/pages/driver/map/driver_map_controller.dart';
import 'package:clone_uber_app/src/widgets/button_app.dart';

class DriverMapPage extends StatefulWidget {
  @override
  _DriverMapPageState createState() => _DriverMapPageState();
}

class _DriverMapPageState extends State<DriverMapPage> {

  DriverMapController _controller = new DriverMapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _googleMapsWidget(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonDrawer(),
                    _buttonCenterPosition()
                  ],
                ),
                Expanded(child: Container() ),
                _buttonConnect()
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _buttonCenterPosition(){
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        shape: CircleBorder(),
        color: Colors.white,
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
              Icons.location_searching,
              color: Colors.grey[600],
              size: 20
          ),
        ),
      ),
    );
  }

  Widget _buttonDrawer(){
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: (){},
        icon: Icon(Icons.menu, color: Colors.white ),
      ),
    );
  }

  Widget _buttonConnect() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: ButtonApp(
        text: 'CONECTSRSE',
        color: Colors.amber,
        textColor: Colors.black,
      ),
    );
  }

  Widget _googleMapsWidget() {
    return GoogleMap(
      mapType: MapType.normal,
        initialCameraPosition: _controller.initialPosition,
        onMapCreated: _controller.onMapCreated,
        myLocationButtonEnabled: false ,
    );
  }
}

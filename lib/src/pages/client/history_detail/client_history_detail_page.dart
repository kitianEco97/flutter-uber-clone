import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:clone_uber_app/src/pages/client/history_detail/client_history_detail_controller.dart';

import 'package:clone_uber_app/src/utils/colors.dart' as utils;

class ClientHistoryDetailPage extends StatefulWidget {
  @override
  _ClientHistoryDetailPageState createState() => _ClientHistoryDetailPageState();
}

class _ClientHistoryDetailPageState extends State<ClientHistoryDetailPage> {

  ClientHistoryDetailController _controller = new ClientHistoryDetailController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del historial'),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [

            _bannerInfoDriver(),
            _listTileInfo('Lugar de recogidfa', _controller.travelHistory?.from, Icons.location_on),
            _listTileInfo('Destino', _controller.travelHistory?.to, Icons.location_searching),
            _listTileInfo('Mi calificación', _controller.travelHistory?.calificationClient?.toString(), Icons.star_border),
            _listTileInfo('Calificación del conductor', _controller.travelHistory?.calificationDriver?.toString(), Icons.star),
            _listTileInfo('Precio del viaje', '${_controller.travelHistory?.price?.toString() ?? '0\$' }', Icons.monetization_on),

          ],

        ),
      ),
    );
  }

  Widget _listTileInfo(String title, String value, IconData icon) {
    return ListTile(
      title: Text(
          title ?? ''
      ),
      subtitle: Text(value ?? ''),
      leading: Icon(icon),
    );
  }

  Widget _bannerInfoDriver() {
    return ClipPath(
      clipper: DiagonalPathClipperTwo(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: double.infinity,
        color: utils.Colors.uber_clone_color,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            CircleAvatar(
              backgroundImage: _controller.driver?.image != null
                  ? NetworkImage(_controller.driver?.image)
                  : AssetImage('assets/img/profile.jpg'),
              radius: 50,
            ),
            SizedBox(height: 10),
            Text(
                _controller.driver?.username ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17
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

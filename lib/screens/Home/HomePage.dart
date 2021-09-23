import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return FlutterMap(
    options: MapOptions(
      center: latLng.LatLng(51.5, -0.09),
      zoom: 13.0,
    ),
    layers: [
      TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c'],
        attributionBuilder: (_) {
          return Text("Vendo");
        },
      ),
      MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: latLng.LatLng(51.5, -0.09),
            builder: (ctx) =>
            Container(
              child: Container(),
            ),
          ),
        ],
      ),
    ],
  );
  
}

}

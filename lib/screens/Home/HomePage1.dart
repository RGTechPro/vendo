import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Random _random = Random();
    var markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(
            _random.nextDouble() * 10+20, _random.nextDouble() *10+70
        ),
        builder: (ctx) => Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/p1.png'),
              backgroundColor: _ColorGenerator.getColor(),
            )),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(
            _random.nextDouble() * 10+20, _random.nextDouble() *10+70
        ),
        builder: (ctx) => Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/p1.png'),
              backgroundColor: _ColorGenerator.getColor(),
            )),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(
            _random.nextDouble() * 10+20, _random.nextDouble() *10+70
        ),
        builder: (ctx) => Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/p1.png'),
              backgroundColor: _ColorGenerator.getColor(),
            )),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(
            _random.nextDouble() * 10+20, _random.nextDouble() *10+70
        ),
        builder: (ctx) => Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/p1.png'),
              backgroundColor: _ColorGenerator.getColor(),
            )),
      ),

    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(28.7041, 77.1025),
                  zoom: 5.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: NonCachingNetworkTileProvider(),
                  ),
                  MarkerLayerOptions(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorGenerator {
  static List colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.indigo,
    Colors.amber,
    Colors.black,
    Colors.white,
    Colors.brown,
    Colors.pink,
    Colors.cyan
  ];

  static final Random _random = Random();

  static Color getColor() {
    return colorOptions[_random.nextInt(colorOptions.length)];
  }
}
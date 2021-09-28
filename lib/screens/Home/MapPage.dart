import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final PopupController _popupController = PopupController();

  List<Marker>? markers;
  int? pointIndex;
  List points = [
    LatLng(51.5, -0.09),
    LatLng(49.8566, 3.3522),
  ];
  LatLng focus = LatLng(30, 69);

  @override
  void initState() {
    pointIndex = 0;
    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: points[pointIndex!],
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(49.8566, 3.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
    ];

    locationGetter();
    
    Location location = new Location();
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
    });

    super.initState();
  }

  Future<void> locationGetter() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    // setState(() {
    //   focus = LatLng(_locationData.latitude!, _locationData.longitude!);
    // });

    print(_locationData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pointIndex = pointIndex! + 1;
          if (pointIndex! >= points.length) {
            pointIndex = 0;
          }
          setState(() {
            markers![0] = Marker(
              point: points[pointIndex!],
              anchorPos: AnchorPos.align(AnchorAlign.center),
              height: 30,
              width: 30,
              builder: (ctx) => Icon(Icons.pin_drop),
            );
            markers = List.from(markers!);
          });
        },
        child: Icon(Icons.refresh),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: focus,
          zoom: 5,
          maxZoom: 15,
          plugins: [
            MarkerClusterPlugin(),
          ],
          onTap: (_, __) => _popupController
              .hidePopup(), // Hide popup when the map is tapped.
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            size: Size(40, 40),
            anchor: AnchorPos.align(AnchorAlign.center),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: markers!,
            polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 3),
            popupOptions: PopupOptions(
                popupSnap: PopupSnap.markerTop,
                popupController: _popupController,
                popupBuilder: (_, marker) => Container(
                      width: 200,
                      height: 100,
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () => debugPrint('Popup tap!'),
                        child: Text(
                          'Container popup for marker at ${marker.point}',
                        ),
                      ),
                    )),
            builder: (context, markers) {
              return FloatingActionButton(
                onPressed: null,
                child: Text(markers.length.toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skku_buildings_mobile/atoms/my_location_icon.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BuildingMapTemplate extends StatefulWidget {
  final double dst_lat;
  final double dst_lng;
  BuildingMapTemplate({required this.dst_lat, required this.dst_lng});

  @override
  State<BuildingMapTemplate> createState() => _BuildingMapTemplateState();
}

class _BuildingMapTemplateState extends State<BuildingMapTemplate> {
  final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  String? src_lat;
  String? src_lng;

  getGeoData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('permissions are denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      src_lat = position.latitude.toString();
      src_lng = position.longitude.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getGeoData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          WebViewWidget(
            controller: _controller
              ..loadRequest(Uri.parse('https://shinyoung-hwan.github.io/SKKU-Buildings/webview.html?src_lat=${src_lat}&src_lng=${src_lng}&dst_lat=${widget.dst_lat}&dst_lng=${widget.dst_lng}')), // 로드할 URL
          ),
          Positioned(
            right: 15,
            bottom: 15,
            child: MyLocationIcon(ontap: () => { setState(() => getGeoData() ) }),
          ),
        ],
      )
    );
  }
}
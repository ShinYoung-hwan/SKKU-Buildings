import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:skku_buildings_mobile/dataframes/building_info.dart';

class BuildingMapTemplate extends StatelessWidget {

  final Building_Info building_info;

  BuildingMapTemplate({required this.building_info});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted) // JavaScript 활성화
          ..loadRequest(Uri.parse('https://shinyoung-hwan.github.io/SKKU-Buildings/webview.html?lat=${building_info.building_latitude}&lng=${building_info.building_longitude}')), // 로드할 URL
      ),
    );
  }
}
import 'dart:convert';

import 'package:instance_monitor/utilities/http_client.dart';
import 'package:instance_monitor/utilities/server_setting.dart';

class ServiceTemplatesRequestDto {
  Future request() async {
    String target = '$backendServerUri/';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri, headers: {
      "Access-Control-Allow-Origin": "*",
    });
    List json = jsonDecode(utf8.decode(response.bodyBytes));
    return json;
  }
}

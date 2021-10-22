import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instance_monitor/utilities/http_client.dart';
import 'package:instance_monitor/utilities/server_setting.dart';

class InstancesRequestDto {
  String serviceTemplateName;

  InstancesRequestDto({
    @required this.serviceTemplateName,
  });

  Future request() async {
    String target = '$backendServerUri/$serviceTemplateName/instances';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri, headers: {
      "Access-Control-Allow-Origin": "*",
    });
    List json = jsonDecode(utf8.decode(response.bodyBytes));
    return json;
  }
}

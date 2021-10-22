import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instance_monitor/utilities/http_client.dart';
import 'package:instance_monitor/utilities/server_setting.dart';

class ContainersRequestDto {
  String serviceTemplateName;
  String instanceId;

  ContainersRequestDto({
    @required this.serviceTemplateName,
    @required this.instanceId,
  });

  Future<List<String>> request() async {
    String target = '$backendServerUri/$serviceTemplateName/instances/$instanceId';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri, headers: {
      "Access-Control-Allow-Origin": "*",
    });
    List<String> json = (jsonDecode(utf8.decode(response.bodyBytes)) as List).cast<String>();
    return json;
  }
}

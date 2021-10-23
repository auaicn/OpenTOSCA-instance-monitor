import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instance_monitor/utilities/http_client.dart';
import 'package:instance_monitor/utilities/server_setting.dart';

class TopologyRequestDto {
  String serviceTemplateName;

  TopologyRequestDto({@required this.serviceTemplateName});

  Future<Map<String, List>> request() async {
    String target = '$backendServerUri/$serviceTemplateName/topology';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri);
    Map json = jsonDecode(utf8.decode(response.bodyBytes));

    Map<String, List> topology = {};
    if (json['nodes'] != null) {
      List nodes = json['nodes'];
      topology['nodes'] = nodes;
    }
    if (json['edges'] != null) {
      List edges = json['edges'];
      topology['edges'] = edges;
    }
    return topology;
  }
}

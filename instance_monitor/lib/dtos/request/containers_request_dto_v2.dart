import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instance_monitor/utilities/http_client.dart';
import 'package:instance_monitor/utilities/server_setting.dart';

class ContainersRequestDtoV2 {
  String serviceTemplateName;
  String instanceId;

  ContainersRequestDtoV2({
    @required this.serviceTemplateName,
    @required this.instanceId,
  });

  Future<List<NodeInformation>> request() async {
    String target = '$backendServerUri/$serviceTemplateName/instances/$instanceId';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri, headers: {
      "Access-Control-Allow-Origin": "*",
    });
    List json = jsonDecode(utf8.decode(response.bodyBytes));

    List<NodeInformation> nodeInformations = [];
    json.forEach((nodeInformation) {
      nodeInformations.add(NodeInformation.fromJson(nodeInformation));
    });
    return nodeInformations;
  }
}

class NodeInformation {
  String topologyLabel;
  String containerId;

  NodeInformation.fromJson(Map<String, dynamic> json) {
    topologyLabel = json['topologyLabel'];
    containerId = json['containerId'];
  }
}

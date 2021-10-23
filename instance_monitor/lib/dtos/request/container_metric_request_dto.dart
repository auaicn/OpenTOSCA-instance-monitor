import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instance_monitor/models/container_status.dart';
import 'package:instance_monitor/utilities/http_client.dart';
import 'package:instance_monitor/utilities/server_setting.dart';

class ContainerMetricRequestDto {
  String containerId;

  ContainerMetricRequestDto({@required this.containerId});

  Future<ContainerStatus> request() async {
    String target = '$dockerEngineUri/containers/$containerId/stats?stream=false';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri);
    Map json = jsonDecode(utf8.decode(response.bodyBytes));

    return ContainerStatus.fromJson(json);
  }
}

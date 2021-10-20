import 'package:flutter/material.dart';
import 'package:instance_monitor/dtos/request/containers_request_dto.dart';

class Service {
  String serviceTemplate;
  String instanceId;
  List<String> containerIds;

  Service({@required this.serviceTemplate, @required this.instanceId});

  Future loadContainerIds() async {
    ContainersRequestDto containersRequestDto = ContainersRequestDto(
      serviceTemplateName: this.serviceTemplate,
      instanceId: this.instanceId,
    );

    await containersRequestDto.request().then((containerIds) {
      this.containerIds = containerIds;
    });
  }
}

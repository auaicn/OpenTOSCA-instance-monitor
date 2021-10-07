import 'package:flutter/material.dart';

class ServiceProvider extends ChangeNotifier {
  String selectedServiceTemplate;
  int selectedInstanceId;

  ServiceProvider() {
    // get python parsing result
  }

  void updateServiceTemplate({@required String selectedServiceTemplate}) {
    this.selectedServiceTemplate = selectedServiceTemplate;

    notifyListeners();
  }

  void updateInstanceId({@required int selectedInstanceId}) {
    this.selectedInstanceId = selectedInstanceId;

    notifyListeners();
  }
}

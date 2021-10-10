import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/logger.dart';
import 'package:instance_monitor/utilities/http_client.dart';

class InformationPanel extends StatefulWidget {
  @override
  State<InformationPanel> createState() => _InformationPanelState();
}

class _InformationPanelState extends State<InformationPanel> {
  Future<Response> containers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      color: Colors.black12,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Detailed Informations')),
          SizedBox(height: defaultSpacing),
          TextButton(
            onPressed: fetchAvailableContainers,
            child: Text('request'),
          ),
          SizedBox(height: defaultSpacing),
          Expanded(
            child: Container(
              child: Center(
                child: FutureBuilder<Response>(
                  future: containers,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    logger.i('building result');
                    if (!snapshot.hasData) {
                      logger.i('no data');

                      return CupertinoActivityIndicator();
                    } else if (snapshot.hasData) {
                      Response value = snapshot.data;
                      var decodedResponseBody = jsonDecode(utf8.decode(value.bodyBytes));
                      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
                      var containers = encoder.convert(decodedResponseBody);
                      return Text(
                        '$containers',
                        style: Theme.of(context).textTheme.bodyText1.apply(color: Colors.brown),
                      );
                    } else {
                      logger.e('while fetching containers');
                      return Container(color: Colors.red);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fetchAvailableContainers() {
    logger.d('$baseUrl/containers/json');

    Uri uri = Uri.parse('$baseUrl/containers/json');

    setState(() {
      containers = loggerHttpClient.get(
        uri,
        headers: {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'},
      );
    });
  }
}

String baseUrl = 'http://ec2-3-35-68-199.ap-northeast-2.compute.amazonaws.com:2220/';

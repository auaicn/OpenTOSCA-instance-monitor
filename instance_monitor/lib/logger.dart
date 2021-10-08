import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    printEmojis: true,
    printTime: false,
    lineLength: 120,
    methodCount: 0,
  ),
);

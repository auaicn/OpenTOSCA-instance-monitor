import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

final client = http.Client();

LoggerHttpClient loggerHttpClient = LoggerHttpClient(client);

class LoggerHttpClient extends BaseClient {
  final Client _client;
  final JsonEncoder _encoder = new JsonEncoder.withIndent('  ');
  final JsonDecoder _decoder = new JsonDecoder();
  final logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    output: null, // Use the default LogOutput (-> send everything to console)
    printer: PrettyPrinter(
        methodCount: 0, // number of method calls to be displayed
        errorMethodCount: 10, // number of method calls if stacktrace is provided
        lineLength: 160,
        colors: false, // Colorful log messages, false works on only intellij IDE
        printEmojis: false, // Print an emoji for each log message
        printTime: true // Should each log print contain a timestamp
        ),
  );

  LoggerHttpClient(this._client);

  @override
  void close() {
    _client.close();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _client.send(request).then((response) async {
      final responseString = await response.stream.bytesToString();

      String prettyPrint;
      try {
        prettyPrint = _encoder.convert(_decoder.convert(responseString));
      } catch (e) {
        prettyPrint = '';
      }

      final _res = '''
statusCode: ${response.statusCode},
headers: ${response.headers},
reasonPhrase: ${response.reasonPhrase},
request: ${response.request.toString()},

responseString: $prettyPrint,
      ''';
      logger.d(_res.toString());

      return StreamedResponse(ByteStream.fromBytes(utf8.encode(responseString)), response.statusCode,
          headers: response.headers,
          reasonPhrase: response.reasonPhrase,
          persistentConnection: response.persistentConnection,
          contentLength: response.contentLength,
          isRedirect: response.isRedirect,
          request: response.request);
    });
  }
}

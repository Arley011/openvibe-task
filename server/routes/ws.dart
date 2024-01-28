import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:server/model/message.dart';
import 'package:test/expect.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      channel.stream.listen(
        (mess) {
          final request = jsonDecode(mess as String) as List<dynamic>;
          final method = request[0] as String;
          final id = request[1] as String;
          final amount = request[2] as int;

          if (method == 'get') {
            final messages = createRandomMessages(amount);

            for (final message in messages) {
              channel.sink.add(jsonEncode([id, message.toJson()]));
            }
            return;
          }
          channel.sink.add('["error", "unknown method: $method"]');
        },
        onDone: () => {
          prints('done'),
        },
      );
    },
  );

  return handler(context);
}

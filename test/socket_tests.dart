import 'package:flutter_test/flutter_test.dart';
import 'package:testing_sockets/GuestPrototype.dart';
import 'package:testing_sockets/SocketPrototype.dart';

void main() async {
  test("first test", () async {
    SocketPrototype host = new SocketPrototype();
    await host.setupHostServer();
    GuestPrototype guest = new GuestPrototype("127.0.0.1", 'test');
    await guest.connectToHost();
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_sockets/GuestPrototype.dart';
import 'package:testing_sockets/SocketPrototype.dart';

void main() async {
  test("Guest name is saved in a test variable by host", () async {
    SocketPrototype host = new SocketPrototype();
    await host.setupHostServer();
    GuestPrototype guest = new GuestPrototype("127.0.0.1", 'test');
    await guest.connectToHost();
    expect(host.testVariable == guest.name, true);
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_sockets/GuestPrototype.dart';
import 'package:testing_sockets/SocketPrototype.dart';

void main() async {
  test("Guest name is saved in a test variable by host", () async {
    SocketPrototype host = SocketPrototype();
    GuestPrototype guest = GuestPrototype('guest1', '127.0.0.1');
    GuestPrototype guest2 = GuestPrototype('guest2', '127.0.0.1');
    await host.setupServer();
    await guest.connectToHost();
    await guest2.connectToHost();
    await Future.delayed(Duration(milliseconds: 5));
    print(guest.guestList.toString());
  });
}
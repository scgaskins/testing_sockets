import 'dart:io';
import 'dart:convert';

import 'dart:typed_data';

const int port = 4444;

// A prototype of the host

class SocketPrototype {
  String testVariable;
  GamePhase phase;
  Map<String, Socket> guestSockets;

  SocketPrototype() {
    phase = GamePhase.SettingUp;
    guestSockets = new Map();
    //setupServer();
  }

  Future<void> setupServer() async {
    try {
      ServerSocket server = await ServerSocket.bind(InternetAddress.anyIPv4, port);
      server.listen(_listenToSocket);

    } on SocketException catch (e) {
      print(e.message);
    }
  }

  void _listenToSocket(Socket socket) {
    socket.listen((data) {
      if (phase == GamePhase.SettingUp) {
        _addNewGuest(socket, data);
      }
    });
  }

  void _handleIncomingData(String ip, Uint8List data) {

  }

  void _addNewGuest(Socket socket, Uint8List data) {
    String guestName = String.fromCharCodes(data);
    guestSockets[guestName] = socket;
    _sendGuestListToAllGuests();
    //socket.write('Hello there $guestName');
  }

  Future<void> _sendGuestListToAllGuests() async {
    for (String name in guestSockets.keys) {
      print(guestSockets.keys.toList());
      guestSockets[name].write(JsonCodec().encode(guestSockets.keys.toList()));
    }
  }
}

enum GamePhase {
  SettingUp,
  Started,
  Ended,
  ScoresTotaled
}
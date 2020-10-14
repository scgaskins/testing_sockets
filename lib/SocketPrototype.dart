import 'dart:io';

import 'dart:typed_data';

const int port = 4444;

class SocketPrototype {
  Map<String, String> guestNamesToIps = new Map();
  String testVariable;

  Future<void> setupHostServer() async {
    try {
      ServerSocket serverSocket = await ServerSocket.bind(InternetAddress.anyIPv4, port);
      serverSocket.listen(_listenToSocket);
    } on SocketException catch(e) {
      print(e.message);
    }
  }

  void _listenToSocket(Socket socket) {
    socket.listen((event) {
      _checkIncomingData(socket.remoteAddress.address, event);
    });
  }

  void _checkIncomingData(String ip, Uint8List data) {
    print('received data');
    String incomingData = String.fromCharCodes(data);
    print(incomingData);
    print(ip);
    _sendDataBackToGuest(ip, incomingData);
  }

  Future<void> _sendDataBackToGuest(String guestIp, String data) async {
    try {
      Socket socket = await Socket.connect(guestIp, port);
      socket.write(data);
      socket.close();
    } on SocketException catch (e) {
      print(e.message);
    }
  }

  void _sendGuestListToAllGuests() async {
    for (String ip in guestNamesToIps.keys) {
      try {
        Socket socket = await Socket.connect(ip, port);
        for (String ip2 in guestNamesToIps.keys) {
          if (ip != ip2) {
            socket.writeln(guestNamesToIps[ip]);
          }
        }
        socket.close();
      } on SocketException catch(e) {
        print(e.message);
      }
    }
  }
}
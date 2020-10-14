import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/animation.dart';

const int port = 4444;

class GuestPrototype{
  String _hostIP;
  String name;
  bool _gameStarted;

  GuestPrototype(this._hostIP, this.name) {
    _gameStarted = false;

  }


  Future<void> connectToHost() async {
    try {
      print('Connecting...');
      Socket socket = await Socket.connect(_hostIP, port);
      print("Connected.");
      socket.write(name);
      socket.listen(_listenToHost,
      onDone: () {socket.close();});
    } on SocketException catch(e) {
      print(e.message);
    }
  }

  void _listenToHost(Uint8List data) {
    print(new String.fromCharCodes(data));
  }
}
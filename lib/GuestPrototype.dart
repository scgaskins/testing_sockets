import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

// A prototype of the guest users

const int port = 4444;

class GuestPrototype{
  String _hostIP;
  String name;
  List guestList;

  GuestPrototype(this.name, this._hostIP);

  Future<void> connectToHost() async {
    try {
      print('Connecting...');
      Socket socket = await Socket.connect(_hostIP, port);
      print('connected');
      socket.write(name);
      print('Awaiting response');
      socket.listen(_handleData,
          onDone: () {socket.close();});
    } on SocketException catch (e) {
      print(e.message);
    }
  }

  void _handleData(Uint8List data) {
    print('received response');
    guestList = JsonCodec().decode(String.fromCharCodes(data));
    print(guestList.runtimeType);
  }
}
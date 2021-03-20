import 'package:flutter/material.dart';

class ConnectedScreen extends StatefulWidget {
  final Function _sendMessageCallback;
  ConnectedScreen(this._sendMessageCallback, {Key key}) : super(key: key);

  @override
  _ConnectedScreenState createState() =>
      _ConnectedScreenState(_sendMessageCallback);
}

class _ConnectedScreenState extends State<ConnectedScreen> {
  Offset _position = Offset(0, 0);
  final Function _sendMessageCallback;

  _ConnectedScreenState(this._sendMessageCallback);

  void _onPointerMove(PointerMoveEvent event) {
    _position = event.localDelta;
    print("Moved to ${_position.toString()}");
    _sendMessageCallback.call("0|${_position.dx}, ${_position.dy}");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Listener(
            onPointerMove: _onPointerMove,
            child: Container(color: Colors.red)));
  }
}

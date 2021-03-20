import 'package:flutter/material.dart';

class NotConnectedScreen extends StatefulWidget {
  final Function _connectCallback;

  NotConnectedScreen(this._connectCallback, {Key key}) : super(key: key);

  @override
  _NotConnectedScreenState createState() =>
      _NotConnectedScreenState(this._connectCallback);
}

class _NotConnectedScreenState extends State<NotConnectedScreen> {
  final Function _connectCallback;

  _NotConnectedScreenState(this._connectCallback);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.red,
          child: TextButton(
              child: Text("Try Connect"), onPressed: _connectCallback)),
    );
  }
}

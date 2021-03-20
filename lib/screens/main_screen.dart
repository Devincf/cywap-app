import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cywap_app/screens/connected_screen.dart';
import 'package:cywap_app/screens/not_connected_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isConnected = false;
  //Timer _timer;
  final DESTINATION_ADDRESS = InternetAddress("10.0.2.2");
  final PORT = 44906;

  RawDatagramSocket _udpSocket;

  void _sendMessage(String message) {
    print("Sending message:  $message");
    List<int> data = utf8.encode(message);
    _udpSocket.send(data, DESTINATION_ADDRESS, PORT);
  }

  void _closeConnection() {
    _udpSocket.close();
  }

  void _tryConnect() async {
    try {
      _udpSocket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, PORT);
      _udpSocket.broadcastEnabled = true;
      _udpSocket.listen((e) {
        Datagram dg = _udpSocket.receive();
        if (dg != null) {
          print("received ${dg.data}");
        }
      });
      setState(() => _isConnected = true);
      print("success");
      //_sendMessage("Test");
    } catch (e) {
      print("failed");
      print("Exception $e");
      _isConnected = false;
    }
  }

  _MainScreenState() {
    //_timer = Timer.periodic(Duration(seconds: 7), (Timer t) => _tryConnect(t));
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainContainer();
  }

  Widget _buildMainContainer() {
    return _isConnected
        ? ConnectedScreen(_sendMessage)
        : NotConnectedScreen(_tryConnect);
  }
}

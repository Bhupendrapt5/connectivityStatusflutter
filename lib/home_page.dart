import 'package:flutter/material.dart';
import 'package:wifi_bluetooth_status/bluetooth_status_widget.dart';
import 'package:wifi_bluetooth_status/wifi_status_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: WifiStatusWidget(),
            ),
          ),
          Expanded(
            child: Center(
              child: BluetoothStatusWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

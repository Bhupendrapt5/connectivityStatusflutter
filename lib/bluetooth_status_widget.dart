import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothStatusWidget extends StatelessWidget {
  BluetoothStatusWidget({Key key}) : super(key: key);
  static const platform = const MethodChannel('in.platform/system');
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext ctxt, AsyncSnapshot<BluetoothState> snapShot) {
        if (!snapShot.hasData) return CircularProgressIndicator();
        var result = snapShot.data == BluetoothState.on;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              result ? Icons.bluetooth : Icons.bluetooth_disabled_rounded,
              color: result ? Colors.blue : Colors.grey,
              size: 60,
            ),
            Switch(
              value: result,
              onChanged: (value) async {
                try {
                  await platform.invokeMethod('changeBluetooth');
                } on PlatformException catch (e) {
                  throw e;
                }
              },
            )
          ],
        );
      },
      stream: flutterBlue.state,
    );
  }
}

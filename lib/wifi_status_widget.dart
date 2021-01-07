import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WifiStatusWidget extends StatelessWidget {
  const WifiStatusWidget({Key key}) : super(key: key);
  static const platform = const MethodChannel('in.platform/system');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext ctxt, AsyncSnapshot<ConnectivityResult> snapShot) {
        if (!snapShot.hasData) return CircularProgressIndicator();
        var result = snapShot.data == ConnectivityResult.wifi;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              result ? Icons.wifi : Icons.wifi_off,
              color: result ? Colors.blue : Colors.grey,
              size: 60,
            ),
            Switch(
              value: result,
              onChanged: (value) async {
                try {
                  var getrs =
                      await platform.invokeMethod('changeWifi', !result);
                  print('result : $getrs');
                } on PlatformException catch (e) {
                  throw e;
                }
              },
            )
          ],
        );
      },
      stream: Connectivity().onConnectivityChanged,
    );
  }
}

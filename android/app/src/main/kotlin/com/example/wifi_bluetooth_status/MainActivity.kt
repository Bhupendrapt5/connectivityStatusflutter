package com.example.wifi_bluetooth_status

import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.content.Intent
import android.net.wifi.WifiManager
import android.provider.Settings
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.IOException


class MainActivity: FlutterActivity() {
    private val CHANNEL = "in.platform/system"
    private var wifiStatus: Boolean = false
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            Log.i("info", "method call")
            if (call.method =="changeWifi") {

                    wifiStatus = call.arguments as Boolean
                Log.i("info", "change wifi")
                    changeWIFIStatus(wifiStatus, this.context)
                }
              else if  (call.method =="changeBluetooth") {
                    changeBluetoothStatus()
                }
                else {
                    result.run(MethodChannel.Result::notImplemented)
                }
            }

    }

    private fun changeWIFIStatus(newWifiStatus: Boolean, ctx: Context){

        try {
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q){
                val panelIntent = Intent(Settings.Panel.ACTION_INTERNET_CONNECTIVITY)
                startActivityForResult(panelIntent, 545)
            } else{
                // do something for phones running an SDK before Q

                val wifi = applicationContext.getSystemService(WIFI_SERVICE) as WifiManager
                wifi.setWifiEnabled(newWifiStatus)
                Log.i("info", "wifi status ${wifi.isWifiEnabled}")
            }
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }

    private fun changeBluetoothStatus(){
       val mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        if (mBluetoothAdapter.isEnabled) {
            mBluetoothAdapter.disable()

        } else {
            mBluetoothAdapter.enable()
        }
    }
}

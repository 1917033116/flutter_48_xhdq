package com.xhdq.flutter48xhdq

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import com.webviewlib.EasonWebActivity
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.DataCleanManager
import io.flutter.plugins.GeneratedPluginRegistrant
import java.net.NetworkInterface
import java.util.*

class MainActivity : FlutterActivity() {
    val CHANNEL = "com.xhdq.flutter48xhdq/android_system_plugin"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
//        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { methodCall, result ->
//            if (methodCall.method == "isVpnUsed") {
//                isVpnUsed(methodCall, result)
//            } else if (methodCall.method == "getAppPakageName") {
//                getAppPakageName(result)
//            } else if (methodCall.method == "getCacheSize") {
//                result.success(DataCleanManager.getTotalCacheSize(this))
//            } else if (methodCall.method == "clearCache") {
//                DataCleanManager.clearAllCache(this)
//                result.success(true)
//            } else if (methodCall.method == "lunchWebView") {
//                lunchWebView(methodCall.arguments as String)
//            } else if (methodCall.method == "isHaveNetWork") {
//
//            } else {
//                result.notImplemented()
//            }
//        }
    }

    private fun lunchWebView(url: String) {
        val intent = Intent(this, EasonWebActivity::class.java)
        intent.putExtra("extra_url", url)
        startActivity(intent)
    }

    private fun getAppPakageName(result: MethodChannel.Result) {
        //当前应用pid
        val pid = android.os.Process.myPid()
        //任务管理类
        val manager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        //遍历所有应用
        val infos = manager.runningAppProcesses
        for (info in infos) {
            if (info.pid == pid)
            //得到当前应用
                result.success(info.processName) //返回包名
        }
    }

    private fun isVpnUsed(methodCall: MethodCall?, result: MethodChannel.Result?) {
        var isUsedVpn = false
        try {
            val niList = NetworkInterface.getNetworkInterfaces()
            if (niList != null) {
                for (intf in Collections.list(niList)) {
                    if (!intf.isUp || intf.interfaceAddresses.size == 0) {
                        continue
                    }
                    if ("tun0" == intf.name || "ppp0" == intf.name) {
                        Log.v("│ -->", "│ --> isVpnUsed() NetworkInterface Name: " + intf.name)
                        isUsedVpn = true // The VPN is up
                    }
                }
            }
            result!!.success(isUsedVpn)
        } catch (e: Throwable) {
            result!!.error("检查vpn发生异常", "${e.message}", isUsedVpn)
            e.printStackTrace()
        }
    }
}

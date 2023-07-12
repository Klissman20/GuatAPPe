package com.tailorsdev.guatappe

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import com.xraph.plugin.flutter_unity_widget.UnityPlayerUtils
import com.unity3d.player.UnityPlayer

class MainActivity: FlutterActivity() {
    
   
    
    @JvmField
     var mUnityPlayer: java.lang.Object? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "unity.hack").setMethodCallHandler {
                call, result ->
            if (call.method == "init") {

                mUnityPlayer = UnityPlayerUtils.unityPlayer as java.lang.Object?
                result.success(0);
            }
        }
    }
}

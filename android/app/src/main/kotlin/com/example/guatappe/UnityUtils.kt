package com.tailorsdev.guatappe

import com.unity3d.player.UnityPlayer
import com.xraph.plugin.flutter_unity_widget.UnityPlayerUtils;

class UnityUtils {
    companion object {
        @JvmStatic
        fun getUnityPlayer(): UnityPlayer {
            return UnityPlayerUtils.unityPlayer as UnityPlayer
        }
    }
}
package com.example.adkar

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.adkar/custom_notification"
    private val REQUEST_CODE_OVERLAY_PERMISSION = 1

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "showCustomNotification" -> {
                    val message = call.argument<String>("message") ?: ""
                    showCustomNotification(message)
                    result.success(null)
                }
                "startCustomNotificationService" -> {
                    val repeatInterval = when (val interval = call.argument<Number>("repeatInterval")) {
                        is Int -> interval.toLong()
                        is Long -> interval
                        else -> 1800000L // Default to 30 minutes if not provided or invalid
                    }
                    startCustomNotificationService(repeatInterval)
                    result.success(null)
                }
                "stopCustomNotificationService" -> {
                    stopCustomNotificationService()
                    result.success(null)
                }
                "isCustomNotificationServiceRunning" -> {
                    result.success(isServiceRunning(CustomNotificationService::class.java))
                }
                "updateNotificationSettings" -> {
                    try {
                        val intent = Intent(this, CustomNotificationService::class.java)
                        intent.action = "UPDATE_NOTIFICATION_SETTINGS"
                        startService(intent)
                        result.success(null)
                    } catch (e: Exception) {
                        Log.e("MainActivity", "Error updating notification settings", e)
                        result.error("UPDATE_ERROR", "Failed to update notification settings", e.message)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
    private fun showCustomNotification(message: String) {
        val intent = Intent(this, CustomNotificationService::class.java)
        intent.action = "SHOW_CUSTOM_NOTIFICATION"
        intent.putExtra("message", message)
        startService(intent)
    }

    private fun startCustomNotificationService(repeatInterval: Long) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && !Settings.canDrawOverlays(this)) {
            val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:$packageName"))
            startActivityForResult(intent, REQUEST_CODE_OVERLAY_PERMISSION)
        } else {
            val serviceIntent = Intent(this, CustomNotificationService::class.java)
            serviceIntent.putExtra("repeatInterval", repeatInterval)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                startForegroundService(serviceIntent)
            } else {
                startService(serviceIntent)
            }
        }
    }

    private fun stopCustomNotificationService() {
        val serviceIntent = Intent(this, CustomNotificationService::class.java)
        stopService(serviceIntent)
    }

    private fun isServiceRunning(serviceClass: Class<*>): Boolean {
        val manager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        for (service in manager.getRunningServices(Integer.MAX_VALUE)) {
            if (serviceClass.name == service.service.className) {
                return true
            }
        }
        return false
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE_OVERLAY_PERMISSION) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && Settings.canDrawOverlays(this)) {
                startCustomNotificationService(1800000L) // Default to 30 minutes if permission just granted
            }
        }
    }
}
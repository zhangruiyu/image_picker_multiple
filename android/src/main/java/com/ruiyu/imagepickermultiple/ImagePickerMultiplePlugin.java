package com.ruiyu.imagepickermultiple;

import android.app.Activity;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * ImagePickerMultiplePlugin
 */
public class ImagePickerMultiplePlugin implements MethodCallHandler {
  private Activity activity;

  private ImagePickerMultiplePlugin(Activity activity) {
    this.activity = activity;
  }

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "multiple_image_picker");
    channel.setMethodCallHandler(new ImagePickerMultiplePlugin(registrar.activity()));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("pickImage")) {
      TransparentActivity.start(activity, call, result);
    } else {
      result.notImplemented();
    }
  }
}

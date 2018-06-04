package com.ruiyu.imagepickermultiple;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;

import java.util.ArrayList;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import me.iwf.photopicker.PhotoPicker;


public class TransparentActivity extends Activity {
    static MethodCall call;
    static MethodChannel.Result result;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        PhotoPicker.builder()
                .setPhotoCount(9)
                .setShowCamera(true)
                .setShowGif(true)
                .setPreviewEnabled(false)
                .setSelected((ArrayList<String>) TransparentActivity.call.argument("selectedPics"))
                .start(this, PhotoPicker.REQUEST_CODE);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        ArrayList<String> photos = new ArrayList<>();
        if (resultCode == RESULT_OK && requestCode == PhotoPicker.REQUEST_CODE) {
            if (data != null) {
                photos.addAll(data.getStringArrayListExtra(PhotoPicker.KEY_SELECTED_PHOTOS));
            }
            Log.e("onActivityResult", "onActivityResult");
        }
        result.success(photos);
        onBackPressed();
    }

    @Override
    protected void onDestroy() {
        TransparentActivity.call = null;
        TransparentActivity.result = null;
        super.onDestroy();
    }

    public static void start(Activity activity, MethodCall call, MethodChannel.Result result) {
        TransparentActivity.call = call;
        TransparentActivity.result = result;
        Intent intent = new Intent(activity, TransparentActivity.class);
        activity.startActivity(intent);
    }
}

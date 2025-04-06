package com.reactlibrary;

import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

public class Video360Module extends SimpleViewManager<VideoPlayerView> {
    private static final String CLASS_NAME = "Video360";

    private VideoPlayerView view;

    public Video360Module(ReactApplicationContext context) {
        super();
    }

    @Override
    public String getName() {
        return CLASS_NAME;
    }

    @Override
    protected VideoPlayerView createViewInstance(ThemedReactContext context) {
        view = new VideoPlayerView(context.getBaseContext());

        LifecycleEventListener lifecycleEventListener = new LifecycleEventListener() {
            @Override
            public void onHostResume() {
                if (view != null) {
                    view.onResume();
                }
            }

            @Override
            public void onHostPause() {
                if (view != null) {
                    view.onPause();
                }
            }

            @Override
            public void onHostDestroy() {
                if (view != null) {
                    view.onDestroy();
                }

            }
        };

        context.addLifecycleEventListener(lifecycleEventListener);

        return view;
    }

    @Override
    public void onDropViewInstance(VideoPlayerView view) {
        view.onDestroy();
        super.onDropViewInstance(view);
    }

    @ReactProp(name = "urlVideo")
    public void setVideo(VideoPlayerView view, String url) {
        view.setVideo(url);
    }
}
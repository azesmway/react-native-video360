package com.reactlibrary;

import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.net.Uri;
import androidx.annotation.Nullable;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.RelativeLayout;

import static com.reactlibrary.MediaLoader.RAW_RESOURCE_ID;

public class VideoPlayerView extends RelativeLayout {
    private MonoscopicView mVideoView;
    private VideoUiView mVideoUi;
    private Context mContext;

    public VideoPlayerView(Context context) {
        super(context);
        init(context);
    }

    public VideoPlayerView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    public VideoPlayerView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context);
    }

    private void init(Context context) {
        mContext = context;
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        inflater.inflate(R.layout.view_video_player, this, true);

        mVideoView = findViewById(R.id.video_view);
        mVideoUi = findViewById(R.id.video_ui_view);
        mVideoView.initialize(mVideoUi);
    }

    public void setVideo(String url) {
        Intent intent = new Intent();

        if (!url.startsWith("file") && !url.startsWith("http")) {
            Resources resources = mContext.getResources();
            int resourceId = resources.getIdentifier(url, "raw", mContext.getPackageName());
            intent.putExtra(RAW_RESOURCE_ID, resourceId);
        } else {
            Uri uri = Uri.parse(url);
            intent.setData(uri);
        }

        mVideoView.loadMedia(intent);
    }

    public void onResume() {
        mVideoView.onResume();
    }

    public void onPause() {
        mVideoView.onPause();
    }

    public void onDestroy() {
        mVideoView.destroy();
    }
}

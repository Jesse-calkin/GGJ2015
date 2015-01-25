package com.mygdx.game;

import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.utils.Timer;

public class CountdownClock {

    public interface CountdownClockListener {
        public void onCountdownFinished();
    }

    private Timer mTimer;
    private Color mFontColor;
    private int mSeconds;
    private float mX;
    private float mY;
    private float mDelay;
    private CountdownClockListener mListener;
    private MyGdxGame mGameInstance;

    public CountdownClock(final MyGdxGame gameInstance) {
        mTimer = new Timer();
        mSeconds = 0;
        mGameInstance = gameInstance;
        mDelay = 0;
    }

    public void setFontColor(Color fontColor) {
        mFontColor = fontColor;
    }

    public void setDelay(float seconds) {
        mDelay = seconds;
    }

    public void setDuration(int seconds) {
        mSeconds = seconds;
    }

    public void render() {
        mGameInstance.font.setColor(mFontColor);
        mGameInstance.batch.begin();
        mGameInstance.font.draw(mGameInstance.batch, Integer.toString(mSeconds), mX, mY);
        mGameInstance.batch.end();
    }

    public void start() {
        mTimer.scheduleTask(new Timer.Task() {
            @Override
            public void run() {
                mSeconds -= 1;
                if (mSeconds == 0) {
                    mSeconds = 0;
                    if (mListener != null) {
                        mListener.onCountdownFinished();
                        //mSeconds = mFullDuration;
                    }
                }
            }
        }, mDelay, 1, mSeconds);
    }

    public void stop() {
        mTimer.stop();
    }

    public void setCountdownListener(CountdownClockListener listener) {
        mListener = listener;
    }

    public void setX(float x) {
        mX = x;
    }

    public void setY(float y) {
        mY = y;
    }

}

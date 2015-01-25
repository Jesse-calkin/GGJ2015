package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;

public class EndScreen extends ScreenAdapter implements CountdownClock.CountdownClockListener{

    MyGdxGame mGameInstance;
    CountdownClock countdownClock;
    String mText;
    float mX;
    float mY;

    public EndScreen(final MyGdxGame game, String text, float x, float y) {
        mGameInstance = game;
        countdownClock = new CountdownClock(game);
        mText = text;
        mX = x;
        mY = y;
        countdownClock.setDelay(1);
        countdownClock.setDuration(5);
        countdownClock.setCountdownListener(this);
        countdownClock.start();
    }

    @Override
    public void render(float delta) {
        Gdx.gl.glClearColor(255,255,255,2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.font.setColor(Color.BLACK);
        mGameInstance.batch.begin();
        mGameInstance.font.draw(mGameInstance.batch, mText, mX, mY);
        mGameInstance.batch.end();
    }

    @Override
    public void onCountdownFinished() {
        mGameInstance.setScreen(new MainGameScreen(mGameInstance));
    }
}

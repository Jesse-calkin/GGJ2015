package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.math.Vector3;

public class CreditsScreen extends ScreenAdapter {
    MyGdxGame mGameInstance;

    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;


    public CreditsScreen(final MyGdxGame game) {
        mGameInstance = game;

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mGuiCam.update();
    }

    private void update() {
        if (Gdx.input.isTouched()) {
            mGameInstance.setScreen(new IntroScreen(mGameInstance));
        }
    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

        mGameInstance.batch.begin();
        mGameInstance.font.drawMultiLine(mGameInstance.batch,
                "Brandon Davis\nEric Young\nChris Weathers\nCarl Veazey\nNick Dobos\nJesse Calkin",
                0,
                mGameInstance.screenHeight);
        mGameInstance.batch.end();
    }

    @Override
    public void render(float delta) {
        update();
        draw();
    }
}

package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.InputAdapter;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector3;

public class IntroScreen extends ScreenAdapter {
    MyGdxGame mGameInstance;
    Rectangle mStartGameRect;
    Rectangle mCreditsRect;
    Texture mStartGameTexture;
    Texture mCreditsTexture;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;

    int mStartGameX;
    int mStartGameY;
    int mCreditsX;
    int mCreditsY;
    int mStartRectHeight;
    int mStartRectWidth;
    int mCreditsRectHeight;
    int mCreditsRectWidth;

    public IntroScreen(final MyGdxGame game) {
        mGameInstance = game;

        mStartGameX = mGameInstance.screenWidth / 3;
        mStartGameY = mGameInstance.screenHeight / 2;
        mCreditsX = mStartGameX;
        mCreditsY = mStartGameY - 100;

        mStartGameTexture = new Texture(Gdx.files.internal("startGame.png"));
        mStartRectHeight = mStartGameTexture.getHeight();
        mStartRectWidth = mStartGameTexture.getWidth();
        mStartGameRect = new Rectangle(mStartGameX, mStartGameY, mStartRectWidth, mStartRectHeight);

        mCreditsTexture = new Texture(Gdx.files.internal("credits.png"));
        mCreditsRectHeight = mCreditsTexture.getHeight();
        mCreditsRectWidth = mCreditsTexture.getWidth();
        mCreditsRect = new Rectangle(mCreditsX, mCreditsY, mCreditsRectWidth, mCreditsRectHeight);

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mGuiCam.update();

        Gdx.input.setInputProcessor(new InputAdapter() {
            @Override
            public boolean touchDown(int x, int y, int pointer, int button) {
                mGuiCam.unproject(mTouchPoint.set(x, y, 0));

                if (mStartGameRect.contains(mTouchPoint.x, mTouchPoint.y)) {
                    mGameInstance.setScreen(new MainGameScreen(mGameInstance));
                    return true;
                }

                if (mCreditsRect.contains(mTouchPoint.x, mTouchPoint.y)) {
                    mGameInstance.setScreen(new CreditsScreen(mGameInstance));
                    return true;
                }
                return false;
            }
        });
    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

        mGameInstance.batch.begin();
        mGameInstance.batch.draw(mStartGameTexture,
                mStartGameX,
                mStartGameY);
        mGameInstance.batch.draw(mCreditsTexture,
                mCreditsX,
                mCreditsY);
        mGameInstance.batch.end();
    }

    @Override
    public void render(float delta) {
        draw();
    }
}

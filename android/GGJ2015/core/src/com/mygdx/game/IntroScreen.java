package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.InputAdapter;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector3;

public class IntroScreen extends ScreenAdapter {
    MyGdxGame mGameInstance;
    Rectangle mStartGameRect;
    Rectangle mCreditsRect;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;

    String mStartGameString;
    String mCreditsString;

    float mStartGameX;
    float mStartGameY;
    float mCreditsX;
    float mCreditsY;
    float mStartRectWidth;
    float mStartRectHeight;
    float mCreditsRectWidth;
    float mCreditsRectHeight;

    public IntroScreen(final MyGdxGame game) {
        mGameInstance = game;

        mStartGameString = "START GAME";
        mCreditsString = "CREDITS";

        mStartRectWidth = mGameInstance.font.getBounds(mStartGameString).width;
        mStartRectHeight = mGameInstance.font.getBounds(mStartGameString).height;

        mCreditsRectWidth = mGameInstance.font.getBounds(mCreditsString).width;
        mCreditsRectHeight = mGameInstance.font.getBounds(mCreditsString).height;

        mStartGameX = (mGameInstance.screenWidth / 2) - (mStartRectWidth / 2);
        mStartGameY = (mGameInstance.screenHeight / 2) + (mStartRectHeight / 2);

        mCreditsX = (mGameInstance.screenWidth / 2) - (mCreditsRectWidth / 2);
        mCreditsY = (mGameInstance.screenHeight / 2) + (mCreditsRectHeight / 2) - mStartRectHeight - 10;

        mStartGameRect = new Rectangle(mStartGameX, mStartGameY - mStartRectHeight, mStartRectWidth, mStartRectHeight);
        mCreditsRect = new Rectangle(mCreditsX, mCreditsY - mCreditsRectHeight, mCreditsRectWidth, mCreditsRectHeight);

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
        mGameInstance.font.draw(mGameInstance.batch,
                mStartGameString,
                mStartGameX,
                mStartGameY);
        mGameInstance.font.draw(mGameInstance.batch,
                mCreditsString,
                mCreditsX,
                mCreditsY);
        mGameInstance.batch.end();

        ShapeRenderer renderer = new ShapeRenderer();
        renderer.setAutoShapeType(true);
        renderer.setColor(Color.GREEN);
        renderer.begin();
        renderer.rect(mStartGameX, mStartGameY - mStartRectHeight, mStartRectWidth, mStartRectHeight);
        renderer.rect(mCreditsX, mCreditsY - mCreditsRectHeight, mCreditsRectWidth, mCreditsRectHeight);
        renderer.end();
    }

    @Override
    public void render(float delta) {
        draw();
    }
}

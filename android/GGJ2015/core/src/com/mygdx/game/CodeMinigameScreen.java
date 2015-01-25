package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector3;

public class CodeMinigameScreen extends ScreenAdapter {

    MyGdxGame mGameInstance;
    Rectangle mLeftKeyRectangle;
    Rectangle mRightKeyRectangle;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;
    int mLeftX;
    int mLeftY;
    int mRightX;
    int mRightY;
    int mButtonRectWidth;
    int mButtonRectHeight;

    public CodeMinigameScreen(final MyGdxGame game) {
        mGameInstance = game;

        mLeftX = 0;
        mLeftY = 0;
        mRightX = Gdx.graphics.getWidth() - Gdx.graphics.getWidth() / 3;
        mRightY = 0;
        mButtonRectWidth = Gdx.graphics.getWidth()/3;
        mButtonRectHeight = Gdx.graphics.getHeight();

        mLeftKeyRectangle = new Rectangle(mLeftX, mLeftY, mButtonRectWidth, mButtonRectHeight);
        mRightKeyRectangle = new Rectangle(mRightX, mRightY, mButtonRectWidth, mButtonRectHeight);

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
        mGuiCam.update();
    }

    private void update() {

    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

        ShapeRenderer shapeRenderer = new ShapeRenderer();
        shapeRenderer.setAutoShapeType(true);
        shapeRenderer.begin(ShapeRenderer.ShapeType.Filled);
        shapeRenderer.setColor(Color.BLUE);
        shapeRenderer.rect(mLeftX, mLeftY, mButtonRectWidth, mButtonRectHeight);
        shapeRenderer.setColor(Color.GREEN);
        shapeRenderer.rect(mRightX, mRightY, mButtonRectWidth, mButtonRectHeight);
        shapeRenderer.end();
    }

    @Override
    public void render(float delta) {
        update();
        draw();
    }

    @Override
    public void pause() {

    }
}

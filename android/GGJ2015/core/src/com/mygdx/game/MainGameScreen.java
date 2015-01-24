package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Vector3;

import java.awt.*;

public class MainGameScreen extends ScreenAdapter {

    MyGdxGame mGameInstance;
    Rectangle mClickRectangle;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;
    int mX;
    int mY;

    public MainGameScreen(final MyGdxGame game) {
        mX = 230;
        mY = 230;
        mGameInstance = game;
        mClickRectangle = new Rectangle(mX, mY, 130, 50);
        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, 800, 480);
        mGuiCam.update();
    }

    private void update() {
        if (Gdx.input.isTouched()) {
            mGuiCam.unproject(mTouchPoint.set(Gdx.input.getX(), Gdx.input.getY(), 0));

            if (mClickRectangle.contains(mTouchPoint.x, mTouchPoint.y)) {
                mGameInstance.setScreen(new WhiteboardMinigameScreen(mGameInstance));
            }
        }
    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

        mGameInstance.batch.begin();
        showWhiteboardZone();
        mGameInstance.batch.end();

        ShapeRenderer shapeRenderer = new ShapeRenderer();
        shapeRenderer.setAutoShapeType(true);
        shapeRenderer.begin();
        shapeRenderer.setColor(com.badlogic.gdx.graphics.Color.BLUE);
        shapeRenderer.rect(mX, mY, 130, 50);
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

    private void showWhiteboardZone() {
        mGameInstance.font.draw(mGameInstance.batch, "This is a whiteboard, fear me!", mX, mX);
    }

    private void showCodeZone() {

    }

    private void showCoffeeZone() {

    }
}

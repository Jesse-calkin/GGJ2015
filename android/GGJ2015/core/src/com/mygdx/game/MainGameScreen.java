package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.*;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Vector3;

import java.awt.*;

public class MainGameScreen extends ScreenAdapter {

    MyGdxGame mGameInstance;
    Rectangle mWhiteboardClickRectangle;
    Rectangle mCoffeeClickRectangle;
    Rectangle mCodeClickRectangle;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;
    int mWhiteboardX;
    int mWhiteboardY;
    int mCoffeeX;
    int mCoffeeY;
    int mCodeX;
    int mCodeY;

    public MainGameScreen(final MyGdxGame game) {
        mGameInstance = game;

        mWhiteboardX = 230;
        mWhiteboardY = 130;
        mCoffeeX = 230;
        mCoffeeY = 230;
        mCodeX = 230;
        mCodeY = 330;

        mWhiteboardClickRectangle = new Rectangle(mWhiteboardX, mWhiteboardY, 130, 50);
        mCoffeeClickRectangle = new Rectangle(mCoffeeX, mCoffeeY, 130, 50);
        mCodeClickRectangle = new Rectangle(mCodeX, mCodeY, 130, 50);

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, 800, 480);
        mGuiCam.update();
    }

    private void update() {
        if (Gdx.input.isTouched()) {
            mGuiCam.unproject(mTouchPoint.set(Gdx.input.getX(), Gdx.input.getY(), 0));

            if (mWhiteboardClickRectangle.contains(mTouchPoint.x, mTouchPoint.y)) {
                mGameInstance.setScreen(new WhiteboardMinigameScreen(mGameInstance));
                return;
            }
            if (mCoffeeClickRectangle.contains(mTouchPoint.x, mTouchPoint.y)) {
                mGameInstance.setScreen(new CoffeeMinigameScreen(mGameInstance));
                return;
            }
            if (mCodeClickRectangle.contains(mTouchPoint.x, mTouchPoint.y)) {
                mGameInstance.setScreen(new CodeMinigameScreen(mGameInstance));
                return;
            }
        }
    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

//        mGameInstance.batch.begin();
//        showWhiteboardZone();
//        showCoffeeZone();
//        showCodeZone();
//        mGameInstance.batch.end();

        ShapeRenderer shapeRenderer = new ShapeRenderer();
        shapeRenderer.setAutoShapeType(true);
        shapeRenderer.begin();
        shapeRenderer.setColor(com.badlogic.gdx.graphics.Color.WHITE);
        shapeRenderer.rect(mWhiteboardX, mWhiteboardY, 130, 50);
        shapeRenderer.setColor(Color.BLUE);
        shapeRenderer.rect(mCoffeeX, mCoffeeY, 130, 50);
        shapeRenderer.setColor(Color.GREEN);
        shapeRenderer.rect(mCodeX, mCodeY, 130, 50);
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
        mGameInstance.font.draw(mGameInstance.batch, "This is a whiteboard, fear me!", mWhiteboardX, mWhiteboardY);
    }

    private void showCoffeeZone() {
        mGameInstance.font.draw(mGameInstance.batch, "This is the coffee zone!", mCoffeeX, mCoffeeY);
    }

    private void showCodeZone() {
        mGameInstance.font.draw(mGameInstance.batch, "This is some code!", mCodeX, mCodeY);
    }
}

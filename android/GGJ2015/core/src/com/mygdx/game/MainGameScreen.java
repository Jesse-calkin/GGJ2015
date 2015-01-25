package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector3;

public class MainGameScreen extends ScreenAdapter {

    MyGdxGame mGameInstance;
    Rectangle mWhiteboardClickRectangle;
    Rectangle mCoffeeClickRectangle;
    Rectangle mCodeClickRectangle;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;
    String mWhiteboard;
    String mCoffee;
    String mCode;
    float mWhiteboardX;
    float mWhiteboardY;
    float mCoffeeX;
    float mCoffeeY;
    float mCodeX;
    float mCodeY;
    float mRectHeight;
    float mRectWidth;

    public MainGameScreen(final MyGdxGame game) {
        mGameInstance = game;

        mGameInstance.font.setColor(Color.WHITE);
        mWhiteboard = "Whiteboard MiniGame";
        mCoffee = "Coffee MiniGame";
        mCode = "Coding MiniGame";

        mRectWidth = 200f;
        mRectHeight = 100f;

        mWhiteboardX = (mGameInstance.screenWidth / 2) - ((mRectWidth + mGameInstance.font.getBounds(mWhiteboard).width) / 2);
        mWhiteboardY = (mGameInstance.screenHeight  / 2) + ((mRectHeight * 3) / 2);
        mCoffeeX = mWhiteboardX;
        mCoffeeY = mWhiteboardY - (mRectHeight * 2);
        mCodeX = mWhiteboardX;
        mCodeY = mWhiteboardY - (mRectHeight * 4);

        mWhiteboardClickRectangle = new Rectangle(mWhiteboardX, mWhiteboardY, mRectWidth, mRectHeight);
        mCoffeeClickRectangle = new Rectangle(mCoffeeX, mCoffeeY, mRectWidth, mRectHeight);
        mCodeClickRectangle = new Rectangle(mCodeX, mCodeY, mRectWidth, mRectHeight);

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mGuiCam.update();
        mGameInstance.font.setColor(Color.WHITE);
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

        mGameInstance.batch.begin();
        showWhiteboardZone();
        showCoffeeZone();
        showCodeZone();
        mGameInstance.batch.end();

        ShapeRenderer shapeRenderer = new ShapeRenderer();
        shapeRenderer.setAutoShapeType(true);
        shapeRenderer.begin(ShapeRenderer.ShapeType.Filled);
        shapeRenderer.setColor(Color.WHITE);
        shapeRenderer.rect(mWhiteboardX, mWhiteboardY, mRectWidth, mRectHeight);
        shapeRenderer.setColor(Color.BLUE);
        shapeRenderer.rect(mCoffeeX, mCoffeeY, mRectWidth, mRectHeight);
        shapeRenderer.setColor(Color.GREEN);
        shapeRenderer.rect(mCodeX, mCodeY, mRectWidth, mRectHeight);
        shapeRenderer.end();
    }

    @Override
    public void render(float delta) {
        update();
        draw();
    }

    private void showWhiteboardZone() {
        mGameInstance.font.draw(mGameInstance.batch, mWhiteboard,
                mWhiteboardX + mWhiteboardClickRectangle.width + 10,
                mWhiteboardY + (mWhiteboardClickRectangle.height / 2));
    }

    private void showCoffeeZone() {
        mGameInstance.font.draw(mGameInstance.batch, mCoffee,
                mCoffeeX + mCoffeeClickRectangle.width + 10,
                mCoffeeY + (mCoffeeClickRectangle.height / 2));
    }

    private void showCodeZone() {
        mGameInstance.font.draw(mGameInstance.batch, mCode,
                mCodeX + mCodeClickRectangle.width + 10,
                mCodeY + (mCodeClickRectangle.height / 2));
    }
}

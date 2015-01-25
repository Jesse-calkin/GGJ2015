package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.files.FileHandle;
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
    ShapeRenderer mLeftKeyShape;
    ShapeRenderer mRightKeyShape;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;
    FileHandle mHandle;

    int mLeftX;
    int mLeftY;
    int mRightX;
    int mRightY;
    int mButtonRectWidth;
    int mButtonRectHeight;
    int mCodeShown;

    boolean mLeftTouched;
    boolean mRightTouched;

    String mCodeString;

    public CodeMinigameScreen(final MyGdxGame game) {
        mGameInstance = game;

        mLeftX = 0;
        mLeftY = 0;
        mRightX = Gdx.graphics.getWidth() - Gdx.graphics.getWidth() / 4;
        mRightY = 0;
        mCodeShown = 0;
        mButtonRectWidth = Gdx.graphics.getWidth() / 4;
        mButtonRectHeight = Gdx.graphics.getHeight();

        mLeftTouched = false;
        mRightTouched = false;

        mHandle = Gdx.files.internal("code.txt");
        mCodeString = mHandle.readString();

        mLeftKeyRectangle = new Rectangle(mLeftX,
                mLeftY,
                mButtonRectWidth,
                mButtonRectHeight);
        mRightKeyRectangle = new Rectangle(mRightX,
                mRightY,
                mButtonRectWidth,
                mButtonRectHeight);

        mLeftKeyShape = new ShapeRenderer();
        mLeftKeyShape.setAutoShapeType(true);

        mRightKeyShape = new ShapeRenderer();
        mRightKeyShape.setAutoShapeType(true);

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
        mGuiCam.update();
    }

    private void update() {
        if (Gdx.input.isTouched()) {
            mGuiCam.unproject(mTouchPoint.set(Gdx.input.getX(), Gdx.input.getY(), 0));

            if (mLeftKeyRectangle.contains(mTouchPoint.x, mTouchPoint.y) && !mLeftTouched) {
                mLeftKeyShape.setColor(Color.GRAY);
                mLeftTouched = true;
                drawLine();
                return;
            }

            if (mRightKeyRectangle.contains(mTouchPoint.x, mTouchPoint.y) && !mRightTouched) {
                mRightKeyShape.setColor(Color.GRAY);
                mRightTouched = true;
                drawLine();
                return;
            }
        }
        mLeftKeyShape.setColor(Color.CLEAR);
        mRightKeyShape.setColor(Color.CLEAR);
    }

    private void drawLine() {
        if (mLeftTouched && mRightTouched) {
            mLeftTouched = false;
            mRightTouched = false;
            if (mCodeShown + 50 <= mCodeString.length()) {
                mCodeShown = mCodeShown + 50;
            } else {
                mCodeShown = mCodeString.length();
            }
        }
    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

        mLeftKeyShape.begin(ShapeRenderer.ShapeType.Filled);
        mLeftKeyShape.rect(mLeftX, mLeftY, mButtonRectWidth, mButtonRectHeight);
        mLeftKeyShape.end();

        mRightKeyShape.begin(ShapeRenderer.ShapeType.Filled);
        mRightKeyShape.rect(mRightX, mRightY, mButtonRectWidth, mButtonRectHeight);
        mRightKeyShape.end();

        String subString = mCodeString.substring(0, mCodeShown);

        mGameInstance.batch.begin();
        mGameInstance.font.drawMultiLine(mGameInstance.batch,
                subString,
                Gdx.graphics.getWidth() / 4,
                mGameInstance.font.getMultiLineBounds(subString).height);
        mGameInstance.batch.end();
    }

    @Override
    public void render(float delta) {
        update();
        draw();
    }

    @Override
    public void pause() {}
}

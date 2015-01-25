package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
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

    ShapeRenderer.ShapeType mLeftShapeType;
    ShapeRenderer.ShapeType mRightShapeType;

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

        //all the ones are to ensure the rects show up on an android device
        mLeftX = 1;
        mLeftY = 1;
        mRightX = mGameInstance.screenWidth - mGameInstance.screenWidth / 4;
        mRightY = 1;
        mCodeShown = 0;
        mButtonRectWidth = mGameInstance.screenWidth / 4;
        mButtonRectHeight = mGameInstance.screenHeight - 1;

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

        mLeftShapeType = ShapeRenderer.ShapeType.Line;
        mRightShapeType = ShapeRenderer.ShapeType.Line;

        mLeftKeyShape = new ShapeRenderer();
        mLeftKeyShape.setAutoShapeType(true);
        mLeftKeyShape.setColor(Color.GRAY);

        mRightKeyShape = new ShapeRenderer();
        mRightKeyShape.setAutoShapeType(true);
        mRightKeyShape.setColor(Color.GRAY);

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mGuiCam.update();
    }

    private void update() {
        if (Gdx.input.isTouched() || Gdx.input.isKeyJustPressed(Input.Keys.A) || Gdx.input.isKeyJustPressed(Input.Keys.D)) {
            mGuiCam.unproject(mTouchPoint.set(Gdx.input.getX(), Gdx.input.getY(), 0));

            if ((mLeftKeyRectangle.contains(mTouchPoint.x, mTouchPoint.y) ||
                    Gdx.input.isKeyJustPressed(Input.Keys.A)) && !mLeftTouched) {
                mLeftShapeType = ShapeRenderer.ShapeType.Filled;
                mLeftTouched = true;
                drawLine();
                return;
            }

            if ((mRightKeyRectangle.contains(mTouchPoint.x, mTouchPoint.y) ||
                    Gdx.input.isKeyJustPressed(Input.Keys.D)) && !mRightTouched) {
                mRightShapeType = ShapeRenderer.ShapeType.Filled;
                mRightTouched = true;
                drawLine();
                return;
            }
        }
        mLeftShapeType = ShapeRenderer.ShapeType.Point;
        mRightShapeType = ShapeRenderer.ShapeType.Point;
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

        mLeftKeyShape.begin(mLeftShapeType);
        mLeftKeyShape.rect(mLeftX, mLeftY, mButtonRectWidth, mButtonRectHeight);
        mLeftKeyShape.end();

        mRightKeyShape.begin(mRightShapeType);
        mRightKeyShape.rect(mRightX, mRightY, mButtonRectWidth, mButtonRectHeight);
        mRightKeyShape.end();

        String subString = mCodeString.substring(0, mCodeShown);

        mGameInstance.batch.begin();
        mGameInstance.font.drawMultiLine(mGameInstance.batch,
                subString,
                mGameInstance.screenWidth / 4,
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

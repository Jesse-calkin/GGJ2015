package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.InputMultiplexer;
import com.badlogic.gdx.InputProcessor;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Vector2;
import com.badlogic.gdx.math.Vector3;

import java.util.ArrayList;

public class WhiteboardMinigameScreen extends ScreenAdapter implements InputProcessor, CountdownClock.CountdownClockListener {

    MyGdxGame mGameInstance;
    ArrayList<Vector2> mPoints;
    OrthographicCamera mGuiCam;
    Vector3 mTouchPoint = new Vector3();
    CountdownClock countdownClock;

    String mThemeMessage = "Quick we need a title";
    String mCharacterMessage = "Quick we need a character";
    String mMechanicMessage = "Quick we need a game mechanic";
    int mScreenCount = 0;
    String mStateText;
    int mScore = 0;

    public WhiteboardMinigameScreen(final MyGdxGame game) {
        mGameInstance = game;

        InputMultiplexer inputMultiplexer = new InputMultiplexer(this);
        Gdx.input.setInputProcessor(inputMultiplexer);
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, 800, 480);
        mGuiCam.update();
        mPoints = new ArrayList<Vector2>();
        mStateText = mThemeMessage;
        countdownClock = new CountdownClock(mGameInstance);
        countdownClock.setDuration(10);
        countdownClock.setDelay(2);
        countdownClock.setX(40);
        countdownClock.setY(40);
        countdownClock.setFontColor(Color.DARK_GRAY);
        countdownClock.setCountdownListener(this);
        countdownClock.start();
    }

    private void update() {

    }

    private void draw() {
        Gdx.gl.glClearColor(255, 255, 255, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);

        mGameInstance.font.setColor(Color.DARK_GRAY);
        mGameInstance.batch.begin();
        mGameInstance.font.draw(mGameInstance.batch, mStateText, mGameInstance.screenWidth/2.5f, mGameInstance.screenHeight - mGameInstance.screenHeight/8);
        mGameInstance.batch.end();

        ShapeRenderer shapeRenderer = new ShapeRenderer();
        shapeRenderer.setAutoShapeType(true);
        shapeRenderer.setProjectionMatrix(mGuiCam.combined);
        shapeRenderer.setColor(Color.BLACK);
        Gdx.gl.glLineWidth(20);

        for (int i = 1; i < mPoints.size()-1; i++) {
            shapeRenderer.begin(ShapeRenderer.ShapeType.Line);
            shapeRenderer.line(mPoints.get(i).x, mPoints.get(i).y, mPoints.get(i + 1).x, mPoints.get(i + 1).y);
            shapeRenderer.end();
        }
        countdownClock.render();
    }

    @Override
    public void render(float delta) {
        update();
        draw();
    }

    @Override
    public boolean keyDown(int keycode) {
        return false;
    }

    @Override
    public boolean keyUp(int keycode) {
        return false;
    }

    @Override
    public boolean keyTyped(char character) {
        return false;
    }

    @Override
    public boolean touchDown(int screenX, int screenY, int pointer, int button) {
        return false;
    }

    @Override
    public boolean touchUp(int screenX, int screenY, int pointer, int button) {
        return false;
    }

    @Override
    public boolean touchDragged(int screenX, int screenY, int pointer) {
        Vector3 unprojectedTouchPoint = mGuiCam.unproject(mTouchPoint.set(Gdx.input.getX(), Gdx.input.getY(), 0));
        Vector3 unprojectedEndPoint = mGuiCam.unproject(mTouchPoint.set(screenX, screenY, 0));
        mPoints.add(new Vector2(unprojectedTouchPoint.x, unprojectedTouchPoint.y));
        mPoints.add(new Vector2(unprojectedEndPoint.x, unprojectedEndPoint.y));
        return true;
    }

    @Override
    public boolean mouseMoved(int screenX, int screenY) {
        return false;
    }

    @Override
    public boolean scrolled(int amount) {
        return false;
    }

    @Override
    public void onCountdownFinished() {
        mScreenCount += 1;
        countdownClock.stop();
        mScore += mPoints.size();
        if (mScreenCount == 1) {
            mStateText = mCharacterMessage;
            mPoints.clear();
            countdownClock = new CountdownClock(mGameInstance);
            countdownClock.setDuration(10);
            countdownClock.setDelay(2);
            countdownClock.setX(20);
            countdownClock.setY(20);
            countdownClock.setFontColor(Color.DARK_GRAY);
            countdownClock.setCountdownListener(this);
            countdownClock.start();
        }
        else if (mScreenCount == 2) {
            mStateText = mMechanicMessage;
            mPoints.clear();
            countdownClock = new CountdownClock(mGameInstance);
            countdownClock.setDuration(10);
            countdownClock.setDelay(2);
            countdownClock.setX(20);
            countdownClock.setY(20);
            countdownClock.setFontColor(Color.DARK_GRAY);
            countdownClock.setCountdownListener(this);
            countdownClock.start();
        }
        else {
            mStateText = "";
            String endText;
            if (mScore >= 1000) {
                endText = "Congratulations! Your planning phase is now complete!";
            }
            else {
                endText = "Well you have an idea...kind of...";
            }
            mGameInstance.setScreen(new EndScreen(mGameInstance, endText, mGameInstance.screenWidth/2.0f, mGameInstance.screenHeight/2.0f ));
        }
    }
}

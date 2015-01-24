package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Vector2;
import com.badlogic.gdx.math.Vector3;

import java.util.ArrayList;

public class WhiteboardMinigameScreen extends ScreenAdapter {

    MyGdxGame mGameInstance;
    ArrayList<Vector2> mPoints;
    OrthographicCamera mGuiCam;
    Vector3 mTouchPoint = new Vector3();

    public WhiteboardMinigameScreen(final MyGdxGame game) {
        mGameInstance = game;
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, 800, 480);
        mGuiCam.update();
        mPoints = new ArrayList<Vector2>();
    }

    private void update() {
        if (Gdx.input.isTouched()) {
            Vector3 unprojectedTouchPoint = mGuiCam.unproject(mTouchPoint.set(Gdx.input.getX(), Gdx.input.getY(), 0));
            //Vector3 unprojectedTouchPoint = (mTouchPoint.set(Gdx.input.getX(), Gdx.input.getY(), 0));
            mPoints.add(new Vector2(unprojectedTouchPoint.x, unprojectedTouchPoint.y));
        }
    }

    private void draw() {
        Gdx.gl.glClearColor(255, 255, 255, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);

        for (Vector2 point : mPoints) {
            ShapeRenderer shapeRenderer = new ShapeRenderer();
            shapeRenderer.setAutoShapeType(true);
            shapeRenderer.setProjectionMatrix(mGuiCam.combined);

            shapeRenderer.begin(ShapeRenderer.ShapeType.Filled);
            shapeRenderer.setColor(Color.BLACK);
            shapeRenderer.circle(point.x, point.y, 15);
            shapeRenderer.end();
        }
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

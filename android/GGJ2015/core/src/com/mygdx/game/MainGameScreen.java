package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Screen;
import com.badlogic.gdx.graphics.*;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Vector3;

import java.awt.*;

public class MainGameScreen implements Screen {

    MyGdxGame mGameInstance;
    Rectangle clickRectangle = new Rectangle();


    public MainGameScreen(final MyGdxGame game) {
        mGameInstance = game;
    }

    @Override
    public void show() {

    }

    @Override
    public void render(float delta) {
        update();
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.begin();
        showWhiteboardZone();
        mGameInstance.batch.end();
        int x = 230;
        int y = 230;
        clickRectangle.setBounds((int)x, (int)y, 130, 50);
        ShapeRenderer shapeRenderer = new ShapeRenderer();
        shapeRenderer.setAutoShapeType(true);
        shapeRenderer.begin();
        shapeRenderer.setColor(com.badlogic.gdx.graphics.Color.BLUE);
        shapeRenderer.rect(x, y, 130, 50);
        shapeRenderer.end();
    }

    @Override
    public void resize(int width, int height) {

    }

    @Override
    public void pause() {

    }

    @Override
    public void resume() {

    }

    @Override
    public void hide() {

    }

    @Override
    public void dispose() {

    }

    private void showWhiteboardZone() {

        float x = 230;
        float y = 230;
        mGameInstance.font.draw(mGameInstance.batch, "This is a whiteboard, fear me!", x, y);
    }

    private void showCodeZone() {

    }

    private void showCoffeeZone() {

    }

    private void update() {
        Vector3 touchPoint = new Vector3();
        if (Gdx.input.isTouched()) {
            touchPoint.set(Gdx.input.getX(), Gdx.input.getY(), 0);
            if (clickRectangle.contains(touchPoint.x, touchPoint.y)) {
                mGameInstance.setScreen(new WhiteboardMinigameScreen(mGameInstance));
            }
        }
    }
}

package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Screen;
import com.badlogic.gdx.graphics.GL20;

public class MainGameScreen implements Screen {

    MyGdxGame mGameInstance;

    public MainGameScreen(final MyGdxGame game) {
        mGameInstance = game;
    }

    @Override
    public void show() {

    }

    @Override
    public void render(float delta) {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.begin();
        showWhiteboardZone();
        mGameInstance.batch.end();
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
        mGameInstance.font.draw(mGameInstance.batch, "This is a whiteboard, fear me!", 0, 480);
    }

    private void showCodeZone() {

    }

    private void showCoffeeZone() {

    }
}

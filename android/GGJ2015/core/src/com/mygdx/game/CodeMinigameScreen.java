package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.GL20;

public class CodeMinigameScreen extends ScreenAdapter {

    MyGdxGame mGameInstance;

    public CodeMinigameScreen(final MyGdxGame game) {
        mGameInstance = game;
    }

    private void update() {

    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 2, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
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

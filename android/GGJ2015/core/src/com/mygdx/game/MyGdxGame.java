package com.mygdx.game;

import com.badlogic.gdx.Game;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureRegion;

import java.util.ArrayList;

public class MyGdxGame extends Game {
    SpriteBatch batch;
    BitmapFont font;
    int screenWidth;
    int screenHeight;
    public ArrayList<TextureRegion> whiteboardTextures;

    @Override
    public void create() {
        font = new BitmapFont(Gdx.files.internal("font.fnt"), Gdx.files.internal("font.png"), false);
        font.scale(1.0f);
        batch = new SpriteBatch();
        screenWidth = Gdx.graphics.getWidth();
        screenHeight = Gdx.graphics.getHeight();
        this.setScreen(new IntroScreen(this));
        whiteboardTextures = new ArrayList<TextureRegion>();
    }

    @Override
    public void render() {
        super.render();
    }

    @Override
    public void dispose() {
        batch.dispose();
        font.dispose();
    }
}

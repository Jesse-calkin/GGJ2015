package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector3;

public class CoffeeMinigameScreen extends ScreenAdapter {

    MyGdxGame mGameInstance;
    Texture mCoffeeGuyTexture;
    Texture mBackgroundTexture;
    Sprite mCoffeeGuySprite;
    Sprite mBackgroundSprite;
    Rectangle mBackgroundRectangle;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;

    public CoffeeMinigameScreen(final MyGdxGame game) {
        mGameInstance = game;

        mCoffeeGuyTexture = new Texture(Gdx.files.internal("snakeLava.png"));
        mBackgroundTexture = new Texture(Gdx.files.internal("coffeePot.png"));

        mCoffeeGuySprite = new Sprite(mCoffeeGuyTexture);
        mBackgroundSprite = new Sprite(mBackgroundTexture);

        mBackgroundSprite.setSize(mGameInstance.screenWidth, mGameInstance.screenHeight);
        mCoffeeGuySprite.scale(2);

        mBackgroundRectangle = new Rectangle(0, 0, mGameInstance.screenWidth, mGameInstance.screenHeight);

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mGuiCam.update();
    }

    private void update() {

    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

        mGameInstance.batch.begin();
        mGameInstance.batch.draw(mCoffeeGuySprite, mBackgroundRectangle.x, mBackgroundRectangle.y);
        mGameInstance.batch.draw(mBackgroundSprite,
                mBackgroundRectangle.x,
                mBackgroundRectangle.y,
                mGameInstance.screenWidth,
                mGameInstance.screenHeight);
        mGameInstance.batch.end();
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

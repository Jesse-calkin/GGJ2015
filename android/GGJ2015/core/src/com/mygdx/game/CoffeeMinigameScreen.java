package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.InputAdapter;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector3;

import java.util.ArrayList;

public class CoffeeMinigameScreen extends ScreenAdapter {

    MyGdxGame mGameInstance;
    Texture mCoffeeGuyTexture;
    Texture mBackgroundTexture;
    Texture mCoffeeMeterTexture;
    Rectangle mBackgroundRectangle;
    Rectangle mCoffeeTouchRectangle;
    ShapeRenderer mCoffeeHighlight;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;

    ArrayList<Texture> mCoffeeTextures;

    int mCoffeeGuyX;
    int mCoffeeLevel;

    boolean mCoffeeGuyMovingRight;

    public CoffeeMinigameScreen(final MyGdxGame game) {
        mGameInstance = game;

        mCoffeeGuyX = 1;
        mCoffeeLevel = 0;
        mCoffeeGuyMovingRight = true;
        mCoffeeHighlight = new ShapeRenderer();
        mCoffeeHighlight.setAutoShapeType(true);

        mCoffeeGuyTexture = new Texture(Gdx.files.internal("snakeLava.png"));
        mBackgroundTexture = new Texture(Gdx.files.internal("coffeePot.png"));

        mCoffeeTextures = new ArrayList<Texture>();
        mCoffeeTextures.add(new Texture(Gdx.files.internal("coffee1.png")));
        mCoffeeTextures.add(new Texture(Gdx.files.internal("coffee2.png")));
        mCoffeeTextures.add(new Texture(Gdx.files.internal("coffee3.png")));
        mCoffeeTextures.add(new Texture(Gdx.files.internal("coffee4.png")));
        mCoffeeTextures.add(new Texture(Gdx.files.internal("coffee5.png")));

        mCoffeeMeterTexture = mCoffeeTextures.get(0);

        mBackgroundRectangle = new Rectangle(0, 0, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mCoffeeTouchRectangle = new Rectangle(mGameInstance.screenWidth / 8.5f, mGameInstance.screenHeight / 4, 150, 220);

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mGuiCam.update();

        Gdx.input.setInputProcessor(new InputAdapter() {
            @Override
            public boolean touchUp(int x, int y, int pointer, int button) {
                mGuiCam.unproject(mTouchPoint.set(x, y, 0));

                if (mCoffeeTouchRectangle.contains(mTouchPoint.x, mTouchPoint.y)) {
                    if (mCoffeeLevel < mCoffeeTextures.size() - 1) {
                        mCoffeeLevel++;
                        mCoffeeMeterTexture = mCoffeeTextures.get(mCoffeeLevel);
                    }
                }
                return false;
            }
        });
    }

    private void update() {
        if (mCoffeeGuyMovingRight) {
            mCoffeeGuyX = mCoffeeGuyX + 5;
            if (mCoffeeGuyX >= mGameInstance.screenWidth / 4) {
                mCoffeeGuyMovingRight = false;
            }
        } else {
            mCoffeeGuyX = mCoffeeGuyX - 5;
            if (mCoffeeGuyX <= 0) {
                mCoffeeGuyMovingRight = true;
            }
        }
    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

        mGameInstance.batch.begin();
        mGameInstance.batch.draw(mBackgroundTexture,
                mBackgroundRectangle.x,
                mBackgroundRectangle.y,
                mGameInstance.screenWidth,
                mGameInstance.screenHeight);
        mGameInstance.batch.draw(mCoffeeMeterTexture,
                mGameInstance.screenWidth - (mCoffeeMeterTexture.getWidth() * 6),
                0,
                mCoffeeMeterTexture.getWidth() * 6,
                mCoffeeMeterTexture.getHeight() * 6);
        mGameInstance.batch.end();

        mCoffeeHighlight.begin();
        mCoffeeHighlight.setColor(Color.GREEN);
        mCoffeeHighlight.rect(mGameInstance.screenWidth / 8.5f, mGameInstance.screenHeight / 4, 150, 220);
        mCoffeeHighlight.end();

        mGameInstance.batch.begin();
        mGameInstance.batch.draw(mCoffeeGuyTexture,
                mCoffeeGuyX,
                0,
                mCoffeeGuyTexture.getWidth() * 6,
                mCoffeeGuyTexture.getHeight() * 6);
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

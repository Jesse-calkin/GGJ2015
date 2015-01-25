package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector3;

import java.util.ArrayList;

public class CoffeeMinigameScreen extends ScreenAdapter {

    MyGdxGame mGameInstance;
    Texture mCoffeeGuyTexture;
    Texture mBackgroundTexture;
    Texture mCoffeeMeterTexture;
    Texture mCoffeeMeterTexture1;
    Texture mCoffeeMeterTexture2;
    Texture mCoffeeMeterTexture3;
    Texture mCoffeeMeterTexture4;
    Texture mCoffeeMeterTexture5;
    Sprite mCoffeeGuySprite;
    Sprite mBackgroundSprite;
    //Sprite mCoffeeMeterSprite;
    Rectangle mBackgroundRectangle;
    Rectangle mCoffeeTouchRectangle;
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

        mCoffeeGuyTexture = new Texture(Gdx.files.internal("snakeLava.png"));
        mBackgroundTexture = new Texture(Gdx.files.internal("coffeePot.png"));
        mCoffeeMeterTexture1 = new Texture(Gdx.files.internal("coffee1.png"));
        mCoffeeMeterTexture2 = new Texture(Gdx.files.internal("coffee2.png"));
        mCoffeeMeterTexture3 = new Texture(Gdx.files.internal("coffee3.png"));
        mCoffeeMeterTexture4 = new Texture(Gdx.files.internal("coffee4.png"));
        mCoffeeMeterTexture5 = new Texture(Gdx.files.internal("coffee5.png"));
        mCoffeeTextures = new ArrayList<Texture>();
        mCoffeeTextures.add(mCoffeeMeterTexture1);
        mCoffeeTextures.add(mCoffeeMeterTexture2);
        mCoffeeTextures.add(mCoffeeMeterTexture3);
        mCoffeeTextures.add(mCoffeeMeterTexture4);
        mCoffeeTextures.add(mCoffeeMeterTexture5);

        mCoffeeMeterTexture = mCoffeeMeterTexture1;

        mCoffeeGuySprite = new Sprite(mCoffeeGuyTexture);
        mBackgroundSprite = new Sprite(mBackgroundTexture);

        mBackgroundSprite.setSize(mGameInstance.screenWidth, mGameInstance.screenHeight);

        mBackgroundRectangle = new Rectangle(0, 0, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mCoffeeTouchRectangle = new Rectangle(mGameInstance.screenWidth / 8.5f, mGameInstance.screenHeight / 4, 150, 220);

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mGuiCam.update();
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

        if (Gdx.input.isTouched()) {
            mGuiCam.unproject(mTouchPoint.set(Gdx.input.getX(), Gdx.input.getY(), 0));

            if (mCoffeeTouchRectangle.contains(mTouchPoint.x, mTouchPoint.y)) {
                if (mCoffeeLevel < mCoffeeTextures.size()) {
                    mCoffeeMeterTexture = mCoffeeTextures.get(mCoffeeLevel);
                    mCoffeeLevel++;
                }
            }
        }
    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

        mGameInstance.batch.begin();
        mGameInstance.batch.draw(mBackgroundSprite,
                mBackgroundRectangle.x,
                mBackgroundRectangle.y,
                mGameInstance.screenWidth,
                mGameInstance.screenHeight);
        mGameInstance.batch.draw(mCoffeeGuySprite,
                mCoffeeGuyX,
                0,
                mCoffeeGuySprite.getWidth() * 6,
                mCoffeeGuySprite.getHeight() * 6);

        mGameInstance.batch.draw(mCoffeeMeterTexture,
                mGameInstance.screenWidth - (mCoffeeMeterTexture.getWidth() * 6),
                0,
                mCoffeeMeterTexture.getWidth() * 6,
                mCoffeeMeterTexture.getHeight() * 6);

        mGameInstance.batch.end();

        ShapeRenderer renderer = new ShapeRenderer();
        renderer.setAutoShapeType(true);
        renderer.begin();
        renderer.setColor(Color.GREEN);
        renderer.rect(mGameInstance.screenWidth / 8.5f, mGameInstance.screenHeight / 4, 150, 220);
        renderer.end();
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

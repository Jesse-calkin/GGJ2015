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

public class CoffeeMinigameScreen extends ScreenAdapter implements CountdownClock.CountdownClockListener {

    MyGdxGame mGameInstance;
    Texture mCoffeeGuyTexture;
    Texture mBackgroundTexture;
    Texture mCoffeeMeterTexture;
    Rectangle mCoffeeGuyRectangle;
    Rectangle mCoffeeTouchRectangle;
    ShapeRenderer mCoffeeHighlight;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;
    CountdownClock mCountdownClock;
    int mCoffeeGuyTick = 0;

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

        mCoffeeGuyTexture = new Texture(Gdx.files.internal("coffeeman.png"));
        mBackgroundTexture = new Texture(Gdx.files.internal("coffeePot.png"));

        mCoffeeTextures = new ArrayList<Texture>();
        mCoffeeTextures.add(new Texture(Gdx.files.internal("coffee1.png")));
        mCoffeeTextures.add(new Texture(Gdx.files.internal("coffee2.png")));
        mCoffeeTextures.add(new Texture(Gdx.files.internal("coffee3.png")));
        mCoffeeTextures.add(new Texture(Gdx.files.internal("coffee4.png")));
        mCoffeeTextures.add(new Texture(Gdx.files.internal("coffee5.png")));

        mCoffeeMeterTexture = mCoffeeTextures.get(0);

        mCoffeeGuyRectangle = new Rectangle(mCoffeeGuyX,
                0,
                mCoffeeGuyTexture.getWidth() * 6,
                mCoffeeGuyTexture.getHeight() * 6);

        mCoffeeTouchRectangle = new Rectangle(mGameInstance.screenWidth / 8.5f, mGameInstance.screenHeight / 4, 150, 220);

        mCountdownClock = new CountdownClock(mGameInstance);
        mCountdownClock.setDuration(15);
        mCountdownClock.setDelay(1);
        mCountdownClock.setX(40);
        mCountdownClock.setY(40);
        mCountdownClock.setFontColor(Color.WHITE);
        mCountdownClock.setCountdownListener(this);
        mCountdownClock.start();

        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mGuiCam.update();

        Gdx.input.setInputProcessor(new InputAdapter() {
            @Override
            public boolean touchDown(int x, int y, int pointer, int button) {
                mGuiCam.unproject(mTouchPoint.set(x, y, 0));

                if (mCoffeeTouchRectangle.contains(mTouchPoint.x, mTouchPoint.y) &&
                        !mCoffeeGuyRectangle.contains(mTouchPoint.x, mTouchPoint.y)) {
                    if (mCoffeeLevel < mCoffeeTextures.size() - 1) {
                        mCoffeeLevel++;
                        mCoffeeMeterTexture = mCoffeeTextures.get(mCoffeeLevel);
                    }
                }

                if (mCoffeeTouchRectangle.contains(mTouchPoint.x, mTouchPoint.y) &&
                        mCoffeeGuyRectangle.contains(mTouchPoint.x, mTouchPoint.y)) {
                        mCoffeeLevel = 0;
                        mCoffeeMeterTexture = mCoffeeTextures.get(mCoffeeLevel);
                }
                return true;
            }
        });
    }

    private void update() {
        mCoffeeGuyX = mCoffeeGuyX + 8;
        if (mCoffeeGuyMovingRight) {
            if (mCoffeeGuyX >= mGameInstance.screenWidth / 6 && mCoffeeGuyTick < 5) {
                mCoffeeGuyMovingRight = false;
                mCoffeeGuyTick += 1;
            }
            else if (mCoffeeGuyX >= mGameInstance.screenWidth/3 && mCoffeeGuyTick >= 5) {
                mCoffeeGuyMovingRight = false;
                mCoffeeGuyTick = 0;
            }
        } else {
            mCoffeeGuyX = mCoffeeGuyX - 15;
            if (mCoffeeGuyX <= 0) {
                mCoffeeGuyMovingRight = true;
            }
        }
        mCoffeeGuyRectangle.setPosition(mCoffeeGuyX, 0);
    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

        mGameInstance.batch.begin();
        mGameInstance.batch.draw(mBackgroundTexture,
                0,
                0,
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
                mCoffeeGuyTexture.getWidth()/3,
                mCoffeeGuyTexture.getHeight()/3);
        mGameInstance.batch.end();

        mCountdownClock.render();
    }

    @Override
    public void render(float delta) {
        update();
        draw();
    }

    @Override
    public void onCountdownFinished() {
        String endText;
        if (mCoffeeLevel == 4) {
            endText = "You managed to get coffee for your entire team";
        }
        else {
            endText = "Go back home and train your dexterity stats";
        }
        mGameInstance.setScreen(new EndScreen(mGameInstance, endText, mGameInstance.screenWidth/2, mGameInstance.screenHeight/2));
    }
}

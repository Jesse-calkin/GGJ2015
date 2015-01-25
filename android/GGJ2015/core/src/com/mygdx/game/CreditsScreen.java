package com.mygdx.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.InputAdapter;
import com.badlogic.gdx.ScreenAdapter;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.math.Vector3;

public class CreditsScreen extends ScreenAdapter {
    MyGdxGame mGameInstance;
    Vector3 mTouchPoint;
    OrthographicCamera mGuiCam;
    StringBuilder mNames;

    float mStringX;
    float mStringY;

    public CreditsScreen(final MyGdxGame game) {
        mGameInstance = game;

        mNames = new StringBuilder();
        mNames.append("BRANDON DAVIS\n");
        mNames.append("NICK DOBOS\n");
        mNames.append("LUKE HAMILTON\n");
        mNames.append("ALLI PIERCE\n");
        mNames.append("CARL VEAZEY\n");
        mNames.append("CHRIS WEATHERS\n");
        mNames.append("ERIC YOUNG");

        mStringX = (mGameInstance.screenWidth / 2) - (mGameInstance.font.getMultiLineBounds(mNames).width / 2);
        mStringY = (mGameInstance.screenHeight / 2) + (mGameInstance.font.getMultiLineBounds(mNames).height / 2);
        mTouchPoint = new Vector3();
        mGuiCam = new OrthographicCamera();
        mGuiCam.setToOrtho(false, mGameInstance.screenWidth, mGameInstance.screenHeight);
        mGuiCam.update();

        Gdx.input.setInputProcessor(new InputAdapter() {
            @Override
            public boolean touchDown(int x, int y, int pointer, int button) {
                mGameInstance.setScreen(new IntroScreen(mGameInstance));
                return true;
            }
        });
    }

    private void draw() {
        Gdx.gl.glClearColor(0, 0, 0, 2f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        mGameInstance.batch.setProjectionMatrix(mGuiCam.combined);

        mGameInstance.batch.begin();
        mGameInstance.font.drawMultiLine(mGameInstance.batch,
                mNames,
                mStringX,
                mStringY);
        mGameInstance.batch.end();
    }

    @Override
    public void render(float delta) {
        draw();
    }
}

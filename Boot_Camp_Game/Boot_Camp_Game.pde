Player player;
int score;
boolean gameStarted;  //Has the game started? (determines whether to show game or main menu)
boolean canJump;      //Can the player jump (used to avoid infinite jump by holding down button)
ArrayList<Spike> spikes;

color backgroundColour = color(255, 100, 50, 75);

void setup() {
  size(607, 1080);  //Set the size for the app on desktop only (sized to resemble mobile display)
  //fullScreen();  //Set the app to fullscreen (for mobile only)
  
  backgroundColour = color(random(100, 255), random(100, 255), random(100, 255), 75);  //Create a random colour and set the background to that colour
  noStroke();    //Do not add stroke to any object in the game

  player = new Player();  //Initialise the player object
  gameStarted = false;
  canJump = false;

  //Create an array of five spikes to start the game with
  spikes = new ArrayList();
  for ( int i= 0; i < 5; i++) {
    spikes.add(new Spike());
  }
}

void draw() {
  background (backgroundColour);  //Draw the background colour each frame

  if (!gameStarted) {  //If the game has not been started, show the main menu
    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("AVOID", width/2, height/2 - 45);
    text("THE", width/2, height/2);
    text("SPIKES", width/2, height/2 + 45);
    textSize(20);
    text("PRESS ANY BUTTON TO START", width/2, height/2 + 100);
    fill(255, 150);
    text("DEVELOPED BY RAHUL SHARMA", width/2, height - 60);
    text("CITY, UNIVERSITY OF LONDON", width/2, height - 40);
    text("MADE USING PROCESSING 3.2.1", width/2, height - 20);

    if (keyPressed || mousePressed) {  //If a key or the mouse is pressed, start the game and reset the score
      score = 0;
      gameStarted = true;
    }
  } else {
    //Show the score in the centre of the screen
    textSize (150);
    textAlign(CENTER, CENTER);
    fill (255, 100);  //Set the colour to a semi-transparent white
    text(score, width/2, height/2);

    player.draw();  //Call the player's 'draw' function

    if (player.pos.x <=0 + player.playerSize.x/2 || player.pos.x >= width - player.playerSize.x/2) {  //If the player collides with the left or right wall
      if (score % 3 == 0) {    //If the score is a multiple of 3, add one more spike
        spikes.add(new Spike());
      }
      for (Spike spike : spikes) {
        spike.yPos = random(spike.size, height - spike.size);  //Set the spikes y position to a random position within the frame
      }
      player.vel.x *= -1.02f;  //Make the player switch direction and increase their speed by 2%
      score ++;                //Increase the score
    }

    //If the player goes off the vertical edges of the screen reset the game.
    if (player.pos.y <= 0 || player.pos.y > height - player.playerSize.y/2) {
      setup();
    }

    for (Spike spike : spikes) {
      //Set the spikes x position based on the player's velocity
      if (player.vel.x < 0) {
        spike.xPos = 0;
      } else if (player.vel.x > 0) {
        spike.xPos = width;
      }
      spike.draw();  //Call the draw function of the spikes

      //If the player colliders with the spike, reset the game
      if (dist(player.pos.x, player.pos.y, spike.xPos, spike.yPos) <= (player.playerSize.x/2 + spike.size) * 0.85f) {
        setup();
      }
    }
  }
}

//If a key is pressed call the jump function
void keyPressed() {
  jump(10);
}

void keyReleased() {
  canJump = true;
}

//If the mouse is pressed call the jump function
void mousePressed() {
  jump(10);
}

void mouseReleased() {
  canJump = true;
}

void jump(float jumpDist) {
  if (gameStarted && canJump) {  //If the game has started allow the player to jump
    player.vel.y = -jumpDist;
    canJump = false;
  }
}
class Player {
  
  PVector pos;    //Position
  PVector vel;    //Velocity
  PVector gravity;
  PVector playerSize;

  Player() {
    playerSize = new PVector (50, 50);  //Set the player's size
    pos = new PVector (width/2 - playerSize.x/2, height/2 - playerSize.y/2);  //Set the position to the middle of the screen
    vel = new PVector (random (-4f, 4f), random (-3f, 3f));  //Set the starting velocity to random numbers
    gravity = new PVector(0, 0.2f);  //Set the gravity of the player
  }

  void draw() {
    //Set the minimum velocity for each direction to 3.5f
    if (vel.x >= -3.5f && vel.x<0) {
      vel.x = -3.5f;
    } else if (vel.x <= 3.5f && vel.x >= 0) {
      vel.x = 3.5f;
    }

    pos.add(vel);  //Add the velocity to the position
    vel.add(gravity);  //Add the gravity to the velocity

    fill(255);  //Set the colour to white
    ellipse(pos.x, pos.y, playerSize.x, playerSize.y);  //Draw the player circle at the current position
  }
}
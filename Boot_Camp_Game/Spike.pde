class Spike {
  
  float xPos, yPos;   //Variables for the position of the spikes
  float size;    //The size of the spike

  Spike() {
    size = 30f;  //Set the size of the spike
    yPos = random(size, height - size);  //Set the initial y position to somewhere within the screen bounds
  }

  void draw() {
    fill (25);  //Set the colour to a semi-transparent white
    //Render the spike based on the x position of the spike
    if (xPos == 0) {
      triangle(xPos, yPos - size, xPos + size, yPos, xPos, yPos + size);
    } else {
      triangle(xPos, yPos - size, xPos - size, yPos, xPos, yPos + size);
    }
  }
}
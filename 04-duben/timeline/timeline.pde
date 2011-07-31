import timeline.*; 
Timeline timeline; 


void setup() {
  size(320,240,P2D);

  timeline = new Timeline(this);


 // timeline.setTime("br", 0.0);

}


void draw() {

  float value = timeline.getValue("br");

  background(value*255);

}



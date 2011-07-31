class BX {
  PGraphics pix;
  int w,h;

  BX(int _w,int _h) {
    w=_w;
    h=_h;
    pix = createGraphics(w,h,P3D);
  }

  void update() {
    pix.beginDraw();
    pix.ortho(-w/2, w/2, -h/2, h/2, -w/2, h/2);
    pix.background(0);
    pix.stroke(255);
    pix.strokeWeight(22);
    pix.noFill();
    pix.pushMatrix();
    pix.translate(pix.width/2,pix.height/2);
    pix.rotateY(radians(frameCount*2));
    pix.rotateX(radians(frameCount*2.3231));
    pix.box(pix.width);
    pix.popMatrix();
    pix.endDraw();
  }

  void draw() {
    image(pix,0,0);
  }
}

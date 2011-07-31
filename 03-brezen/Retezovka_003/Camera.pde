PGraphics3D p3d;
PMatrix3D proj = new PMatrix3D();
PMatrix3D cam = new PMatrix3D();
PMatrix3D modvw = new PMatrix3D();
PMatrix3D modvwInv = new PMatrix3D();
PMatrix3D screen2Model = new PMatrix3D();


// rotation
float rotX, rotY;



// index of current mouseover / clicked vertex
int vertexMouseOver = -1;
int vertexKlicked= -1;

// z value in model/world space of current vertex
float zModelMouseOver;
float zModelKlick;



class Camera{

  Camera()
  {
    p3d = (PGraphics3D)g;
    //rotX=PI;
  }


  void preDraw()
  {

    pushMatrix();

    //apply mouse rotation and translation to center of screen
    translations();

    getMatrices();

    applyMatrices();

  }
  void translations()
  {
    translate(width/2, height/2);
    //mouse rotate
    rotateX(rotX);
    rotateZ(-rotY);
  }

  void getMatrices()
  {
    //get 3d matrices
    proj = p3d.projection.get();
    cam = p3d.camera.get();
    modvw = p3d.modelview.get();
    modvwInv = p3d.modelviewInv.get();



  }

  void applyMatrices()
  {
    screen2Model.mult(scrn, model);
    screen2Model = modvwInv;
    screen2Model.apply(cam);
  }

  void postDraw()
  {

    //visualize 3d axes for orientation
    //camer.drawAxes3D();

    //visualize vertices
    //camer.drawVertSphere();
    //	camer.drawVert();

   //hitDetect();

    // 3d object space end
    popMatrix();

   // drawHitDetect();
  }



  void drawAxes3D()
  {
    stroke(255,0,0);
    line(0,0,0, 100,0,0);
    stroke(0,255,0);
    line(0,0,0, 0,-100,0);
    stroke(0,0,255);
    line(0,0,0, 0,0,100);
  }



 





}








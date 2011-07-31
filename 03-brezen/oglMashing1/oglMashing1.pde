import javax.media.opengl.*;
import processing.opengl.*;

float a; 

void setup() {
  size(800, 600, OPENGL);
}

void draw() {
  //background(255);
  
  PGraphicsOpenGL pgl = (PGraphicsOpenGL) g;  // g may change
  GL gl = pgl.beginGL();  // always use the GL object returned by beginGL
  
  drawGL(gl);
  gl.glClear(gl.GL_COLOR_BUFFER_BIT | gl.GL_DEPTH_BUFFER_BIT);// Vymaže obrazovku a hloubkový buffer
  
  pgl.endGL();
  
  a += 1.0;
}

float rtri = 0;
float rquad = 0;


void drawGL(GL gl){


gl.glLoadIdentity();// Reset matice
gl.glTranslatef(-150f,0.0f,-60f);// Posun doleva a do hloubky
gl.glRotatef(rtri,0.0f,1.0f,0.0f);// Otočí trojúhelník okolo osy y

gl.glBegin(gl.GL_TRIANGLES);// Začátek kreslení trojúhelníků

gl.glColor3f(1.0f, 0.0f, 0.0f);// Červená barva

gl.glVertex3f(0.0f, 100.0f, 0.0f);// Horní bod

gl.glColor3f(0.0f, 1.0f, 0.0f);// Zelená barva

gl.glVertex3f(-100.0f, -100.0f, 0.0f);// Levý dolní bod

gl.glColor3f(0.0f, 0.0f, 1.0f);// Modrá barva

gl.glVertex3f(100.0f, -100.0f, 0.0f);// Pravý dolní bod

gl.glEnd();// Ukončení kreslení trojúhelníků

gl.glLoadIdentity();// Reset matice

gl.glTranslatef(150f,0.0f,-60f);// Posun počátku

gl.glRotatef(rquad,1.0f,0.0f,0.0f);// Pootočení čtverce okolo osy x

gl.glColor3f(0.5f,0.5f,1.0f);// Světle modrá barva

gl.glBegin(gl.GL_QUADS);// Začátek kreslení obdélníků

gl.glVertex3f(100.0f, -100.0f, 0.0f);// Levý horní bod

gl.glVertex3f( -100.0f, -100.0f, 0.0f);// Pravý horní bod

gl.glVertex3f( -100.0f,100.0f, 0.0f);// Pravý dolní bod

gl.glVertex3f(100.0f,100.0f, 0.0f);// Levý dolní bod

gl.glEnd();// Konec kreslení obdélníků

rtri+=0.2f;// Inkrementace úhlu pootočení trojúhelníku

rquad-=0.15f;// Inkrementace úhlu pootočení čtverce
}

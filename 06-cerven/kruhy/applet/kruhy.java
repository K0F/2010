import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class kruhy extends PApplet {

/**
* Ellipses by Krystof Pesek (Kof), licensed under Creative Commons Attribution-Share Alike 3.0 license.
* Work: http://openprocessing.org/visuals/?visualID= 10478
* License: http://creativecommons.org/licenses/by-sa/3.0/
*
* visit more @ http://vimeo.com/kof
* if you leave this header, bend, share, spread the code, it is a freedom!
*
*   ,dPYb,                  ,dPYb,
*   IP'`Yb                  IP'`Yb
*   I8  8I                  I8  8I
*   I8  8bgg,               I8  8'
*   I8 dP" "8    ,ggggg,    I8 dP
*   I8d8bggP"   dP"  "Y8ggg I8dP
*   I8P' "Yb,  i8'    ,8I   I8P
*  ,d8    `Yb,,d8,   ,d8'  ,d8b,_
*  88P      Y8P"Y8888P"    PI8"8888
*                           I8 `8,
*                           I8  `8,
*                           I8   8I
*                           I8   8I
*                           I8, ,8'
*                            "Y8P'
*
*/

int num = 60;
Ellipse e[] = new Ellipse[num];

//char[] chars = {'0','1','2','3','4','5','6','7','8','9','-','<'};

public void setup(){

	size(400,300,P3D);
	for(int i = 0;i<num;i++)
		e[i] = new Ellipse(width/2,height/2,0,i);

	noFill();//(255,0,0,40);
	noSmooth();


       // textFont(createFont("Veranda",14,true,chars));
      //  textMode(SCREEN);
        
         

}

public void draw(){
	background(0);
	for(int i = 0;i<num;i++)
		e[i].draw();
}

class Ellipse{

	float x,y,z;
	PVector rot;
	int id;
	float dens = 0.1f;
	float r = 100.0f;

	float rate = 100.0f;
	float speed = 0.02f;
        int segno;

	Ellipse(float _x,float _y,float _z,int _id){
		x=_x;
		y=_y;
		z=_z;
		id=_id;
                segno = (int)random(40);

		rot = new PVector(random(-1,1),random(-1,1),random(-1,1));
	}
	
	public void follow(){
		x+=(mouseX-x)/(20.0f);
		
		y+=(mouseY-y)/(20.0f);
	}

	public void draw(){
		//follow();
		
		rot.add(
		        noise((id+frameCount)/rate)*speed,
		        noise((id+34.0f+frameCount)/rate)*speed,
		        noise((id+409.0f+frameCount)/rate)*speed
		);

		pushMatrix();
		translate(x,y,z);

		pushMatrix();
		rotateX(rot.x);
		rotateY(rot.y);
		rotateZ(rot.z);

                int cnt = 0;
                
		beginShape();
		for(float f = -PI;f<PI;f+=dens){
                        float X = cos(f)*r;
			float Y = sin(f)*r;
			                      
  
                        if(abs(cnt-segno)<5){
                         // pushStyle();
                         // fill(255,map(modelZ(X,Y,0),-r,r,0,255));
                         // text("<-"+segno,modelX(X,Y,0),modelY(X,Y,0));
                         // popStyle();
                          stroke(0xffffdddd,map(modelZ(X,Y,0),-r,r,1,180-abs(cnt-segno)*30));
                        
                        }else{
                          
                         stroke(0xffffffff,map(modelZ(X,Y,0),-r,r,1,60)); 
                        
                        }
                        
			 strokeWeight(map(modelZ(X,Y,0),-r,r,5,1.8f));
			
			vertex(X,Y,0);
                        cnt++;
		}
		endShape(CLOSE);
                
                 if(frameCount%2==0)
                segno++;
                if(segno>=cnt){
                 segno=0; 
                }
/*
                cnt = 0;
                for(float f = -PI;f<PI;f+=dens){
                   if(cnt==segno){
                      stroke(#ff0000,map(modelZ(X,Y,0),-r,r,0,200));  
                       float X = cos(f)*r;
			float Y = sin(f)*r;
                        strokeWeight(map(modelZ(X,Y,0),-r,r,5,1.8));
                        line(X,Y,lerp(X,0,0.1),lerp(Y,0,0.1));
                        }
                         cnt++;
                }
                */
		popMatrix();
		popMatrix();

                
	}
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "kruhy" });
  }
}

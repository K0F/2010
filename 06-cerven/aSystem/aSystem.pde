boolean rec = true;
Recorder r;

ArrayList agents;
ArrayList attrPoints;
ArrayList repPoints;

int agentsAmount=100000;
int attrAmount=40;
int repAmount=40;

void setup(){
  size(640,480,P2D);
  stroke(0);
  agents=new ArrayList();
  attrPoints=new ArrayList();
  repPoints=new ArrayList();

  for(int i=0;i<attrAmount;i++){
    attrPoints.add(new PVector(round(random(10,width-10)),round(random(10,height-10))));//create attraction points    
  }
  for(int i=0;i<repAmount;i++){
    repPoints.add(new PVector(round(random(10,width-10)),round(random(10,height-10))));//create repulsion points      
  }

  for(int i=0;i<agentsAmount;i++){
    agents.add(new Agent(round(random(10,width-10)),round(random(10,height-10))));//create agents 
  }


	if(rec)
	r = new Recorder("out","gravity.mp4");
}

void draw(){
  background(0);
  for(int i=0;i<agents.size();i++){
    Agent a =(Agent)agents.get(i);
    a.move();
    a.display();

  }  

  for(int i=0;i<attrPoints.size();i++){//display attraction points
    PVector aPt=(PVector)attrPoints.get(i);
    fill(#ccff00);
  //  ellipse(aPt.x,aPt.y,10,10);
  } 

  for(int i=0;i<repPoints.size();i++){//display repulsion points
    PVector rPt=(PVector)repPoints.get(i);
    fill(#FFCC00);
//    ellipse(rPt.x,rPt.y,10,10);
  }  

	if(rec)
	r.add();

}


void keyPressed(){
	if(key=='q'){
		if(rec){
			r.finish();
			exit();	
		}
	}

}




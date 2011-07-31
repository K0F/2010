class Agent{
  PVector pos, vel, followSum, escapeSum;
  color c;

  Agent(int _x, int _y){
    pos=new PVector(_x,_y);  
    vel=new PVector(0,0);
    followSum=new PVector(0,0);
    escapeSum=new PVector(0,0);
    c=color(255);
  }

  void move(){
    vel.add(follow());
    vel.add(escape());
    vel.limit(1); 
    pos.add(vel);  
  }

  void display(){
    stroke(follow().mag()*25500,escape().mag()*25500,0,80);
    line(pos.x,pos.y,pos.x+vel.x*10,pos.y+vel.y*10);
  }

  PVector follow(){///////////attraction force
    followSum.mult(0);
    int count=0;
    for(int i=0; i<attrPoints.size();i++){
      PVector aPt=(PVector)attrPoints.get(i);
      float d=pos.dist(aPt);
      if (d<450){//attraction distance
        PVector dir = PVector.sub(aPt,pos);
        dir.normalize();
        dir.div(d);
        followSum.add(dir);
        count++;  
      }
    }  
    if (count > 0) {
      followSum.div(count);
    }
    return followSum;
  }

  PVector escape(){///////////repulsion force
    escapeSum.mult(0);
    int count=0;
    for(int i=0; i<repPoints.size();i++){
      PVector rPt=(PVector)repPoints.get(i);
      float d=pos.dist(rPt);
      if (d<450){//repulsion distance
        PVector dir = PVector.sub(rPt,pos);
        dir.normalize();
        dir.div(d);
        escapeSum.sub(dir);
        count++;  
      }
    }  
    if (count > 0) {
      escapeSum.div(count);
    }
    return escapeSum;
  }
}




class Splat {
  float x[],y[];
  color c[];
  float bx,by;
  int num = 10;
  float time = 1;

  Splat(int _num,float _x,float _y) {
    num = _num;
    x = new float[num];
    y =  new float[num];
    c = new color[num];


    bx = _x;
    by = _y; 
    time = 1;

    for(int i = 0;i<x.length;i++) {
      x[i] = bx+random(-2,2);
      y[i] = by+random(-2,2);
      c[i] = color(random(255),10,10);
    }
  }

  void animate() {
    if(time<10) {
      for(int i = 0;i<x.length;i++) {
        x[i] += (x[i]-bx)/(time);
        y[i] += (y[i]-by)/(time);

        // strokeWeight(4);

        stroke(c[i],map(time,1,300,255,0));
        point(x[i],y[i]);
      }

      time*=1.43;
    }
  }
}


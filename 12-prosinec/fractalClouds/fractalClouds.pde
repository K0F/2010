

static int[] DX = {
  -1,0,1,-1,1,-1,0,1,-2,-1,0,1,2,-2,2,-2,2,-2,2,-2,1,0,1,2
};
static int[] DY = {
  -1,-1,-1,0,0,1,1,1,-2,-2,-2,-2,-2,-1,-1,0,0,1,1,2,2,2,2,2
};

int idx = 0;
int mod = 0;

int w = 320,h = 240;

PImage store;

int s;
float pat[];


int dirs = 40;

boolean border;

void setup() {

  size(w,h,P2D);
  s = w*h;
  rectMode(CENTER);
  noStroke();
  fill(0);
  
  noSmooth();
  
  store = createImage(w, h, RGB);

  colorMode(HSB);

  pat = new float[s];

  for(int i=0; i<s; i++) 
    pat[i] = map(i,0,s,0,255);
}

void draw() {


  loadPixels();


  process();

store.loadPixels();

  for(int i = 0;i<s;i++) {
    store.pixels[i] = lerpColor(color(pat[i]%255),store.pixels[i],0.1);
  }





  tint(255,20);
  image(store,0,0);
 
}


void process() {
  idx += frameCount%93;
  idx = idx%DX.length;// floor(random(DX.length));

  float newPat[] = new float[s];
  mod = (int)(((noise(frameCount)))*DX.length);

  for(int j=0; j<s; j++) {


    if(((j+frameCount)%abs(DX[idx]*20+1) | (j*frameCount)%abs(DY[idx]*20+1)) < 12) {
      newPat[j] = pat[j]; 
      continue;
    }

    int x1 = j%w + DX[mod%DX.length], y1 = j/w + DY[mod%DX.length];

    if(x1<0) x1 = w-1-(-x1-1)% w;
    else if(x1>=w) x1 = x1%w;    

    if(y1<0) y1 = h-1-(-y1-1)% h;
    else if(y1>=h) y1 = y1%h;

    int newIdx = y1*width+x1;

    newPat[j] += (pat[newIdx]);
  }

  for(int j=0; j<s; j++) {
    pat[j] = newPat[j];
  }
}


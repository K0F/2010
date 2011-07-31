int width = 900;
int height = 500;

boolean addSnow = false;
float maxSnowTheta = HALF_PI*4/5;

int nTrees = 2;
tree[] trees;
color backgroundCol = color(222);
//color treeColor = color(0,255,0);

void setup(){
  smooth();
  size(width, height,P2D);
  background(backgroundCol);
  noFill();
  newTrees();
}

void draw(){
	if(frameCount%50==0){
fadeScreen();
  newTrees();
  for(int i=0; i<nTrees; i++)
    trees[i].draw();
	}
}

void newTrees(){
/* tree(x, y, theta, branchWidth0,
       totalBranchLength, nBranchDivisions, 
       percentBranchless, branchSizeFraction, 
       dThetaGrowMax, dThetaSplitMax,
       oddsOfBranching, color)
*/

//  background(backgroundCol);
//  noFill();
  trees = new tree[nTrees];
  for(int i=0; i<nTrees; i++)
    trees[i] = new tree(random(width), height, -HALF_PI, 10,
                   300, 30, 
                   .3, .5, 
                   PI/15, PI/6,
                   .3, color(random(0,30)));
                   
  for(int i=0; i<nTrees; i++)
    trees[i].draw();
}



void blankScreen(){
  fill(backgroundCol);
  noStroke();
  rect(0,0,width,height);
}

void fadeScreen(){
  fill(backgroundCol,5);
  noStroke();
  rect(0,0,width,height);
}


int randomSign(){ //returns +1 or -1
  float num = random(-1,1);
  if(num==0)
    return -1;
  else
    return (int)(num/abs(num));
}

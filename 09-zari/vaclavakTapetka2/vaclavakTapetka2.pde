import processing.pdf.*;


PGraphicsPDF pdf;
boolean PDFing = true;
PFont font;

PGraphics guess;
float perimeter = 20;

PImage podklad;

boolean filled = true;
boolean newvals = false;

float w = random(1,perimeter);
float h = random(1,perimeter);

float x,y,rot;

char current;

int choice = 0;

float sw = 1;

void setup(){
	
	podklad = loadImage("A3ver2.png");
	
	

	size(podklad.width,podklad.height);
	x = random(-width/2,height/2);
	y = random(-height/2,height/2);
	rot = random(-PI,PI);

	

	//rectMode(CENTER);
	background(255);
	smooth();
	fill(0);
	noStroke();

	font = createFont("URW Gothic L",perimeter);
	textFont(font);


	image(podklad,0,0);

	if (PDFing) {
		pdf = (PGraphicsPDF) createGraphics(width ,height, PDF,  "txt.pdf");
		beginRecord(pdf);
		//pdf.background(0);
		pdf.textFont(font);
		pdf.textMode(SHAPE);// = SHAPE;
		pdf.fill(0);
		pdf.noStroke();

	}


	generate();



}


void generate(){

	int cnt = 0;


	for(int i = 0;i<100;i++){
	genNew();


	}

}

void printit(){

	//pushMatrix();

	translate(width/2,height/2);
	rotate(rot);

	translate(x,y);

	//rect(0,0,w,h);

	//popMatrix();



	//image(guess,0,0);
}

void keyPressed(){

	if (PDFing&&key=='q') {
		PDFing = false;
		endRecord();
		exit();
	}
}

void genNew(){
	w = random(2,perimeter);
	h = random(2,perimeter);//random(6,perimeter);

	x = random(-width/2,width/2);
	y = random(-height/2,height/2);
	rot = random(-PI,PI);

	current = (char)random(55,120);

	
        choice = 1;//(int)random(1,2);

	//sw = random(1,10);

	guess = createGraphics(width,height,P2D);


	guess.beginDraw();
	//guess.background(-1);
	guess.rectMode(CENTER);
	guess.smooth();

	//perimeter*=0.999999;

	if(filled){
		guess.noStroke();
		guess.fill(0);
	}else{
		guess.stroke(0);
		guess.strokeWeight(sw);
		guess.noFill();
	}






	//guess.pushMatrix();
	guess.translate(width/2,height/2);
	guess.rotate(rot);
	guess.translate(x,y);
	if(choice == 0){
		guess.textFont(font,h*4);
		guess.text(current,0,0);
	}else if(choice == 1){
		guess.rect(0,0,h*4,h*4);
	}else if(choice == 2){
		guess.ellipse(0,0,h*4,h*4);
	}else if(choice == 3){
		guess.triangle(0,0,-w,w,-h,h);
	}
	guess.endDraw();

	if(pass()){
		if(filled){
			noStroke();
			fill(0);
		}else{
			stroke(0);
			strokeWeight(sw);
			noFill();
		}

		//noStroke();
		//fill(0);
		rectMode(CENTER);
		resetMatrix();
		translate(width/2,height/2);
		rotate(rot);
		translate(x,y);
		if(choice == 0){
			textFont(font,h*4);
		}else if(choice == 1){
			rect(0,0,h*4,h*4);
			text(current,0,0);
		}else if(choice == 2){
			ellipse(0,0,h*4,h*4);
		}else if(choice == 3){
			triangle(0,0,-w,w,-h,h);
		}

	}



}

boolean pass(){
	guess.loadPixels();
	loadPixels();

	boolean pass = true;

	int first = 0;
	for(int i = 0;i<width*height;i++){
		if(guess.pixels[i]!=0){
			first = i;
			//println(i);
			break;
		}
	}

	for(int i = first;i<width*height;i++){
		if(guess.pixels[i]!=0){
			if(brightness(pixels[i])<=200){
				pass = false;
				break;
			}
		}
	}

	return pass;

}



void draw(){

	generate();



}

void mousePressed(){
	generate();
}

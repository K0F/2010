import processing.pdf.*;


PGraphicsPDF pdf;
boolean PDFing = false;
PFont font;

float maxx = 10.0;


void setup(){
	size(1048,1048,P2D);

	stroke(0,50);
	strokeWeight(1);
	noFill();
	smooth();
	
	font = createFont("Anivers", 9);
	textFont(font);
}
void draw(){

	background(0);
	
	if (PDFing) {
	pdf = (PGraphicsPDF) createGraphics(width ,height, PDF,  frameCount+".pdf");
	beginRecord(pdf);
	pdf.background(0);
	pdf.textFont(font);
	pdf.textMode(SHAPE);// = SHAPE;
	pdf.noFill();

	}

	float y = mouseY/100.0;
	for(float q = 1.1+y;q<(maxx+y);q+=0.8){

		beginShape();
		//vertex(0,noise(1/30.0)*height);
		stroke(map(q,1,maxx,255,0));
		if (PDFing) pdf.stroke(255,map(q,0,maxx,255,10));
			
		for(int i = 0;i<width;i+=2){
			curveVertex(i,map(noise(frameCount+cos(map(i+mouseX,0,width,-PI/2,PI/2))*q),0,1,0,height));
		}
		//vertex(width,noise(width/30.0)*height/q);
		endShape();
	}
	
	if (PDFing) {
		PDFing = false;
		endRecord();
	}
}

void mousePressed(){
	PDFing = true;

}

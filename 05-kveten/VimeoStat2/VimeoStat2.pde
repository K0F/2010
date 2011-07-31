
//kof@kLab:~/.evolution/mail/local$ cat Vimeo | grep 'Date'

String[] dates;
String[] plays;
String mesice[] = {"January","February","March","April","May","June","July","August","September","October","November","December"};

int mo = 0;
int ply[];

int TOP = 30;
int SMOOTH = 1;

import processing.pdf.*;


PGraphicsPDF pdf;
boolean PDFing = false;
PFont font,font2;

void setup(){                                                             
	size(1024,400,OPENGL);
	//hint(ENABLE_NATIVE_FONTS);
	grab();
	stroke(255,50);
	noFill();
	smooth();

	//println(PGraphicsPDF.listFonts());
	font = createFont("Sawasdee Bold", 9);
	font2 = createFont("Sawasdee Bold",28);
	textFont(font);                                                        
	//textMode(SHAPE);
	
	println(PFont.list());



}

void draw(){

	if (PDFing) {
	pdf = (PGraphicsPDF) createGraphics(width ,height, PDF,  "/desk/VimeoStat" + "_" + nf(day(),2) + "_"+nf(month(),2)+"_"+year()+".pdf");
	beginRecord(pdf);
	
	pdf.textFont(font);
	pdf.textMode(SHAPE);// = SHAPE;

	}
	background(0);

	int cntr = 0;
	float prum = map(ply[0],0,TOP,height,0);
	noFill();


	int len = 30;

	for(int q = 0;q<len;q++){
		beginShape();

		vertex(0,prum);

		for(int i = 0;i<ply.length;i++){
			float x = map(i,0,ply.length-1,0,width);

			float y = map(ply[i],0,TOP,height,0);

			stroke(lerpColor(#ffcc00,#ffffff,norm(q,0,len)),map(q,0,len,10,100));
			prum += (y-prum)/(SMOOTH+0.0+q);
			curveVertex(x,prum);



		}

		vertex(width,prum);
		endShape();

	}





	
	textFont(font2);
	
	text(year(),20,40);
	textFont(font);
	mo=0;
	fill(255);
	for(int i = 0;i<ply.length;i++){
		float x = map(i,0,ply.length,0,width);
		if(cntr%28==0){
			line(x,0,x,height);
			text(mesice[mo],x+10,height-20);
			mo++;
		}

		cntr++;

	}



	if (PDFing) {
		PDFing = false;
		endRecord();
	}

}
void keyPressed(){
	if(key==' '){
		
		PDFing = true;
	}

}


void grab(){

	String command[] = {"grabDates.sh",sketchPath};
	String command2[] = {"grabPlayed.sh",sketchPath};
	exec(command);
	exec(command2);


	dates = loadStrings(sketchPath+"/dates.txt");
	plays = loadStrings(sketchPath+"/played.txt");

	ply = new int[0];

	for(int i = 0;i<plays.length;i++){
		//dates[i] = dates[i].substring(20,dates[i].length());
		plays[i] = plays[i].substring(23,plays[i].length());
		plays[i] = plays[i].substring(0,plays[i].length()-40);
		ply = (int[])append(ply,parseInt(plays[i].split(" ")[1]));
	}

	//println(ply);


}

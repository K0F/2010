import processing.pdf.*;
PGraphicsPDF pdf ;
PFont font;

String outFont = "Liberation";
int fontHeight = 12;

void setup(){

	size(600,800,P2D);

	println(PFont.list());
	BeginSavePDF("/desk/");


}

void draw(){

	background(0);
	fill(0);
	
	int cnt = 0;
	
	fill(200);
	
	for(int i = 0 ;i<height;i+=fontHeight){
		

		
		fontHeight = (int)random(9,90);
		font = createFont(outFont, fontHeight ,true);//("Arial",10,true);
		pdf.textMode(SHAPE);// = SHAPE;
		pdf.textFont(font);


		text(i+" = "+outFont,10,i+fontHeight);
		
		cnt++;

	}
	EndSavePDF();
	exit();

}


void BeginSavePDF(String _path)
{
	String path = _path+"";//"/desk/pdfOut/";

font = createFont(outFont, fontHeight ,true);//("Arial",10,true);
	textFont(font);
	textMode(SCREEN);
	pdf = (PGraphicsPDF) createGraphics(width ,height, PDF, path + outFont + ".pdf");
	beginRecord(pdf);
	
	pdf.textMode(SHAPE);// = SHAPE;
	pdf.textFont(font);


}
void EndSavePDF()
{
	endRecord();
	println("exporting pdf..");
}

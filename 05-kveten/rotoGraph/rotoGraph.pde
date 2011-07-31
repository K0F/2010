import com.twitter.processing.*;


// this stores how many tweets we've gotten
int tweets = 0;
// and this stores the text of the last tweet
String tweetText = "";

int y = 0;
boolean hasNew = false;
int no = 0;

float cnt = 0;
float scal = 0.1;
float lay = 500;
float theta = 0;

import processing.pdf.*;

ArrayList data = new ArrayList(0);

boolean grabbing = false;
boolean rec = false;


void setup(){
	size(1200,1200,P2D);

	background(0);

	TweetStream s = new TweetStream(this, "stream.twitter.com", 80, "1/statuses/sample.json", "rbotara", "cigaro");
	s.go();

	//
	smooth();
	stroke(0,50);
	fill(255,40);

	data.add("start!");

	textFont(createFont("Arial",9,true));
	//textMode(SCREEN);
	//
	hint(ENABLE_NATIVE_FONTS);
}

void draw() {

	if(rec){
		beginRecord(PDF, "/desk/wtf.pdf");
		textFont(createFont("Arial",9,true));
	}

	background(0);
	
	noStroke();

	for(int i =0;i<data.size();i++){
		fill(noise(i)*255,noise(i/2)*255,0,80);
		pushMatrix();
		translate(width/2,height/2);
		rotate(radians(map(i,0,data.size(),0,360)));
		text((String)data.get(i),i/3.0,0);
		popMatrix();
	}

	if(rec){
		endRecord();
		rec = false;
	}
}

// called by twitter stream whenever a new tweet comes in
void tweet(Status tweet) {
	// print a message to the console just for giggles if you like
	// println("got tweet " + tweet.id());

	// store the latest tweet text


	//if(!tweet.text().equals("\n")){
	String tmp = tweet.text().replaceAll("\n","");
	//tmp = ""+tmp.replaceAll("\n"," ");


	/*
	if(tmp.lastIndexOf("love")>-1){
		no = tmp.lastIndexOf("love");
}else if(tmp.lastIndexOf("LOVE")>-1){
		no = tmp.lastIndexOf("LOVE");
}else if(tmp.lastIndexOf("Love")>-1){
		no = tmp.lastIndexOf("Love");
}else{
		no = -1;
}*/


	if(grabbing){
		y += 10;
		hasNew = true;
		tweetText = tmp;
		// bump our tweet count by one
		tweets += 1;
		data.add(tweetText);
		//}
	}

}

void keyPressed(){
	if(key==' '){
		grabbing = !grabbing;
		println("grabbin "+grabbing);
	}else if(keyCode==ENTER){
		rec = true;
	}
}

/*

void draw(){


	for(float i = 0 ; i<360 ; i +=0.3){

		pushMatrix();
		theta += 0.1;

		cnt += scal;

		translate(width/2,height/2);
		rotate(radians(i));
		stroke(((noise(cnt*3.0)*255)>188)?color(255,0,0):0,200);
		line(lay,0,lay-25,0);



		
		if((noise(cnt*3.0)*255)>188){
			fill(255,0,0);
			text((char)(int)random(255),lay,-5);
			stroke(#ffcc00,100);
			noFill();
			beginShape();
			vertex(lay, 0);
			bezierVertex(lay, 0, 80, lay, 20, 0);
			endShape();

		}

		popMatrix();
		noFill();
		//ellipse(0,0,noise(cnt)*600*2,noise(cnt)*600*2);

		//	fill(random(120),random(100),0,random(255));
		//text((char)((int)(random(48,150))),noise(cnt)*600,0);






		//translate(150,150);

		//translate(-150,-150);

	}


	lay -= 30;

	if(lay<=30){

		endRecord();
		exit();
	}

}

*/

import com.twitter.processing.*;

// this stores how many tweets we've gotten
int tweets = 0;
// and this stores the text of the last tweet
String tweetText = "";

int y = 0;
boolean hasNew = false;
int no = 0;

void setup() {
	size(1024,1200,P2D);
	// set up fonts
	PFont font = createFont("Veranda",9,false);
	textFont(font, 9);
	textMode(SCREEN);
	// set up twitter stream object
	TweetStream s = new TweetStream(this, "stream.twitter.com", 80, "1/statuses/sample.json", "rbotara", "cigaro");
	s.go();

	fill(255);
	hint(ENABLE_NATIVE_FONTS);
	background(0);
}

void draw() {
	if(y>height){
		y = 0;
		background(0);
	}

	if(hasNew&&tweetText.length()>no+5&&no>-1){
		fill(255);
		text(tweetText.substring(0,no), 10, 10+ y );
		fill(255,0,0);
		text(tweetText.substring(no,no+2));
		fill(255);
		text(tweetText.substring(no+2,tweetText.length()));
		hasNew = false;
	}
}

// called by twitter stream whenever a new tweet comes in
void tweet(Status tweet) {
	// print a message to the console just for giggles if you like
	// println("got tweet " + tweet.id());

	// store the latest tweet text

	String tmp = tweet.text();

	if(tmp.lastIndexOf("do")>-1){
		no = tmp.lastIndexOf("do");
	}else if(tmp.lastIndexOf("DO")>-1){
		no = tmp.lastIndexOf("DO");
	}else if(tmp.lastIndexOf("Do")>-1){
		no = tmp.lastIndexOf("Do");
	}else{
		no = -1;
	}

	if(no > -1){
		y += 10;
		hasNew = true;
		tweetText = tmp;
		// bump our tweet count by one
		tweets += 1;
	}
}

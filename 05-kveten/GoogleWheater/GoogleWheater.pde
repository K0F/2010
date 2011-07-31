import java.net.*;
import java.io.*;


/*
Authorization: OAuth realm="",
oauth_consumer_key="c1f5add1d34817a6775d10b3f6821268",
oauth_version="1.0",
oauth_signature_method="HMAC-SHA1",
oauth_timestamp="1273015230",
oauth_nonce="033508fdbd7ba9edf2aec63c19f9e7ca",
oauth_token="baf0a5ea862f5d47680ad99c3f9d3336",
oauth_signature="eOfPn9jA4OgN%2B0ZaU6VwARAax%2Fw%3D"


http://vimeo.com/api/rest/v2?method=vimeo.videos.getLikes
*/

String data[];


XMLElement xml;

float temp,humidity;
Wind wind;


void setup(){

	size(200, 200,P2D);

	update();



}

void update(){

	try{
		//URL vimeo = new URL("http://www.wunderground.com/global/CZ.html");
		URL google = new URL("http://www.google.com/ig/api?weather=Prague");
		BufferedReader in = new BufferedReader(
		                            new InputStreamReader(
		                                    google.openStream()));

		data = new String[0];
		String inputLine;

		while ((inputLine = in.readLine()) != null){
			//System.out.println(inputLine);
			data = (String[])append(data,inputLine);
		}

		in.close();

	}catch(Exception e){
		println(e);
	}

	saveStrings("current.xml",data);


	xml = new XMLElement(this, sketchPath+"/current.xml");

	XMLElement root = xml.getChild(0).getChild(1);

	temp = root.getChild(2).getFloatAttribute("data");

	String parse =  root.getChild(3).getStringAttribute("data");
	humidity = parseInt(parse.substring(10,parse.length()-1));

	String w = root.getChild(5).getStringAttribute("data");
	wind = new Wind(w.substring(6,w.length()-4));


	println(temp + " : " + humidity + " : " + wind.strength);

}

void keyPressed(){

	update();
}


void draw(){

	background(0);

	stroke(#ff0000);

	line(0,map(temp,-10,40,height,0),width,map(temp,-10,40,height,0));
	stroke(#ffff00);
	line(0,map(humidity,0,100,height,0),width,map(humidity,0,100,height,0));

	stroke(#0000ff);
	line(0,map(wind.strength,0,50,height,0),width,map(wind.strength,0,50,height,0));



}

class Wind{
	float angle;
	float strength;

	Wind(String s){
		String tmp[] = s.split(" ");
		strength = parseFloat(tmp[2]);
	}
}








class Location{
  XMLElement xml;
  float tempr;
  float hum;

  float temps[] = new float[0];
  float hums[] = new float[0];
  String place;
  
  color c;
  
  PApplet parent;

  Location(String _place,PApplet _parent){
    parent = _parent;
    place = ""+_place;
    c = color(random(100,255),random(100,255),random(100,255));
    update();

  }

  void update(){
    try{
    xml = new XMLElement(parent, "http://www.google.com/ig/api?weather="+place);    
    
    tempr = xml.getChild(0).getChild(1).getChild(2).getFloatAttribute("data");
    String _hum = xml.getChild(0).getChild(1).getChild(3).getStringAttribute("data");
    String _hums[] = splitTokens(_hum," %");
    hum = parseFloat(_hums[1]);

    println(place+" -> "+"temp: "+tempr+"   humidity: "+hum);

    hums = (float[])append(hums,hum);
    temps = (float[])append(temps,tempr);  
    
    }catch(Exception e){
      println("problems during parsing data: "+e); 
    }
  }
  
  void draw(){
   

  float y = map(temps[0], 0,30,height,height/2);
  fill(c);
  text(place,width-40,y);
  noFill();
  
//  for(int q = 1;q<30;q++){
    beginShape(POLYGON);
    vertex(0,y);
    for(int i = 0;i<temps.length;i++){
      y = (map(temps[i], 0,30,height,height/2));// / (q+0.0);
      stroke(c,100);
      curveVertex( map(i,0,temps.length-1,0,width) , y );
    } 
    vertex(width,y);
    endShape();
 // }


  y = map(hums[0], 0,100,height/2,0);
  
  fill(c);
  text(place,width-40,y);
  noFill();
  
//  for(int q = 1;q<30;q++){
    beginShape(POLYGON);
    vertex(0,y);
    for(int i = 0;i<hums.length;i++){
      y = ( map(hums[i], 0,100,height/2,0) );// / (q+0.0);
      stroke(c,100);
      curveVertex( map(i,0,hums.length-1,0,width) , y );
    }
    vertex(width,y);
    endShape();
 // } 
    
  }

}



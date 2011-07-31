import prohtml.*;

HtmlList htmlList;

String dotaz = "http://www.vimeo.com/kof/videos";

HtmlImageFinder finder;


String response;
ArrayList links;
ArrayList imgAdds;
ArrayList imgs;

PFont font;
ArrayList data;
int cr = (int)('\n');

void setup(){
  size(500, 680, P2D);
  background(50);
  fill(200);
  //enter your url here
 
 
   getNew(dotaz);
  
  /*
  finder = new HtmlImageFinder(dotaz);
  int numOfImg = finder.getNumbOfImages();
  
  
  imgAdds = new ArrayList(0);
  imgs = new ArrayList(0);
  for(int i = 0;i<numOfImg;i++){
    imgAdds.add((String)finder.getImageLink(i));
    println((String)finder.getImageLink(i));
    imgs.add(loadImage((String)imgAdds.get(i)));
  }
  
  
  
  
  */
  
  //for(int i = 0;i<links.size();i++){
  //  println(((Url)(links.get(i))).toString());
  //}
  
  font= createFont("Verdana",11);
  textFont(font);
  textMode(SCREEN);
  data = new ArrayList(0);
}

void getNew(String _dotaz){
  htmlList = new HtmlList(dotaz); 
  links = new ArrayList(htmlList.getLinks());
}


int last = 12;
boolean gotit = false;

void draw() {
  background(50);

    
    boolean once = false;
    
  for(int i = 0 ; i< links.size();i++){
    
    if(mouseY>i*11-11&&mouseY<i*11){
     fill(255,0,0); 
    }else{
     fill(255); 
    }
    
    String tmp  = (String)(((Url)(links.get(i))).getUrl());
    text(tmp,0,i*11);
    
    if(mousePressed && !once){
      println(tmp);
      once = true;
      
    }
    
    
  }
  
  
  //println(data.size());
  
}


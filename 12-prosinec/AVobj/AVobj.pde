import krister.Ess.*;

AudioStream myStream;
float[] streamBuffer;

ArrayList av = new ArrayList(0);

void setup()
{
  size(512, 200, P2D);

  Ess.start(this);
 myStream=new AudioStream();
 streamBuffer=new float[myStream.size];
 fillAudioBuffer();
 myStream.start();

  AV tmp = new AV("0.png",0);
  av.add(tmp);
}

void fillAudioBuffer(){

 int freq = 200;
 float a = 0.0; 
 float inc = TWO_PI*(freq/myStream.sampleRate); 
 for(int i=0; i<streamBuffer.length; i++) { 
   streamBuffer[i] = (sin(a)*.33);  
   a = a + inc;    
 } 
}

void audioStreamWrite(AudioStream theStream) {
 System.arraycopy(streamBuffer,0,myStream.buffer,0,streamBuffer.length);
}

public void stop() {
 Ess.stop();
 super.stop();
}


void draw() {
  background(0);

  for(int i = 0;i<av.size();i++) {
    AV tmp  = (AV)av.get(i);
    tmp.draw();
  }
}


void mousePressed(){
 
  for(int i = 0;i<av.size();i++) {
    AV tmp  = (AV)av.get(i);
    tmp.regenerate();
  } 
}





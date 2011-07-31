import ddf.minim.*;
 
Minim minim;
AudioSample jingle;
 
void setup()
{
  size(512, 200, P2D);
 
  minim = new Minim(this);
 
  jingle = minim.loadSample("/home/kof/Music/triosk-moment_returns-2004-rns/03-triosk-love_chariot-rns.mp3", 1024);

  float[] leftChannel = jingle.getChannel(BufferedAudio.LEFT);
 
  float[] reversed = reverse(leftChannel);
  arraycopy(reversed, 0, leftChannel, 0, leftChannel.length);
}
 
void draw()
{
  background(0);
  stroke(255);
  for(int i = 0; i < jingle.bufferSize() - 1; i++)
  {
	  jingle.left.set(i);
    line(map(i,0, jingle.bufferSize(),0,width), 50 - jingle.left.get(i)*50, map(i+1,0, jingle.bufferSize(),0,width), 50 - jingle.left.get(i+1)*50);
    line(map(i,0, jingle.bufferSize(),0,width), 150 - jingle.right.get(i)*50, map(i+1,0, jingle.bufferSize(),0,width), 150 - jingle.right.get(i+1)*50);
  }
}
 
void keyPressed()
{
  jingle.trigger();
}
 
void stop()
{
  jingle.close();
  minim.stop();
 
  super.stop();
}

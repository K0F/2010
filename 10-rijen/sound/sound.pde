import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;
SineWave sine;

void setup()
{
  size(512, 200, P2D);
  
  minim = new Minim(this);
  
  // get a line out from Minim, default sample rate is 44100, default bit depth is 16
  out = minim.getLineOut(Minim.STEREO, 2048);
  
  // create a sine wave Oscillator, set to 440 Hz, at 0.5 amplitude, sample rate 44100 to match the line out
  sine = new SineWave(440, 0.5, out.sampleRate());
  // add the oscillator to the line out
  out.addSignal(sine);
}

void draw()
{
  background(0);
  stroke(255);
  // draw the waveforms
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    line(i, 50 + out.left.get(i)*50, i+1, 50 + out.left.get(i+1)*50);
    line(i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50);
  }
}


void stop()
{
  // always close Minim audio classes when you are done with them
  out.close();
  minim.stop();

  super.stop();
}
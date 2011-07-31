/**
FFTOfflineRendererMinim.pde
June 2009 Dave Bollinger (for Processing 1.0+)
to demonstrate non-real-time fft analysis and rendering
*/

import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import codeanticode.gsvideo.*;

GSMovieMaker mm;

String audioFilename = "LightAHungry.mp3";

static final int RENDER_MODE_REALTIME = 0; // use this when dev'ing your viz
static final int RENDER_MODE_OFFLINE = 1; // use this for final render
int renderMode = RENDER_MODE_OFFLINE; // change this as desired

static final int OUTPUT_TYPE_NONE = 0; // use this when dev'ing
static final int OUTPUT_TYPE_IMAGE = 1; // use this..
static final int OUTPUT_TYPE_MOVIE = 2; // ..or this, for final render
int outputType = OUTPUT_TYPE_IMAGE; // change this as desired

Minim minim;
AudioSample audio;
FFT fft;

int frameNumber = 0;
float [] audioBuffer; // will hold the entire audio file
float [] fftBuffer; // will hold just a portion for fft analysis
// sync math:
float sampleRate; // we'll query the audio file for this later
float framesPerSecond = 30.0;
float samplesPerFrame; // ==sampleRate/framesPerSecond
int fftBufferSize; // total size of the fft buffer
int fftMixSize; // occupied size of the fft buffer
float exactFramesToRender; // exactly how many (fractional) video frames == audio duration
int wholeFramesToRender; // no such thing as a fractional video frame, so round up

void setup() {
  size(320,240,P2D);
  if (renderMode==RENDER_MODE_REALTIME)
    frameRate(framesPerSecond); // won't be perfect sync, but we try our best anyway
  if (outputType==OUTPUT_TYPE_MOVIE)
  mm = new GSMovieMaker(this, width, height, "drawing.ogg", GSMovieMaker.THEORA, GSMovieMaker.MEDIUM, (int)framesPerSecond);
  minim = new Minim(this);
  audio = minim.loadSample(audioFilename);
  if (audio == null) {
    println("oops, failed to load audio file");
    exit();
    return;
  }
  audioBuffer = audio.getChannel(BufferedAudio.LEFT);
  if ((audioBuffer==null) || (audioBuffer.length==0)) {
    println("oops, failed to acquire sample data");
    // try using a mono and/or lower samplerate version
    // to reduce size of file used for analysis
    exit();
    return;
  }
  // calc values
  sampleRate = audio.sampleRate();
  samplesPerFrame = sampleRate / framesPerSecond;
  fftMixSize = (int)ceil(samplesPerFrame);
  if (renderMode == RENDER_MODE_REALTIME) {
    fftBufferSize = audio.bufferSize();
  } else { // offline
    fftBufferSize = nextPowerOfTwo(fftMixSize);
  }
  exactFramesToRender = audioBuffer.length * framesPerSecond / sampleRate;
  wholeFramesToRender = (int)ceil(exactFramesToRender);
  fft = new FFT(fftBufferSize, sampleRate);
  fftBuffer = new float[fftBufferSize];
  if (renderMode == RENDER_MODE_REALTIME) {
    audio.trigger();
  }
  // report values:
  println("INFO:");
  println("audio length = " + audioBuffer.length);
  println("sampleRate = " + sampleRate);
  println("audio duration = " + sec2hms(audioBuffer.length/sampleRate));
  println("framesPerSecond = " + framesPerSecond);
  println("samplesPerFrame = " + samplesPerFrame);
  println("fftMixSize = " + fftMixSize);
  println("fftBufferSize = " + fftBufferSize);
  println("exactFramesToRender = " + exactFramesToRender);
  println("wholeFramesToRender = " + wholeFramesToRender);
  println("video duration = " + sec2hms(wholeFramesToRender/framesPerSecond));
  println("-----");
}

String sec2hms(float seconds) {
  int hours = (int)floor(seconds / 3600.0);
  seconds -= (float)(hours * 3600);
  int minutes = (int)floor(seconds / 60.0);
  seconds -= (float)(minutes * 60);
  return hours + ":" + minutes + ":" + seconds;
}

int nextPowerOfTwo(int target) {
  int powtwo = 1;
  while (powtwo < target) powtwo<<=1;
  return powtwo;
}

public void stop() {
  println("stop()");
  if (mm != null) mm.finish();
  if (audio != null) audio.close();
  if (minim != null)  minim.stop();
  super.stop();
}

void draw() {
  if (finished()) {
    exit();
  } else {
    progress();
    analyze();
    render();
    store();
    advance();
  }
}

boolean finished() {
  // this only works properly when offline rendering
  // (unfortunately AudioSample doesn't indicate when done playing realtime)
  return (frameNumber >= wholeFramesToRender);
}

void progress() {
  if ((frameNumber%100) == 0) {
    println("Working on frame " + frameNumber + " of " + wholeFramesToRender);
  }
}

void analyze() {
  switch(renderMode) {
    case RENDER_MODE_REALTIME:
      analyzeRealtime();
      break;
    case RENDER_MODE_OFFLINE:
      analyzeOffline();
      break;
  }
}

void analyzeRealtime() {
  fft.forward(audio.mix);
}

void analyzeOffline() {
  int pos = (int)(frameNumber * sampleRate / framesPerSecond);
  if (pos >= audioBuffer.length) {
    // hmm, finished() should've caught this, why are we here?
    exit();
    return;
  }
  int mixlen = fftMixSize;
  // handle last partial frame
  if (pos+mixlen >= audioBuffer.length) {
    mixlen = audioBuffer.length - pos;
  }
  arraycopy(audioBuffer, pos, fftBuffer, 0, mixlen);
  // zero remainder (really only need to zero up to fftMixSize, 
  // since rest is never used, but we do the whole thing jic...)
  for (int i=mixlen; i<fftBufferSize; i++)
    fftBuffer[i] = 0f;
  fft.forward(fftBuffer);
}

void render() {
  background(0);
  stroke(255);
  for (int i = 0; i < fft.specSize(); i++) {
    line(i, height, i, height - fft.getBand(i) * 4);
  }
}

void store() {
  switch(outputType) {
    case OUTPUT_TYPE_NONE :
      break;
    case OUTPUT_TYPE_IMAGE :
      saveFrame("out/frame_"+nf(frameNumber,6)+".png"); // or jpg, tif, etc.
      break;
    case OUTPUT_TYPE_MOVIE :
       loadPixels();
        // Add window's pixels to movie
      mm.addFrame(pixels);
      break;
  }
}

void advance() {
  frameNumber++;
}


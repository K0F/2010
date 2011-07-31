import guru.ttslib.*;

TTS tts;

void setup() {
  tts = new TTS();
}

void draw() {
	background(0);
}

void mousePressed() {
  tts.speak("Hi! I am a speaking Processing sketch");
}


PImage monsieur,monsieurFiltered;

float xmin = -1.5;
float ymin = -2.5;
float wh = 40;
float ZOOM = -0.2;

void setup() {
	size(320, 320, P2D);
	monsieur = loadImage("mb.png");
	//PImage msk = mb;
	monsieurFiltered = monsieur;
	monsieurFiltered.filter(THRESHOLD,0.7);
	//mb.mask(mb);
	loadPixels();
}

void draw() {
	
	
	
	tint(-1);
	image(g,0,0.1);
	
	

	wh = 8;

	xmin = map(height/3*2,0,height,0,-wh);
	ymin = map(width/2,0,width,0,-wh);

	float mod1 = noise(frameCount/50.0)+0.001;
	float mod2 = noise(232+frameCount/353.0)+0.001;
	float mod3 = noise(12323+frameCount/355.0)+0.001;
	float mod4 = noise(-10239+frameCount/30.0)+0.001;
	
	
	
	
	
	//noTint();
	tint(255,60);
	pushMatrix();
	//scale(mod1*mod2*mod3*mod4);
	image(monsieurFiltered,mod1*500*ZOOM,mod1*500*ZOOM,width-mod1*1000*ZOOM,height-mod1*1000*ZOOM);

	popMatrix();
	int maxiterations = 20;

	float xmax = xmin + wh;
	float ymax = ymin + wh;

	float dx = (xmax - xmin) / (width);
	float dy = (ymax - ymin) / (height);

	// Start y
	float y = ymin;
	for (int j = 0; j < height; j++) {
		// Start x
		float x = xmin;
		for (int i = 0;  i < width; i++) {

			float a = x;
			float b = y;
			int n = 0;
			while (n < maxiterations) {
				float aa = a * a * mod3;
				float bb = b * b * mod2;
				float twoab = 2.0 * a * b * mod1;
				a = aa - bb + x * mod2;
				b = twoab + y * mod4;
				if(aa + bb > 16) {
					break;  
				}
				n++;
			}

			if (n == maxiterations) {
				//pixels[j+i*width] = color(255);
				
			} else {
				pixels[j+i*width] = lerpColor(color(n*10 % 255),pixels[j+i*width],0.12);
			}
			x += dx;
		}
		y += dy;
	}
	updatePixels();
	

}


color colRed = #FF0000;
color colBlue = #0000FF;
color colYellow = #FFFF00;
color colWhite = #FFFFFF;
color colBlack = #000000;

void drawAlpha(float x, float y, float w, float h) {
  //base
  fill(colBlue);
  rect(x, y, w, h);
  //details
  fill(colWhite);
  rect(x, y, w*0.5, h);
  triangle(x+w*0.75, y+h/2, x+w, y+h, x+w, y);
}

void drawBravo(float x, float y, float w, float h) {
  //base
  fill(colRed);
  rect(x, y, w, h);
  //detail
  fill(colWhite);
  triangle(x+w*0.75, y+h/2, x+w, y+h, x+w, y);
}

void drawCharlie(float x, float y, float w, float h) {
  //base
  fill(colBlue);
  rect(x, y, w, h);
  //detail
  fill(colWhite);
  rect(x, y+h/5, w, 3*h/5);
  fill(colRed);
  rect(x, y+2*h/5, w, h/5);
}

void drawDelta(float x, float y, float w, float h) {
  //base
  fill(colYellow);
  rect(x, y, w, h);
  //detail
  fill(colBlue);
  rect(x, y+h/5, w, 3*h/5);
}

void drawEcho(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colRed);
  rect(x, y+h/2, w, h/2);
}

void drawFoxtrot(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colRed);
  beginShape();
    vertex(x, y+h/2);
    vertex(x+w/2, y+h);
    vertex(x+w, y+h/2);
    vertex(x+w/2, y);
  endShape(CLOSE);
}

void drawGolf(float x, float y, float w, float h) {
  //base
  fill(colYellow);
  rect(x, y, w, h);
  //detail
  fill(colBlue);
  rect(x+1*w/6, y, w/6, h);
  rect(x+3*w/6, y, w/6, h);
  rect(x+5*w/6, y, w/6, h);
}

void drawHotel(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colRed);
  rect(x+w/2, y, w/2, h);
}

void drawIndia(float x, float y, float w, float h) {
  //base
  fill(colYellow);
  rect(x, y, w, h);
  //detail
  fill(colBlack);
  ellipse(x+w/2, y+h/2, w/2, h/2);
}

void drawJuliet(float x, float y, float w, float h) {
  //base
  fill(colBlue);
  rect(x, y, w, h);
  //detail
  fill(colWhite);
  rect(x, y+h/3, w, h/3);
}

void drawKilo(float x, float y, float w, float h) {
  //base
  fill(colYellow);
  rect(x, y, w, h);
  //detail
  fill(colBlue);
  rect(x+w/2, y, w/2, h);
}

void drawLima(float x, float y, float w, float h) {
  //base
  fill(colYellow);
  rect(x, y, w, h);
  //detail
  fill(colBlack);
  rect(x+w/2, y, w/2, h/2);
  rect(x, y+h/2, w/2, h/2);
}

void drawMike(float x, float y, float w, float h) {
  //base
  fill(colBlue);
  rect(x, y, w, h);
  //detail
  fill(colWhite);
  beginShape();
    vertex(x, y);
    vertex(x, y+1*h/8);
    vertex(x+7*w/8, y+h);
    vertex(x+w, y+h);
    vertex(x+w, y+7*h/8);
    vertex(x+1*w/8, y);
  endShape(CLOSE);
  beginShape();
    vertex(x, y+h);
    vertex(x+1*w/8, y+h);
    vertex(x+w, y+1*h/8);
    vertex(x+w, y);
    vertex(x+7*w/8, y);
    vertex(x, y+7*h/8);
  endShape(CLOSE);
}

void drawNovember(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colBlue);
  rect(x, y, w/4, h/4);
  rect(x, y+h/2, w/4, h/4);
  rect(x+w/2, y, w/4, h/4);
  rect(x+w/2, y+h/2, w/4, h/4);
  rect(x+w/4, y+h/4, w/4, h/4);
  rect(x+w/4, y+3*h/4, w/4, h/4);
  rect(x+3*w/4, y+h/4, w/4, h/4);
  rect(x+3*w/4, y+3*h/4, w/4, h/4);
}

void drawOscar(float x, float y, float w, float h) {
  //base
  fill(colRed);
  rect(x, y, w, h);
  //detail
  fill(colYellow);
  triangle(x, y, x, y+h, x+w, y+h);
}

void drawPapa(float x, float y, float w, float h) {
  //base
  fill(colBlue);
  rect(x, y, w, h);
  //detail
  fill(colWhite);
  rect(x+w/3, y+h/3, w/3, h/3);
}

void drawQuebec(float x, float y, float w, float h) {
  //base
  fill(colYellow);
  rect(x, y, w, h);
}

void drawRomeo(float x, float y, float w, float h) {
  //base
  fill(colRed);
  rect(x, y, w, h);
  //detail
  fill(colYellow);
  rect(x+2*w/5, y, w/5, h);
  rect(x, y+2*h/5, w, h/5);
}

void drawSierra(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colBlue);
  rect(x+w/3, y+h/3, w/3, h/3);
}

void drawTango(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colRed);
  rect(x, y, w/3, h);
  fill(colBlue);
  rect(x+2*w/3, y, w/3, h);
}

void drawUniform(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colRed);
  rect(x, y, w/2, h/2);
  rect(x+w/2, y+h/2, w/2, h/2);
}

void drawVictor(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colRed);
  beginShape();
    vertex(x, y);
    vertex(x, y+1*h/8);
    vertex(x+7*w/8, y+h);
    vertex(x+w, y+h);
    vertex(x+w, y+7*h/8);
    vertex(x+1*w/8, y);
  endShape(CLOSE);
  beginShape();
    vertex(x, y+h);
    vertex(x+1*w/8, y+h);
    vertex(x+w, y+1*h/8);
    vertex(x+w, y);
    vertex(x+7*w/8, y);
    vertex(x, y+7*h/8);
  endShape(CLOSE);
}

void drawWhiskey(float x, float y, float w, float h) {
  //base
  fill(colBlue);
  rect(x, y, w, h);
  //detail
  fill(colWhite);
  rect(x+w/5, y+h/5, 3*w/5, 3*h/5);
  fill(colRed);
  rect(x+2*w/5, y+2*h/5, w/5, h/5);
}

void drawXray(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colBlue);
  rect(x+2*w/5, y, w/5, h);
  rect(x, y+2*h/5, w, h/5);
}
void drawYankee(float x, float y, float w, float h) {
  //base
  fill(colYellow);
  rect(x, y, w, h);
  //details
  fill(colRed);
  beginShape();
    vertex(x, y+1*h/5);
    vertex(x, y+2*h/5);
    vertex(x+2*w/5, y);
    vertex(x+1*w/5, y);
  endShape(CLOSE);
  beginShape();
    vertex(x, y+3*h/5);
    vertex(x, y+4*h/5);
    vertex(x+4*w/5, y);
    vertex(x+3*w/5, y);
  endShape(CLOSE);
  beginShape();
    vertex(x, y+h);
    vertex(x+1*w/5, y+h);
    vertex(x+w, y+1*h/5);
    vertex(x+w, y);
  endShape(CLOSE);
  beginShape();
    vertex(x+2*w/5, y+h);
    vertex(x+3*w/5, y+h);
    vertex(x+w, y+3*h/5);
    vertex(x+w, y+2*h/5);
  endShape(CLOSE);
  beginShape();
    vertex(x+4*w/5, y+h);
    vertex(x+w, y+h);
    vertex(x+w, y+4*h/5);
  endShape(CLOSE);
}

void drawZulu(float x, float y, float w, float h) {
  //base
  fill(colBlue);
  rect(x, y, w, h);
  //detail
  fill(colBlack);
  triangle(x, y, x, y+h, x+w/2, y+h/2);
  fill(colYellow);
  triangle(x, y, x+w/2, y+h/2, x+w, y);
  fill(colRed);
  triangle(x, y+h, x+w, y+h, x+w/2, y+h/2);
}

void drawSpace(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
}

void drawPeriod(float x, float y, float w, float h) {
  //base
  fill(colBlack);
  rect(x, y, w, h);
}

void drawComma(float x, float y, float w, float h) {
  //base
  fill(colBlack);
  rect(x, y, w, h);
  //detail
  fill(colWhite);
  rect(x, y+h/2, w/4, h/2);
}

void drawApos(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colBlack);
  rect(x+w/2, y, w/8, h/4);
}

void drawQuote(float x, float y, float w, float h) {
  //base
  fill(colWhite);
  rect(x, y, w, h);
  //detail
  fill(colBlack);
  rect(x, y, w/8, h/4);
  rect(x+w/2, y, w/8, h/4);
}

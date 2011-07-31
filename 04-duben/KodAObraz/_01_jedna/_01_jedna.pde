// Sktript Jedna
// Obraz a kod 2010

// velikost okna s parametry (x,  y) v poctu pixelu
size(320,240);

// promenna ''barva" definovana prikazem "color(cervena,zelena,modra);" min 0 .. 255 max
color barvaPozadi = color(255,0,0);

// pozadi background(color) vyplni plochu jednou barvou
background(barvaPozadi);

// nastaveni vyplne fill s parametry (cervena,zelena,modra,[pruhlednost])
// pro zadnou vypln prikaz noFill();
fill(0,0,0);

// stejne tak prikaz stroke(cervena,zelena,modra,[pruhlednost]);
// zadna kontura noStroke();
noStroke();

// rect mode znaci mod kresleni obdelniku CENTER znamena ze
// prvni dve promenne x a y budou na stredu obelniku
rectMode(CENTER);

// obdelnik rect(pozice x,pozice y, sirka, vyska);
// width je promenna ktera zjisti sirku okna, height je promenna ktera zjisti vysku
rect(width/2, height/2, 90, 60);

// zde program konci



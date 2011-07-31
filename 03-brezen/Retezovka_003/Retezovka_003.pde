/**
 *	Retezovka Script
 *	by Jachym & Krystof PESEK
 *	2010
 */

Camera camer;

ArrayList collRetez;
Retez currentRetez = new Retez();


int whichSelected = -1;


Plane pln;



void setup()
{
	size(1200,800,P3D);
	//	hint(DISABLE_OPENGL_2X_SMOOTH);
	noSmooth();

	camer = new Camera();

	// vytvoreni pole pro ukladani retzu (collRetez) a prida currentRetez jakozto novy urceny pro vsechny operace
	initRetez();

	// konstrukcni rovina
	pln = new Plane(0,0,0);
	pln.displaySize = 200;
	pln.numOfGrid = 20;

}

void initRetez(){
	collRetez = new ArrayList();
	currentRetez = new Retez();
	//collRetez.add(currentRetez);
}

void draw()
{
	background(0);

	//vypocet polohy
	for(int i = 0; i<collRetez.size(); i++)
	{
		Retez rView = (Retez) collRetez.get(i);
		rView.Calculate();
	}

	// pocatek kresleni
	camer.preDraw();

	//retezy draw
	for(int i = 0; i<collRetez.size();i++)
	{
		Retez rView = (Retez) collRetez.get(i);
		rView.Draw();
	}

	//plane draw
	pln.Draw();

	//konec kresleni
	camer.postDraw();

}


void pridejRetez(){

	if(someSelected())
	{
		// prida bod linkly na rodice
		Retez tmp = (Retez) collRetez.get(whichSelected);
		currentRetez.pridej(tmp);
	}
	else
	{
		//prida body
		currentRetez.pridej(new Point(model[0],model[1],model[2]));
	}

}

boolean someSelected(){
	boolean answr = false;
	for(int i = 0 ;i<collRetez.size();i++){
		Retez tmp = (Retez) collRetez.get(i);
		if(tmp.selected)
		{
			whichSelected = i;
			answr = true;
			break;
		}
	}
	
	return answr;

}



























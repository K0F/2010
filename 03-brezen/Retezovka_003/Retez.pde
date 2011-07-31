float gravity = 1;
float hustutaProstredi = 1.2;

class Retez
{

	RetezClanek[] pt = new RetezClanek[0];
	Point ptStart, ptEnd, ptControl;
	int segmentCount;
	float rozpon;
	boolean[] inserted = new boolean[2];
	boolean selected, preConstructLine;
	int overId = -1;

	Retez rodice[] = new Retez[2];

	// ma alespon nejakeho rodice (varianta rodic + fix bod)
	boolean hasRodic = false;
	// ma dva rodice
	boolean hasRodice = false;
	RetezClanek[] rodicePt = new RetezClanek[2];
	int rodicPtId[] = new int[2];


	Retez()
	{
		segmentCount = 30;
		pt = new RetezClanek[segmentCount];

		inserted[0] = false;
		inserted[1] = false;
		selected = false;
		preConstructLine = false;


	}

	void pridej(Point bod)
	{

		if(inserted[0] == false)
		{
			inserted[0] = true;
			preConstructLine = true;
			ptStart = bod;

			collRetez.add(currentRetez);
		}
		else
		{
			inserted[1] = true;
			preConstructLine = false;
			ptEnd = bod ;
			ptControl = new Point((ptEnd.x+ptStart.x)/2, (ptEnd.y+ptStart.y)/2, (ptEnd.z+ptStart.z)+ptStart.z+100);
			rozpon = ptStart.DistanceTo(ptEnd);

			for(int i = 0; i < segmentCount; i++)
			{
				pt[i] = new RetezClanek( new Point( (ptEnd.x-ptStart.x)/(segmentCount-1)*i+ptStart.x,
				                                    (ptEnd.y-ptStart.y)/(segmentCount-1)*i+ptStart.y,
				                                    (ptEnd.z-ptStart.z)/(segmentCount-1)*i+ptStart.z));
				pt[i].Mass(1,1,1,1);
			}

			pt[0].fixed = true;
			pt[segmentCount-1].fixed = true;


			collRetez.add(currentRetez);
			currentRetez = new Retez();
		}
	}


	// prichyceni na druhy retez
	void pridej(Retez _parent)
	{

		if(inserted[0] == false)
		{
			//zpaise si prvni retez
			rodice[0] = _parent;

			// uskladni aktualni oznaceny bod rodice ..fuj!
			rodicePt[0] = rodice[0].pt[ rodice[0].overId ];



			inserted[0] = true;
			preConstructLine = true;
			ptStart = rodicePt[0].origin;

			//collRetez.add(currentRetez);
		}
		else
		{
			rodice[1] = _parent;
			// uskladni aktualni oznaceny bod rodice ..fuj!
			rodicePt[1] = rodice[1].pt[ rodice[1].overId ];

			inserted[1] = true;
			preConstructLine = false;
			ptEnd = rodicePt[1].origin;

			ptControl = new Point((ptEnd.x+ptStart.x)/2, (ptEnd.y+ptStart.y)/2, (ptEnd.z+ptStart.z)+ptStart.z+100);
			rozpon = ptStart.DistanceTo(ptEnd);

			for(int i = 0; i < segmentCount; i++)
			{
				pt[i] = new RetezClanek( new Point( (ptEnd.x-ptStart.x)/(segmentCount-1)*i+ptStart.x,
				                                    (ptEnd.y-ptStart.y)/(segmentCount-1)*i+ptStart.y,
				                                    (ptEnd.z-ptStart.z)/(segmentCount-1)*i+ptStart.z));
				pt[i].Mass(1,1,1,1);
			}

			//pt[0].fixed = true;
			//pt[segmentCount-1].fixed = true;


			collRetez.add(currentRetez);
			currentRetez = new Retez();
		}
	}

	boolean[] maRodice()
	{
		boolean one = (rodice[0]==null)?false:true;
		boolean two =  (rodice[1]==null)?false:true;
		boolean answr[] = {one,two};
		return answr;
	}

	void Calculate()
	{
		if(inserted[1] == true)
		{
			//kalkulace trech moznych variant maRodice()[true,false]
			preCalc();

		}
	}

	void preCalc()
	{
		//has no
		if(!maRodice()[0]&&!maRodice()[1])
		{
			for(int i = 0; i < pt.length ; i++)
			{
				if(i>0) pt[i].SousedOne(pt[i-1].origin);
				if(i < pt.length-1) pt[i].SousedTwo(pt[i+1].origin);

				if(i==0) pt[i].SousedOne(null);
				if(i==pt.length) pt[i].SousedTwo(null);

			}
			pt[10].SousedOther(new Point(0,0,0));

			for(int i = 0; i < pt.length ; i++)
			{
				pt[i].Move();
			}
		}
		else if(maRodice()[0] && !maRodice()[1])
		{
			for(int i = 1; i < pt.length ; i++)
			{
				if(i>0) pt[i].SousedOne(pt[i-1].origin);
				if(i < pt.length-1) pt[i].SousedTwo(pt[i+1].origin);

				if(i==0) pt[i].SousedOne(null);
				if(i==pt.length) pt[i].SousedTwo(null);

			}
			pt[10].SousedOther(new Point(0,0,0));

			for(int i = 1; i < pt.length ; i++)
			{
				pt[i].Move();
			}

			pt[0] = rodicePt[0];
			ptStart = rodicePt[0].origin;

		}else if(!maRodice()[0] && maRodice()[1])
		{
			for(int i = 0; i < pt.length-1 ; i++)
			{
				if(i>0) pt[i].SousedOne(pt[i-1].origin);
				if(i < pt.length-1) pt[i].SousedTwo(pt[i+1].origin);

				if(i==0) pt[i].SousedOne(null);
				if(i==pt.length) pt[i].SousedTwo(null);

			}
			pt[10].SousedOther(new Point(0,0,0));

			for(int i = 0; i < pt.length-1 ; i++)
			{
				pt[i].Move();
			}

			pt[pt.length-1] = rodicePt[0];
			ptStart = rodicePt[0].origin;

		}else if(maRodice()[0] && maRodice()[1])
		{
			for(int i = 1; i < pt.length-1 ; i++)
			{
				if(i>0) pt[i].SousedOne(pt[i-1].origin);
				if(i < pt.length-1) pt[i].SousedTwo(pt[i+1].origin);

				if(i==0) pt[i].SousedOne(null);
				if(i==pt.length) pt[i].SousedTwo(null);

			}
			pt[10].SousedOther(new Point(0,0,0));

			for(int i = 1; i < pt.length-1 ; i++)
			{
				pt[i].Move();
			}
			pt[0] = rodicePt[0];
			ptStart = rodicePt[0].origin;
			pt[pt.length-1] = rodicePt[1];
			ptStart = rodicePt[0].origin;

		}
	}



	void Draw()
	{
		// plati pokud byl jiz zadan prvni bod
		if(inserted[0] == true)
		{
			// ptStart.Draw();
			if(preConstructLine)
			{

			}
		}

		// plati pokud byli zadany oba kotevni body
		if (inserted[1] == true)
		{
			// ptControl.Draw();

			//retez selection
			selected = retezOver();

			//jestlize oznacen
			if(selected)
			{
				stroke(239,230,30);
				pushMatrix();
				translate(pt[overId].origin.x,pt[overId].origin.y,pt[overId].origin.z);
				box(5);
				popMatrix();
			}
			else
			{
				stroke(220);

			}

			for(int i = 1; i < pt.length ; i++)
			{
				//pt[i].origin.Draw();
				line(pt[i].origin.x,pt[i].origin.y,pt[i].origin.z, pt[i-1].origin.x,pt[i-1].origin.y,pt[i-1].origin.z);
			}

			stroke(255,0,0);
			ptStart.Draw();
			ptEnd.Draw();

			//line(ptStart.x, ptStart.y, ptStart.z, ptEnd.x, ptEnd.y, ptEnd.z);


			//stroke(239,230,30);

		}

	}

	boolean retezOver(){
		boolean tmp = false;

		for(int i = 0;i<pt.length;i++)
		{
			if(pt[i].over())
			{
				overId = i;
				tmp = true;
				break;

			}
		}
		return tmp;

	}




}

class RetezClanek
{
	Point origin;
	Vector vecOne, vecTwo, vecOther, vecGrav;
	boolean fixed;
	float tension, mass;
	int scx,scy;

	// arrays hold the vertices of 3d object
	float[] vertices3D = new float[0];
	int[] vertices2D = new int[0];


	RetezClanek(Point origin)
	{
		this.origin = origin;
		this.tension = 0.3;// tension/100;
		mass = 1;
		vecGrav = new Vector(0,0,-mass*gravity);
	}

	void Mass(float a, float b, float h, float ro)
	{
		mass = a*b*h*ro;
		vecGrav = new Vector(0,0,-mass*gravity);
	}


	void SousedOne(Point sousedOne)
	{
		if(sousedOne == null)
		{
			vecOne = null;
		}
		else
		{
			vecOne = new Vector(origin,sousedOne);
			vecOne.Unitize();
			vecOne.MultipleBy(origin.DistanceTo(sousedOne)*tension);

		}
	}

	void SousedTwo(Point sousedTwo)
	{
		if(sousedTwo == null)
		{
			vecTwo = null;
		}
		else
		{
			vecTwo = new Vector(origin,sousedTwo);
			vecTwo.Unitize();
			vecTwo.MultipleBy(origin.DistanceTo(sousedTwo)*tension);

		}
	}

	void SousedOther(Point sousedOther)
	{
		if(sousedOther == null)
		{
			vecOther = null;
		}
		else
		{
			vecOther = new Vector(origin,sousedOther);
			vecOther.Unitize();
			vecOther.MultipleBy(origin.DistanceTo(sousedOther)*tension);
		}
	}

	void Move()
	{
		//prepocita gravitaci
		vecGrav = new Vector(0,0,-mass*gravity);

		if(fixed == false)
		{
			Vector dir = new Vector(0,0,0);

			dir.Plus(vecGrav);

			if(vecOne != null) dir.Plus(vecOne);
			if(vecTwo != null) dir.Plus(vecTwo);
			if(vecOther != null) dir.Plus(vecOther);

			dir.MultipleBy(1/hustutaProstredi);

			origin.Plus(dir);
		}
	}

	boolean over()
	{
		// mouse hit detection using screnX, screenY
		scx = int(screenX(origin.x, origin.y, origin.z));
		scy = int(screenY(origin.x, origin.y, origin.z));;

		if (scx > mouseX-7 && scx < mouseX+7 && scy > mouseY-7 && scy < mouseY+7)
		{
			return true;

		}
		else
		{
			return false;
		}

	}


}









































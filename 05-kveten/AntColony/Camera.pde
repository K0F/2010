float scrn[] = {
                       0, 0, 0};
float model[] = new float[3];

// translation
float rotX, rotY;
float panX, panY;
float ZOOM;

class Camera
{
	PGraphics3D p3d;
	PMatrix3D mat = new PMatrix3D();
	PMatrix3D proj = new PMatrix3D();
	PMatrix3D camMatrix = new PMatrix3D();
	PMatrix3D modvw = new PMatrix3D();
	PMatrix3D modvwInv = new PMatrix3D();
	PMatrix3D screen2Model = new PMatrix3D();

	Vector xAxis, yAxis, zAxis;
	Plane cPLN;
	boolean transWorld;

	float ZOOM2 = 10;

	Camera()
	{
		addMouseWheelListener(
		        new java.awt.event.MouseWheelListener()
		        {
			        public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt)
			        {
				        int notches = evt.getWheelRotation();
				        if(notches!=0)
				        {
					        ZOOM2+=notches*2.5;
				        }
			        }
		        }
		);

		p3d = (PGraphics3D)g;
		p3d.getMatrix(mat);


		xAxis = new Vector(1,0,0);
		yAxis = new Vector(0,1,0);
		zAxis = new Vector(0,0,1);


		// konstrukcni rovina
		cPLN = new Plane(0,0,0);
		cPLN.displaySize = 100;
		cPLN.numOfGrid = 4;
	}


	void preDraw()
	{
		ZOOM += (ZOOM2*70-ZOOM)/10.0;

		pushMatrix();

		//apply mouse rotation and translation to center of screen
		translations();
		getMatrices();
		applyMatrices();

		if(!rec)
			cPLN.Draw();
	}

	void translations()
	{

		translate((panX+width/2)*1, (panY+height/2)*1,-ZOOM);
		transWorld = true;

		if(!rec){
			rotateX(-rotX);
			rotateZ(rotY);
		}
		//mouse rotate
		//   rotateX(-rotX);
		//    rotateZ(rotY);
	}

	void getMatrices()
	{
		p3d.getMatrix(mat);

		// otoceni yAxis podle standartu
		mat.m10 = -mat.m10;
		mat.m11 = -mat.m11;
		mat.m12 = -mat.m12;
		// mat.m03 = panX+width/2;
		//              mat.m13 =panY+height/2;
		p3d.setMatrix(mat);

		//get 3d matrices
		proj = p3d.projection.get();

		camMatrix = p3d.camera.get();
		modvw = p3d.modelview.get();
		modvwInv = p3d.modelviewInv.get();

		xAxis = new Vector(mat.m00,mat.m01,mat.m02);
		yAxis = new Vector(mat.m10,mat.m11,mat.m12);
		zAxis = new Vector(mat.m20,mat.m21,mat.m22);
	}

	void applyMatrices()
	{
		screen2Model.mult(scrn, model);
		screen2Model =  modvwInv;
		screen2Model.apply(camMatrix);
	}

	void postDraw()
	{
		popMatrix();
		transWorld = false;
	}



	Point GetCamera()
	{
		//   PMatrix3D mat = new PMatrix3D();
		//    p3d.getMatrix(mat);

		//   if (! transWorld) preDraw();

		Vector vX = xAxis;
		Vector vY = yAxis;
		Vector vZ = zAxis;

		vX.MultipleBy(-mat.m03);
		vY.MultipleBy(-mat.m13);
		vZ.MultipleBy(-mat.m23);


		Point camPt = new Point(0,0,0);
		camPt.Plus(vX);
		camPt.Plus(vY);
		camPt.Plus(vZ);

		//   if (! transWorld) postDraw();

		return camPt;
	}

	Point GetTarget()
	{
		// pokud probihaji mimo transformaci matic, pak si svet docasne transformuje

		if (! transWorld) preDraw();

		//   PMatrix3D mat = new PMatrix3D();
		//    p3d.getMatrix(mat);

		Vector vX = xAxis;
		Vector vY = yAxis;
		Vector vZ = zAxis;

		vX.MultipleBy(-mat.m03);
		vY.MultipleBy(-mat.m13);
		//  vZ.MultipleBy(-mat.m23);

		Point targetPt = new Point(0,0,0);
		targetPt.Plus(vX);
		targetPt.Plus(vY);

		if (! transWorld) postDraw();


		// konec transformace

		return targetPt;
	}

	float DistanceFrom(Point pt)
	{

		/*
		 pushMatrix();
		 
		 if (! transWorld) preDraw();
		 
		 translations();
		 Point camPt = new Point(GetCamera());
		 //     float dis = camPt.DistanceTo(pt);
		 
		 if (! transWorld) postDraw();
		 popMatrix();
		 */
		return 1;//dis;
	}

	void Print()
	{
		Point pos = GetCamera();
		Point targ = GetTarget();
		println( "camera [ " + pos.x+ " ; " + pos.y + " ; " + pos.z + " ]");
		println( "target [ " + targ.x+ " ; " + targ.y + " ; " + targ.z + " ]");  // CHYBA - VYPISUJE STEJNE HODNOTY JAKO CAMERA
	}


	Point Picking()
	{
		// pokud probihaji mimo transformaci matic, pak si svet docasne transformuje
		if (! transWorld) preDraw();

		scrn[0] = mouseX;
		scrn[1] = mouseY;
		scrn[2] = 0;

		model = new float[3];

		applyMatrices();
		Point camPt = GetCamera();

		if (! transWorld) postDraw();

		// konec transformace


		return cPLN. IntersectionLine( new Point( model[0],model[1],model[2] ) , camPt );
	}

	void SaveScreen()
	{
		String path = "D:/Data/processing/ScreenShots/";
		try{
			File dir = new File(path);

			String[] stavajici = dir.list();
			int count = stavajici.length;

			String fileName = "";

			if(count < 10) fileName = "00000"+count;
			else if( count >= 10 && count < 100) fileName = "0000"+count;
			else if( count >= 100 && count < 1000) fileName = "000"+count;
			else if( count >= 1000 && count < 10000) fileName = "00"+count;
			else if( count >= 10000 && count < 100000) fileName = "0"+count;
			else if( count >= 100000 && count < 1000000) fileName = ""+count;

			if(count < 9999999)
			{
				save(path + fileName + ".png");
				println ("Screen " + fileName + " byl uspesne ulozen do adresare " + path);
			}
			else println("pocet ScreenShotu prekrocil predvidanou mez, zapsi se nezdaril");
		}
		catch (NullPointerException e)
		{
			println("neni mozne ulozit ScreenSchot do adreseare " + path);
		}
	}

}








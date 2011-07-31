class Retez{

	Point[] bod = new Point[0];
	int kolikBodu = 0;


	void add(Point _bod){

	/*	if(bod.length>2){
			println("mooc!");
		}else{
*/
			bod = (Point[])expand(bod,bod.length+1);
			bod[bod.length-1] = _bod;
			println(bod[bod.length-1].x+" : "+bod[bod.length-1].y+" : "+bod[bod.length-1].z);
                      
//		}
	}

	void Draw(){
		
		
		
		for(int i = 0 ;i<bod.length;i++){
			bod[i].Draw();
			//bod[i].x = unprojectX(mouseX,bod[0].y,bod[0].z);
			//bod[i].y = modelY(bod[0].x,mouseY,bod[0].z);
			//bod[i].x = modelX(mouseX-width/2.0,mouseY-height/2.0,0);
			//bod[i].y = -modelY(mouseX-width/2.0,mouseY-height/2.0,0);
			//bod[i].z = modelZ(mouseX-width/2.0,mouseY-height/2.0,0);
		}                                                
		
		//println("world coords via modelXYZ = " + mx + ", " + my + ", " + mz);
		
		
	}


}

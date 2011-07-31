
Car car;


void setup(){
	size(800,600,P2D);

	car = new Car();
	stroke(255);
	background(0);
}


void draw(){
	//background(0);
	car.compute();
	car.draw();


}

void keyPressed(){
	if(keyCode==UP){
		car.speedUp(1.1);
	}else if(keyCode==DOWN){
		car.speedDown(1.2);
	}else if(keyCode==LEFT){
		car.turn(-1/car.vel.mag());
	}else if(keyCode==RIGHT){
		car.turn(1/car.vel.mag());

	}

}


class Car{
	PVector acc;
	PVector loc;
	PVector vel;
	PVector z = new PVector(0,0,-1);
	float rot;
	float r = 5;
	float theta = 0;

	Car(){
		acc = new PVector(0,0,0);
		loc = new PVector(width/2,height/2,0);
		vel = new PVector(0,0,0);
		rot = 0;
	}


	void speedUp(float _in){
		acc.add(0,-_in,0);

	}

	void speedDown(float _in){
		acc.add(0,_in,0);
	}

	void turn(float _kolik){
		rot += _kolik;


		//vel = rotate2(vel,z,rot);
		//loc = rotate2(loc,z,rot);
		//acc = rotate2(acc,z,rot);
	}

	void compute(){

		//rot*=0.76;
		PVector target = new PVector(cos(rot),sin(rot),0);
		target.add(new PVector(cos(target.y)/1.2,sin(target.x)/1.2,0));
		target.normalize();
		//acc.add(target);

		vel.add(target);
		acc.add(target);
		vel.add(acc);
		//vel.add(steer(new PVector(rot/100.0+loc.x,loc.y-1,0),true));
		//vel = rotate2(vel,z,0.01);
		loc.add(vel);
		rezist();

		if(loc.x>width)loc.x=0;
		if(loc.x<0)loc.x=width;

		if(loc.y>height)loc.y=0;
		if(loc.y<0)loc.y=height;


	}

	void rezist(){
		acc.mult(0.58);
		//rot*=0.8;
		vel.mult(0.99);
		vel.limit(3.0);
		acc.limit(0.5);
	}

	void draw(){
		theta = vel.heading2D() + PI/2;
		fill(200,100);
		stroke(255);
		pushMatrix();
		translate(loc.x,loc.y);
		rotate(theta);
		beginShape(TRIANGLES);
		vertex(0, -r*2);
		vertex(-r, r*2);
		vertex(r, r*2);
		endShape();
		popMatrix();

	}

	PVector rotate2(PVector v, PVector _axis,float ang)
	{
		PVector axis=new PVector(_axis.x,_axis.y,_axis.z);
		PVector vnorm=new PVector(v.x,v.y,v.z);
		float _parallel= axis.dot(v);
		PVector parallel = PVector.mult(axis, _parallel);

		PVector perp= PVector.sub(parallel,v);
		PVector Cross=v.cross(axis);
		//PVector result=PVector.add(Cross.mult(sin(-ang)),perp.mult(cos(-ang)),parallel);

		PVector result=PVector.add(parallel,PVector.add(PVector.mult(Cross,sin(-ang)),PVector.mult(perp,cos(-ang))));
		return result;
	}

	PVector steer(PVector target, boolean slowdown) {
		float maxspeed = .21;
		float maxforce = 1.2;
		PVector steer;  // The steering vector
		PVector desired = PVector.sub(target,loc);  // A vector pointing from the location to the target
		float d = desired.mag(); // Distance from the target is the magnitude of the vector
		// If the distance is greater than 0, calc steering (otherwise return zero vector)
		if (d > 0) {
			// Normalize desired
			desired.normalize();
			// Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)
			if ((slowdown) && (d < 100.0f)) desired.mult(maxspeed*(d/100.0f)); // This damping is somewhat arbitrary
			else desired.mult(maxspeed);
			// Steering = Desired minus Velocity
			steer = PVector.sub(desired,vel);
			steer.limit(maxforce);  // Limit to maximum steering force
		} else {
			steer = new PVector(0,0);
		}
		return steer;
	}


}

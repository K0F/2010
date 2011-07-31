
Test[] a = new Test[0];

void setup(){

	size(200,200,P2D);
	a = (Test[])append(a,new Test());
	a = (Test[])append(a,new Test());
	a = (Test[])append(a,new Test());
	println(a.length);

}


class Test{

	
	float b;



}

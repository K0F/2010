public class Point
{
	public Point(Point point)
	{
		x = point.x;
		y = point.y;
		z = point.z;
	}
	public Point(float x, float y)
	{
		this.x = x;
		this.y = y;
		this.z = 0;
	}
	public Point(float x, float y, float z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}
	public Point(Point origin, Vector direction)
	{
		x = origin.x + direction.x;
		y = origin.y + direction.y;
		z = origin.z + direction.z;
	}
	public float DistanceTo(Point targetPoint)
	{
		float d = 0;
		d = sqrt((targetPoint.x - x) * (targetPoint.x - x) +
		         (targetPoint.y - y) * (targetPoint.y - y) +
		         (targetPoint.z - z) * (targetPoint.z - z));
		return (d);
	}

	public void Plus(Vector direction)
	{
		x += direction.x;
		y += direction.y;
		z += direction.z;
	}

	void Draw()
	{
		pushMatrix();
		translate(x,y,z);
		noFill();
		stroke(255,20,20);
		box(20);
		popMatrix();
	}

	float x, y, z;

}

public class Vector
{
	public Vector(Vector vec)
	{
		x = vec.x;
		y = vec.y;
		z = vec.z;
	}
	public Vector(float x, float y, float z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}
	public Vector(float x1, float y1, float z1, float x2, float y2, float z2)
	{
		this.x = x2 - x1;
		this.y = y2 - y2;
		this.z = z1 - z2;
	}
	public Vector(Point fromPoint, Point toPoint)
	{
		x = toPoint.x - fromPoint.x;
		y = toPoint.y - fromPoint.y;
		z = toPoint.z - fromPoint.z;
	}

	public void MultipleBy(float koef)
	{
		x *= koef;
		y *= koef;
		z *= koef;
	}

	public void Plus(Vector addVector)
	{
		x += addVector.x;
		y += addVector.y;
		z += addVector.z;
	}

	public void Reverse()
	{
		x *= -1;
		y *= -1;
		z *= -1;
	}

	public void CrossProduct(Vector secondVector)
	{
		float tempX, tempY, tempZ;
		tempX = x;
		tempY = y;
		tempZ = z;

		x = tempY * secondVector.z - tempZ * secondVector.y;
		y = tempZ * secondVector.x - tempX * secondVector.z;
		z = tempX * secondVector.y - tempY * secondVector.x;
	}

	public void Unitize()
	{
		float d = Delka();
		x /=  d;
		y /=  d;
		z /=  d;
	}

	public float Delka()
	{
		float d = 0;
		//length = sqrt((ax * ax) + (ay * ay) + (az * az))
		d = sqrt((x * x) + (y * y) + (z * z));
		return d;
	}

	public boolean IsZero()
	{
		if ((x == 0) && (y == 0) && (z == 0)) return true;
		return false;
	}

	float x, y, z;

}

public class Plane
{
	public Plane(float x, float y, float z)
	{
		this.origin = new Point(x, y, z);

		xAxis = new Vector(1, 0, 0);
		yAxis = new Vector(0, 1, 0);
		zAxis = new Vector(0, 0, 1);

		displaySize = 10;
		numOfGrid = 4;
	}
	public Plane(Point origin)
	{
		this.origin = origin;

		xAxis = new Vector(1, 0, 0);
		yAxis = new Vector(0, 1, 0);
		zAxis = new Vector(0, 0, 1);

		displaySize = 10;
		numOfGrid = 4;
	}
	public Plane(Point origin, Point xVectorPoint, Point yVectorPoint)
	{
		this.origin = origin;
		xAxis = new Vector(origin, xVectorPoint);
		xAxis.Unitize();

		yAxis = new Vector(origin, yVectorPoint);

		yAxis.CrossProduct(xAxis);
		yAxis.Reverse();
		zAxis = new Vector(yAxis);
		zAxis.Unitize();
		zAxis.Reverse();

		yAxis.CrossProduct(xAxis);
		yAxis.Unitize();

		displaySize = 10;
		numOfGrid = 4;
	}
	public Plane(Point origin, Vector xDirection, Vector yDirection)
	{
		this.origin = origin;

		xDirection.Unitize();

		xAxis = xDirection;
		yAxis = yDirection;

		yAxis.CrossProduct(xDirection);
		yAxis.Reverse();
		zAxis = new Vector(yAxis);
		zAxis.Unitize();
		zAxis.Reverse();

		yAxis.CrossProduct(xDirection);
		yAxis.Unitize();

		displaySize = 10;
		numOfGrid = 4;
	}

	public Point PointAt(float u, float v, float w)
	{
		Vector xVec =new Vector(xAxis);
		xVec.MultipleBy(u);

		Vector yVec = new Vector(yAxis);
		yVec.MultipleBy(v);

		Vector zVec = new Vector(zAxis);
		zVec.MultipleBy(w);

		float pozX, pozY, pozZ;
		pozX = origin.x + xVec.x + yVec.x + zVec.x;
		pozY = origin.y + xVec.y + yVec.y + zVec.y;
		pozZ = origin.z + xVec.z + yVec.z + zVec.z;

		return new Point(pozX, pozY, pozZ);
	}

	public void Draw()
	{
		pushMatrix();
		translate(origin.x, origin.y, origin.z);


		stroke (40,40,40,255);

		for (float i = -displaySize / 2; i <= displaySize / 2; i += displaySize / numOfGrid)
		{
			if (i == 0)
			{
				Point ptStart = new Point(PointAt(0, -displaySize / 2, 0));
				line(ptStart.x, ptStart.y, ptStart.z,origin.x, origin.y, origin.z);

				ptStart = new Point(PointAt(0, displaySize / 2, 0));
				stroke (0, 255, 0, 255);
				line(ptStart.x, ptStart.y, ptStart.z,origin.x, origin.y, origin.z);
				stroke (40,40,40,255);
			}
			else
			{
				Point ptStart = new Point(PointAt(i, displaySize / 2, 0));
				Point ptEnd = new Point(PointAt(i, -displaySize / 2, 0));

				line(ptStart.x, ptStart.y, ptStart.z,ptEnd.x, ptEnd.y, ptEnd.z);
			}
		}

		for (float i = -displaySize / 2; i <= displaySize / 2; i += displaySize / numOfGrid)
		{
			if (i == 0)
			{
				Point ptStart = new Point(PointAt(-displaySize / 2, 0, 0));
				line(ptStart.x, ptStart.y, ptStart.z,origin.x, origin.y, origin.z);

				ptStart = new Point(PointAt(displaySize / 2, 0, 0));
				stroke(255, 0, 0, 255);
				line(ptStart.x, ptStart.y, ptStart.z,origin.x, origin.y, origin.z);
				stroke(40, 40, 40, 255);
			}
			else
			{
				Point ptStart = new Point(PointAt(displaySize / 2, i, 0));
				Point ptEnd = new Point(PointAt(-displaySize / 2, i, 0));

				line(ptStart.x, ptStart.y, ptStart.z,ptEnd.x, ptEnd.y, ptEnd.z);
			}


		}
		Point ptStartZ = new Point(PointAt(0, 0, displaySize / 2));
		stroke(0, 0, 255, 255);
		line(ptStartZ.x, ptStartZ.y, ptStartZ.z,origin.x, origin.y, origin.z);
		stroke(40, 40, 40, 255);

		popMatrix();

	}

	Point origin;
	Vector xAxis, yAxis, zAxis;
	float displaySize;
	int numOfGrid;

}












public class Point
{
            float x, y, z;

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

            boolean CompareTo(Point targetPoint)
            {
                        float tolerance = 0.01;
                        if(x - tolerance <=  targetPoint.x && x + tolerance >=  targetPoint.x)
                        {
                                    if(y - tolerance <=  targetPoint.y && y + tolerance >=  targetPoint.y)
                                    {
                                                if(z - tolerance <=  targetPoint.z && z + tolerance >=  targetPoint.z)
                                                {
                                                            return true;
                                                }
                                    }
                        }
                        return false;         
            }

            public void Plus(Vector direction)
            {
                        x += direction.x;
                        y += direction.y;
                        z += direction.z;
            }

            String ToString()
            {
                        String answ = round(x*100)/100.0 + ";" + round(y*100)/100.0 + ";" + round(z*100)/100.0;
                        return answ;           
            }

            void Draw()
            {
                        if(this != null)
                        {
                                    pushMatrix();
                                    translate(x,y,z);
                                    noFill();	
                                    box(5);	
                                    popMatrix();
                        }
            }

            void Draw(float crossSize)
            {

                        Point pt = new Point(0,0,0);
                        float distanceKoef = cam.DistanceFrom(pt)/1;

                        Plane viewPln = new Plane(new Point(x,y,z),cam.xAxis,cam.yAxis);

                        Point pt1 = viewPln.PointAt(crossSize*distanceKoef,crossSize*distanceKoef,0);
                        Point pt2 = viewPln.PointAt(-crossSize*distanceKoef,-crossSize*distanceKoef,0);
                        Point pt3 = viewPln.PointAt(crossSize*distanceKoef,-crossSize*distanceKoef,0);
                        Point pt4 = viewPln.PointAt(-crossSize*distanceKoef,crossSize*distanceKoef,0);

                        line(pt1.x,pt1.y,pt1.z,pt2.x,pt2.y,pt2.z);
                        line(pt3.x,pt3.y,pt3.z,pt4.x,pt4.y,pt4.z);

            }
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
            public Vector (Point fromPoint, float degXY, float degXZ)
            {
                        Vector dir = new Vector(cos (degXY) , sin (degXY), 0);
                        Plane pln = new Plane(fromPoint, dir, new Vector(0,0,1));           
                        Point toPoint = pln.PointAt(cos (degXZ) , sin (degXZ), 0);
                        Vector answ = new Vector(fromPoint, toPoint);
                        answ.Unitize();

                        x = answ.x;
                        y = answ.y;
                        z = answ.z;
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

            Vector Reverse()
            {
                        x *= -1;
                        y *= -1;
                        z *= -1;

                        return new Vector(x,y,z);
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

            public float DotProduct(Vector vec2)
            {
                        return x*vec2.x+y*vec2.y+z*vec2.z;
            }

            public void Unitize()
            {
                        float d = Delka();
                        if(d == 0)
                        {
                                    x /= 0;
                                    y /= 0;
                                    z /= 0;     
                        }
                        else
                        {
                                    x /=  d;
                                    y /=  d;
                                    z /=  d;
                        }
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

            float RadToVector(Vector vector)
            {
                        Vector vec1 = new Vector(this);
                        Vector vec2 = new Vector(vector);
                        if (vec1.IsZero() || vec2.IsZero()) return 0;

                        vec1.Unitize();
                        vec2.Unitize();

                        return acos(vec1.DotProduct(vec2));
            }

            float DegToVector(Vector vector)
            {
                        Vector vec1 = new Vector(this);
                        Vector vec2 = new Vector(vector);
                        if (vec1.IsZero() || vec2.IsZero()) return 0;

                        vec1.Unitize();
                        vec2.Unitize();

                        return acos(vec1.DotProduct(vec2))*180/PI;
            }



            float RadXY()
            {
                        //  println(atan2(1,1)*180/PI);        
                        return atan2(y,x);
            }
            float DegXY()
            {
                        //  println(atan2(1,1)*180/PI);        
                        return atan2(y,x)*180/PI;
            } 
            float RadXZ()
            {
                        //  println(atan2(1,1)*180/PI);        
                        return atan2(z,x);
            }
            float DegXZ()
            {
                        //  println(atan2(1,1)*180/PI);        
                        return atan2(z,x)*180/PI;
            }

            String ToString()
            {
                        String answ = x + ";" + y + ";" + z;
                        return answ;           
            }

            void Draw(Point origin)
            {
                        stroke(255,0,0);
                        line(origin.x, origin.y, origin.z, origin.x+x, origin.y+y, origin.z+z);

                        pushMatrix();
                        translate(origin.x+x, origin.y+y, origin.z+z);
                        noFill();
                        box(10);
                        popMatrix();
            }

            void Draw(Point origin, float arrowSize)
            {
                        Vector tmp = new Vector(x,y,z);

                        // tmp.Unitize();
                        //   tmp.MultipleBy(arrowSize);

                        stroke(255,0,0);
                        line(origin.x, origin.y, origin.z, origin.x+tmp.x, origin.y+tmp.y, origin.z+tmp.z);

                        Point pt = new Point(0,0,0);
                        float distanceKoef =  cam.DistanceFrom(pt)/1;

                        Plane viewPln = new Plane(new Point(x+origin.x,y+origin.y,z+origin.z),tmp,cam.yAxis);

                        Point pt1 = viewPln.PointAt(0,0,0);
                        Point pt2 = viewPln.PointAt(-arrowSize*distanceKoef,arrowSize*distanceKoef/3,0);
                        Point pt3 = viewPln.PointAt(-arrowSize*distanceKoef,-arrowSize*distanceKoef/3,0);

                        fill(255,0,0);
                        beginShape();
                        vertex(pt1.x,pt1.y,pt1.z);
                        vertex(pt2.x,pt2.y,pt2.z);
                        vertex(pt3.x,pt3.y,pt3.z);
                        vertex(pt1.x,pt1.y,pt1.z);
                        endShape();
                        noFill();
            }

            void Draw(Point origin,float multiplikator, float arrowSize)
            {
                        Vector tmp = new Vector(x,y,z);

                        tmp.Unitize();
                        tmp.MultipleBy(multiplikator);

                        stroke(255,0,0);
                        line(origin.x, origin.y, origin.z,x*multiplikator+origin.x,y*multiplikator+origin.y,z*multiplikator+origin.z);

                        Point pt = new Point(0,0,0);
                        float distanceKoef =  cam.DistanceFrom(pt)/1;

                        Plane viewPln = new Plane(new Point(x*multiplikator+origin.x,y*multiplikator+origin.y,z*multiplikator+origin.z),tmp,cam.xAxis);

                        Point pt1 = viewPln.PointAt(0,0,0);
                        Point pt2 = viewPln.PointAt(-arrowSize*distanceKoef,arrowSize*distanceKoef/3,0);
                        Point pt3 = viewPln.PointAt(-arrowSize*distanceKoef,-arrowSize*distanceKoef/3,0);

                        fill(255,0,0);
                        beginShape();
                        vertex(pt1.x,pt1.y,pt1.z);
                        vertex(pt2.x,pt2.y,pt2.z);
                        vertex(pt3.x,pt3.y,pt3.z);
                        vertex(pt1.x,pt1.y,pt1.z);
                        endShape();
                        noFill();
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
                        xAxis.Reverse();

                        yAxis = new Vector(origin, yVectorPoint);

                        yAxis.CrossProduct(xAxis);
                        yAxis.Reverse();
                        zAxis = new Vector(yAxis);
                        zAxis.Unitize();

                        yAxis.CrossProduct(xAxis);
                        yAxis.Unitize();

                        displaySize = 10;
                        numOfGrid = 4;
            }

            public Plane(Point origin, Vector xDirection, Vector yDirection)
            {
                        this.origin = origin;

                        Vector xDir = new Vector(xDirection);
                        Vector yDir = new Vector(yDirection);
                        xDir.Unitize();

                        xAxis = xDir;
                        yAxis = yDir;

                        yAxis.CrossProduct(xDir);
                        yAxis.Reverse();
                        zAxis = new Vector(yAxis);
                        zAxis.Unitize();
                        //  zAxis.Reverse();

                        yAxis.CrossProduct(xDir);
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

            public Point IntersectionLine(Point ptA, Point ptB)
            {
                        Point ptC = PointAt(1,1,0);
                        float koef1, koef2;

                        koef1 =  (ptC.x-ptA.x)*zAxis.x + (ptC.y-ptA.y)*zAxis.y + (ptC.z-ptA.z)*zAxis.z;
                        koef2 =  (ptB.x-ptA.x)*zAxis.x + (ptB.y-ptA.y)*zAxis.y + (ptB.z-ptA.z)*zAxis.z;

                        Vector dir = new Vector(ptA,ptB);
                        dir.MultipleBy(koef1/koef2);
                        //println(koef1/koef2);
                        return new Point(dir.x+ptA.x, dir.y+ptA.y, dir.z+ptA.z);
            }

            public void Draw()
            {
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
            }

            Point origin;
            Vector xAxis, yAxis, zAxis;
            float displaySize;
            int numOfGrid;
}

class Line
{
            Point from, to;
            Vector dir;

            Line(Point p1, Point p2)
            {
                        from = p1;
                        to = p2;
                        dir = new Vector(p1,p2);
            } 

            Line(Point p, Vector vec, float distance)
            {
                        from = p;
                        dir = new Vector(vec);
                        dir.Unitize();
                        dir.MultipleBy(distance);
                        to = new Point(from);
                        to.Plus(dir);                       
            } 

            Line(float x1, float y1, float z1, float x2, float y2, float z2)
            {
                        from = new Point(x1, y1, z1);
                        to = new Point(x2, y2, z2);
                        dir = new Vector(from,to);
            } 

            float GetCloserT()
            {
                        // mouse hit detection using screnX, screenY
                        float citlivost = ceil(from.DistanceTo(to));
                        int tolerance = 5;
                        float nejmensiVzdalenost = 99999999;
                        float nejblizsiT = -1;
                        int screen_X, screen_Y;

                        for (int i = 0 ; i < citlivost; i++)
                        {
                                    Point temp = PointAt(1/(float)citlivost*i);

                                    screen_X = int(screenX(temp.x, temp.y, temp.z));
                                    screen_Y = int(screenY(temp.x, temp.y, temp.z));

                                    if (screen_X > mouseX-tolerance && screen_X < mouseX+tolerance && screen_Y > mouseY-tolerance && screen_Y < mouseY+tolerance)
                                    {

                                                float dis = sqrt((screen_X-mouseX)*(screen_X-mouseX)+(screen_Y-mouseY)*(screen_Y-mouseY));
                                                if(nejmensiVzdalenost > dis)
                                                {
                                                            nejmensiVzdalenost = dis;
                                                            nejblizsiT = i;
                                                            nejblizsiT /= (float)citlivost;
                                                }
                                    }
                        }
                        return nejblizsiT;
            }

            Point GetCloserPoint()
            {
                        float t = GetCloserT();
                        return PointAt(t);
            }



            public Point GetClosestPoint(Point p) 
            {

                        final float xDelta = to.x - from.x;
                        final float yDelta = to.y - from.y;

                        if ((xDelta == 0) && (yDelta == 0)) {
                                    throw new IllegalArgumentException("p1 and p2 cannot be the same point");
                        }

                        final float u = ((p.x - from.x) * xDelta + (p.y - from.y) * yDelta) / (xDelta * xDelta + yDelta * yDelta);

                        final Point closestPoint;
                        if (u < 0) 
                        {
                                    closestPoint = from;
                        } 
                        else if (u > 1) 
                        {
                                    closestPoint = to;
                        } 
                        else 
                        {
                                    closestPoint = PointAt(u); 
                        }

                        return closestPoint;
            }





            float Delka()
            {
                        return dir.Delka();     
            }

            // t = <0;1>
            Point PointAt(float t)
            {
                        Point temp = new Point(from);
                        Vector tVec = new Vector(dir);
                        tVec.MultipleBy(t);
                        temp.Plus(tVec);    
                        return temp;       
            }

            // pouze 2D
            Point LineLineIntersection(Line otherLine)
            {
                        float x1, x2, x3, x4;       
                        float y1, y2, y3, y4;

                        x1 = from.x;
                        x2 = to.x;
                        x3 = otherLine.from.x;
                        x4 = otherLine.to.x;

                        y1 = from.y;
                        y2 = to.y;
                        y3 = otherLine.from.y;
                        y4 = otherLine.to.y;

                        float u = ((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
                        float v = ((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
                        if(u > 1) return null;
                        if(u < 0) return null;
                        if(v > 1) return null;
                        if(v < 0) return null;
                        if(u == 0 && v == 0) return null;

                        return PointAt(u);
            }

            void Draw()
            {
                        line(from.x, from.y, from.z ,to.x,to.y, to.z);
            }

}

class Polyline
{
            Point[] pt;
            boolean closed;

            Polyline()
            {
                        pt = new Point[0];
            }
            Polyline(Point[] pts)
            {
                        pt = new Point[0];
                        for(int i = 0 ; i < pts.length; i++)
                        {
                                    pt = (Point[]) append(pt,pts[i]);
                        }           
            }

            void AddPoint(float x, float y, float z)
            {
                        pt = (Point[]) append(pt,new Point(x,y,z));
            }

            void AddPoint(Point onePt)
            {
                        pt = (Point[]) append(pt,onePt);
            }

            void RemovePoint(int num)
            {

            }

            Point GetPoint(int no)
            {
                        if(pt[no] != null)  return pt[no];
                        return null;
            }

            float[] GetPointT()
            {
                        float delka = GetDelka();
                        float[] tSeg = new float[0];
                        float delta = 0;

                        tSeg = append(tSeg, 0);
                        for (int i = 1; i < pt.length; i++)
                        {
                                    delta += pt[i-1].DistanceTo(pt[i])/delka;
                                    tSeg = append(tSeg, delta);
                        }   

                        return tSeg;
            }

            Point PointAt(float t)
            {
                        if(t >= 0 && t <= 1)
                        {
                                    float[] tSeg = GetPointT();

                                    for(int i = 1; i < tSeg.length; i++)
                                    {
                                                if(t >= tSeg[i-1] && t <= tSeg[i])
                                                {
                                                            float a = tSeg[i]-tSeg[i-1];
                                                            float b = t - tSeg[i-1];
                                                            t = b/a;
                                                            t = constrain(t, 0, 1);

                                                            return new Line (pt[i-1], pt[i]) .PointAt(t);
                                                }    
                                    }
                        }
                        return null;
            }

            float GetCloserT()
            {
                        float delka = GetDelka();
                        float[] tSeg = new float[0];
                        float delta = 0;

                        tSeg = append(tSeg, 0);
                        for (int i = 1; i < pt.length; i++)
                        {
                                    delta += pt[i-1].DistanceTo(pt[i])/delka;
                                    tSeg = append(tSeg, delta);
                        }

                        // mouse hit detection using screnX, screenY
                        float citlivost = ceil(delka);
                        int tolerance = 5;
                        float nejmensiVzdalenost = 99999999;
                        float nejblizsiT = -1;
                        int screen_X, screen_Y;
                        for (int k = 1 ; k < pt.length; k++)
                        {
                                    Line tmpLine = new Line(pt[k-1], pt[k]);
                                    for (float i = 0 ; i < 1; i+=1/citlivost)
                                    {
                                                Point temp = tmpLine.PointAt(i);

                                                screen_X = int(screenX(temp.x, temp.y, temp.z));
                                                screen_Y = int(screenY(temp.x, temp.y, temp.z));

                                                if (screen_X > mouseX-tolerance && screen_X < mouseX+tolerance && screen_Y > mouseY-tolerance && screen_Y < mouseY+tolerance)
                                                {
                                                            float dis = sqrt((screen_X-mouseX)*(screen_X-mouseX)+(screen_Y-mouseY)*(screen_Y-mouseY));
                                                            if(nejmensiVzdalenost > dis)
                                                            {
                                                                        nejmensiVzdalenost = dis;
                                                                        nejblizsiT = (tSeg[k] - tSeg[k-1])* i + tSeg[k-1] ;
                                                            }
                                                }
                                    }
                        }
                        return nejblizsiT;
            }

            Point GetCloserPoint()
            {
                        float t = GetCloserT();
                        return PointAt(t);
            }

            float GetDelka()
            {
                        float answ = 0;
                        for (int i = 1; i < pt.length; i++)
                        {
                                    answ += pt[i-1].DistanceTo(pt[i]);
                        }
                        return answ;
            }

            float GetDelka(int no)
            {
                        try
                        {
                                    return pt[no-1].DistanceTo(pt[no]);
                        }
                        catch (Exception e)
                        {
                                    return -1;     
                        }
            }


            void Draw()
            {
                        for (int i = 1; i < pt.length; i++)
                        {
                                    if (( pt[i-1] != null ) && ( pt[i] != null ))   new Line( pt[i-1] , pt[i] ).Draw();
                        }
            }
            void Draw(float displaySize)
            {
                        for (int i = 1; i < pt.length; i++)
                        {
                                    if (( pt[i-1] != null ) && ( pt[i] != null ))   new Line( pt[i-1] , pt[i] ).Draw();
                                    if(pt.length-1 != i) pt[i].Draw(displaySize);
                        }
            }
}

class Circle
{
            Point origin;
            Plane cPln;
            float r;

            Circle(Point origin, float r)
            {
                        cPln = new Plane(origin, new Vector(1,0,0), new Vector(0,1,0));
                        this.r = r;
            }
            Circle (Plane cPln, float r)
            {
                        this.cPln = cPln;
                        this.r = r;
            }

            Point PointAt(float t)
            {
                        float i = 2*PI * t;
                        return  cPln.PointAt( r * cos (i) , r * sin (i) , 0 );
            }

            // NEFUNGUJE OBECNE !!!!
            Point[] Intersection_CircleCircle(Circle cir2)
            {
                        if(cPln.origin.x == cir2.cPln.origin.x && cPln.origin.y == cir2.cPln.origin.y && cPln.origin.z == cir2.cPln.origin.z) return null;
                        Point[] answ = new Point[0];

                        float a = cir2.r;
                        float b = this.r;
                        Vector centers = new Vector(cPln.origin, cir2.cPln.origin);
                        float c = centers.Delka();
                        centers.Draw(cPln.origin,10);
                        // println("a = " +a + " b = " +b + " c = " +c );

                        if (c > a+b || c < a-b || c < b-a) return null; 

                        float uhel = acos((a*a-c*c-b*b)/(-2*b*c));

                        Point p1 = new Point(r*cos(uhel), r*sin(uhel),0);
                        p1.Plus(new Vector(cPln.origin.x, cPln.origin.y, cPln.origin.z));
                        p1.Draw();

                        Point p2 = new Point(r*cos(-uhel), r*sin(-uhel),0);
                        p2.Plus(new Vector(cPln.origin.x, cPln.origin.y, cPln.origin.z));
                        p2.Draw();




                        return answ;
            }


            void Draw()
            {
                        int seg = 50;
                        for(float i = 0 ; i < 2*PI ; i += PI/seg)
                        {
                                    Line l = new Line(cPln.PointAt(r* cos (i), r*sin (i) , 0), cPln.PointAt(r* cos (i+ PI/seg), r*sin (i+ PI/seg) , 0));
                                    l.Draw();
                        }    
                        //     PointAt(0,this).Draw();
            }

}


























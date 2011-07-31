
Area[] area = new Area[0];
static int numberOfArea = 0;

class Area
{
            int id;
            Point minP, maxP;
            Line ln1, ln2, ln3, ln4;
            int segX, segY;
            Sensor[] sensors;

            color fromColor, toColor;

            boolean isOver, isSelected;

            Area(Point p1, Point p2)
            {
                        id = numberOfArea;
                        numberOfArea ++;

                        Point minPoint, maxPoint;
                        minPoint = new Point(0,0,0);
                                             maxPoint = new Point(0,0,0);
                        if(p1.x < p2.x)
                        {
                                    minPoint.x = p1.x ;
                                                maxPoint.x = p2.x ;
                        }
                        else
                        {
                                    minPoint.x = p2.x;
                                    maxPoint.x = p1.x;
                        }
                        if(p1.y < p2.y)
                        {
                                    minPoint.y = p1.y ;
                                                maxPoint.y = p2.y ;
                        }
                        else
                        {
                                    minPoint.y = p2.y;
                                    maxPoint.y = p1.y;
                        }


                        minP = minPoint;
                        maxP = maxPoint;

                        ln1 = new Line(new Point(minP.x, minP.y, minP.z), new Point(maxP.x, minP.y, minP.z));
                        ln2 = new Line(new Point(maxP.x, minP.y, minP.z), new Point(maxP.x, maxP.y, minP.z));
                        ln3 = new Line(new Point(maxP.x, maxP.y, minP.z), new Point(minP.x, maxP.y, minP.z));
                        ln4 = new Line(new Point(minP.x, maxP.y, minP.z), new Point(minP.x, minP.y, minP.z));

                        sensors = new Sensor[0];

                        segX = 100;
                        segY = 100;
                        fromColor = color(200, 190, 0);
                        toColor = color(0, 102, 153);

                        float last_i, last_k;
                        last_i = minP.x;
                        last_k = minP.y;


                        for(float i = minP.x; i <= maxP.x ; i += (maxP.x-minP.x) / segX)
                        {
                                    for(float k = minP.y; k <= maxP.y ; k += (maxP.y-minP.y) / segY)
                                    {
                                                Sensor tempS = new Sensor(new Point(last_i, last_k, 0), new Point(i, k, 0));
                                                sensors = (Sensor[]) append(sensors,tempS);
                                                last_k = k;
                                    }      
                                    last_k = minP.y;
                                    last_i = i;
                        }


            }

            void AddArea()
            {
                        area = (Area[]) append (area, this);
            }

            void Calculate()
            {

                        for(int i = 0 ; i < sensors.length; i++)
                        {
                                    sensors[i].Calculate();
                        }
            }

            boolean IsOver()
            {
                        Point mouseProj = cam.Picking();
                        Point tempPoint1 = ln1.GetClosestPoint(mouseProj);
                        Point tempPoint2 = ln2.GetClosestPoint(mouseProj);
                        Point tempPoint3 = ln3.GetClosestPoint(mouseProj);
                        Point tempPoint4 = ln4.GetClosestPoint(mouseProj);
                        if(mouseProj.DistanceTo(tempPoint1) < 10) return true; 
                        if(mouseProj.DistanceTo(tempPoint2) < 10) return true; 
                        if(mouseProj.DistanceTo(tempPoint3) < 10) return true; 
                        if(mouseProj.DistanceTo(tempPoint4) < 10) return true; 

                        return false;
            }

            String[] GetInfo()
            {
                        String[] answ = new String[0];
                        answ = append(answ,"Name : Area " + id);

                        answ = append(answ,"");
                        answ = append(answ, "BBox min : " );
                        answ = append(answ, " " + minP.ToString());
                        answ = append(answ,"");
                        answ = append(answ, "BBox max : " );
                        answ = append(answ, " " + maxP.ToString());

                        return answ;
            }

            void Kill()
            {                        
                        Area[] temp = new Area[0];
                        int noAnt = 0;
                        if(area.length > 0)
                        {
                                    for(int i = 0 ; i < area.length; i++)
                                    {
                                                if(i != id)
                                                {
                                                            temp = (Area[]) append(temp,area[i]);
                                                }            
                                    }
                                    numberOfArea --;
                        }
                        area = temp;
            }

            void Draw()
            {
                        isOver = IsOver();
                        int nejValue = 1;

                        for(int i = 0; i < sensors.length; i ++)
                        {
                                    if(sensors[i].value > nejValue) nejValue = sensors[i].value;
                        }

                        

                         noStroke();
                        //stroke(200);
                        rectMode(CORNERS);
                        for(int i = 0; i < sensors.length; i ++)
                        {
                                    fill(lerpColor(fromColor,toColor,sensors[i].value/(float)nejValue));
                                    rect(sensors[i].minP.x, sensors[i].minP.y, sensors[i].maxP.x, sensors[i].maxP.y);       
                        }
                        rectMode(CORNER);
                        
                        if(isSelected)  stroke(232,120,20);
                        else if(isOver) stroke(26,120,200);
                        else stroke(120);
                        ln1.Draw();
                        ln2.Draw();
                        ln3.Draw();
                        ln4.Draw();

            }
}

class Sensor
{
            Point minP, maxP;
            int value;

            Sensor(Point minPoint, Point maxPoint)
            {
                        minP = minPoint;
                        maxP = maxPoint;    
                        value = 0;
            }

            void Calculate()
            {
                        for (int i = 0; i < A.length; i ++)
                        {
                                    if(IsInBBox(A[i].origin)) value++;
                        }
            }

            boolean IsInBBox(Point test)
            {
                        if(test.x >= minP.x && test.x <= maxP.x)
                        {
                                    if(test.y >= minP.y && test.y <= maxP.y)
                                    {
                                                if(test.z >= minP.z && test.z <= maxP.z)
                                                {
                                                            return true;
                                                }
                                    }
                        }
                        return false;
            }

}

Point tmpFirstArea = null;
void PolozArea()
{
            if(tmpFirstArea == null)
            {
                        tmpFirstArea = cam.Picking();
            }
            else
            {
                        Point tmpSecondArea =  cam.Picking();
                        Area area = new Area(tmpFirstArea,tmpSecondArea);
                        area.AddArea();
                        tmpFirstArea = null;
                        tmpSecondArea = null;
            }
}































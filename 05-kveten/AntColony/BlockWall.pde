
Wall[] W = new Wall[0];

class Wall
{
            Point A, B;
            Line wall;
            Point[] refPt;
            float numRef = 200;

            Wall()
            {
                        wall = new Line(new Point(0,0,0), new Point(1,0,0));

                        refPt = new Point[0];
                        float delka = wall.Delka();
                        for(int i = 0; i < numRef+1; i++)
                        {
                                    refPt = (Point[]) append (refPt, wall.PointAt(i/numRef));     
                        }
            }

            Wall(Point ptA, Point ptB)
            {
                        wall = new Line(ptA, ptB);

                        refPt = new Point[0];
                        float delka = wall.Delka();
                        for(int i = 0; i < numRef+1; i++)
                        {
                                    refPt = (Point[]) append (refPt, wall.PointAt(i/numRef));     
                        }
            }

            void AddWall()
            {
                        W = (Wall[]) append (W, this);
            }

            void Draw()
            {
                        stroke(0);
                        wall.Draw();
            }
}


Point tmpFirst = null;
void PolozWall()
{
            if(tmpFirst == null)
            {
                        tmpFirst = cam.Picking();
            }
            else
            {
                        Point tmpSecond =  cam.Picking();

                        Wall w = new Wall(tmpFirst,tmpSecond);
                        w.AddWall();
                        tmpFirst = null;
                        tmpSecond = null;
            }
}










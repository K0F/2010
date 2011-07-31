Spray[] S = new Spray[0];
static int numberOfSpray = 0;

class Spray
{
            int id;
            int produceTime;
            Point origin;
            Vector dir;

            boolean isOver, isSelected;


            Spray(float x, float y, float z)
            {
                        id = numberOfSpray;
                        numberOfSpray++;
                        produceTime = 150;

                        origin = new Point(x,y,z);
                        dir = new Vector (0.1,0,0);
                        S = (Spray[]) append (S, this);
            }

            void Direction (Vector dir)
            {
                        this.dir = dir;
                        this.dir.Unitize();
            }

            void Calculate()
            {
                        if(time % produceTime == 0) 
                        {
                                    for (int i = 0; i < S.length; i++)
                                    {
                                                if(i != id)  new Ant(this, S[i]);
                                    }
                        }
            }

            void ProduceAnt()
            {

            }

            boolean IsOver()
            {
                        int scx,scy;
                        int tolerance = 10;
                        // mouse hit detection using screnX, screenY
                        scx = int(screenX(origin.x, origin.y, origin.z));
                        scy = int(screenY(origin.x, origin.y, origin.z));

                        if (scx > mouseX-tolerance && scx < mouseX+tolerance && scy > mouseY-tolerance && scy < mouseY+tolerance) return true;
                        else	return false;
            }

            void Draw()
            {
                        isOver = IsOver();

                        if(isSelected) stroke(232,120,20);
                        else if(isOver) stroke(26,120,200);
                        else stroke(120);

                        origin.Draw(15);           
                        
                        fill(255,0,0);
                        text(id,screenX(origin.x, origin.y, origin.z)+10, screenY(origin.x, origin.y, origin.z)-10);
            }

}

void PolozSpray()
{
            Point temp = new Point(cam.Picking());
            new Spray(temp.x, temp.y, temp.z);           
}









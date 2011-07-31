Feromon[] F = new Feromon[0];
static int numberOfFeromon = 0;


class Feromon
{
            int id;
            float maxLife, life, parentLife;
            Point origin, moveWay;
            int parentID, parentFrom, parentTo;
            float[] parentVidel;

            boolean isOver, isSelected;

            Feromon(Ant parent)
            {
                        id = numberOfFeromon;
                        numberOfFeromon ++;
                        maxLife = 5000;
                        life = maxLife;
                        origin = new Point (parent.origin);

                        parentID = parent.id;
                        parentFrom =  parent.parentSpray.id;
                        parentTo =  parent.targetSpray.id;
                        parentVidel = parent.videlID;
                        parentLife =  parent.life;

                        F = (Feromon[]) append (F, this);
            }

            void Calculate()
            {
                        if(life <= 0) Kill();
                        life--;           
            }

            void Kill()
            {                  
                        id = -1;
            }

            boolean IsOver()
            {
                        int scx,scy;
                        int tolerance = 5;
                        // mouse hit detection using screnX, screenY
                        scx = int(screenX(origin.x, origin.y, origin.z));
                        scy = int(screenY(origin.x, origin.y, origin.z));

                        if (scx > mouseX-tolerance && scx < mouseX+tolerance && scy > mouseY-tolerance && scy < mouseY+tolerance) return true;
                        else	return false;
            }

String[] GetInfo()
            {
                        String[] answ = new String[0];
                        answ = append(answ,"Name : Feromon " + id);

                        answ = append(answ,"");
                        answ = append(answ, "Life : " + life);
                        answ = append(answ, "FromID : " + parentFrom);
                        answ = append(answ,"");

                        for(int i = 0; i < parentVidel.length; i++)
                        {
                                    answ = append(answ, "VidelID " + i + " : " + parentVidel[i]);
                        }
                        return answ;
            }
            
            void Draw()
            {
                        isOver = IsOver();

                        if(isSelected) stroke(232,120,20);                                                      
                        else if(isOver) stroke(26,120,200);
                        else  stroke(lerp(0,255,life/maxLife));

                        if(id != -1) 
                        {
                                    origin.Draw(1);      
                        }
            }


}

void ClearFeromons()
{
            Feromon[] temp = new Feromon[0];
            int noFeromon = 0;
            if(F.length > 0)
            {
                        for(int i = 0 ; i < F.length; i++)
                        {
                                    if(F[i].id != -1)
                                    {
                                                F[i].id = noFeromon;
                                                temp = (Feromon[]) append(temp,F[i]);
                                                noFeromon ++;
                                    }            
                        }

            }
            numberOfFeromon = noFeromon-1;
            F = new Feromon[0];
            F = temp;    
}














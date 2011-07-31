  PFont font;
static int globalNumControl = 0;
class Toolbar
{
            int x, y, w, h;

            Button[] collButton;

            int ID_Over, ID_Pressed, ID_LastPressed;
            boolean isOverToolbar;

          
            int fontSize = 10;

            Toolbar(int scrX, int scrY, int toolW, int toolH)
            {
                        x = scrX;                        
                        y = scrY;
                        w = toolW;
                        h = toolH;

                        ID_Over = ID_Pressed = ID_LastPressed = -1;

                        //zalozeni nove kolekce tlacitek
                        collButton = new Button[0];


                        // font, velikost, smoothing?
			//println(PFont.list());
                        font = createFont("Arial",fontSize,true);
                        //selekce aktual fontu
                        textFont(font);
                        //lepsi pro P3D

            }

            void Calculate()
            {
                        if(! drag)
                        {
                                    if (IsOverToolbar())
                                    {
                                                if (IsOverControl())
                                                {
                                                            if(leftDown) 
                                                            {
                                                                        if(ID_Pressed > -1)  collButton[ID_Pressed].pressed = false;

                                                                        ID_Pressed = ID_Over;
                                                                        collButton[ID_Over].pressed = true;

                                                                        // okamzita akce pro nezaskrtnutelne buttony
                                                                        if(! collButton[ID_Pressed].permanentAction)
                                                                        {
                                                                                    Draw();
                                                                                    LClick();    
                                                                        }
                                                            }
                                                }
                                    }
                                    else
                                    {
                                                if(leftDown) LClick();
                                    }

                                    if(rightDown) RClick();
                                    ID_Over = -1;
                        }

            }

            void AddControl(Button b)
            {
                        b.ID = globalNumControl;
                        globalNumControl ++;

                        collButton = (Button[]) append(collButton,b);
            }


            boolean IsOverToolbar()
            {
                        if (x<mouseX && mouseX<(x+w))
                        {
                                    if (y<mouseY && mouseY<(y+h))
                                    {
                                                return true;
                                    }
                        }
                        return false;            
            }

            boolean IsOverControl()
            {
                        for(int i = 0; i < collButton.length; i++)
                        {
                                    if (collButton[i].IsOver())
                                    {
                                                ID_Over = i;
                                                return true;
                                    }
                        }
                        return false;
            }

            void LClick()
            {
                        if(ID_Pressed >-1)
                        {
                                    if(collButton[ID_Pressed].action == "makeSpray") PolozSpray();
                                    if(collButton[ID_Pressed].action == "makeWall") PolozWall();
                                    if(collButton[ID_Pressed].action == "testArea") PolozArea();

                                    if(ID_Pressed >-1)
                                    {
                                                if (collButton[ID_Pressed].action == "makeImport")
                                                {
                                                            ref.Import(); 
                                                            collButton[ID_Pressed].pressed = false; 
                                                            ID_LastPressed = ID_Pressed ;          
                                                            ID_Pressed = -1;
                                                }
                                    }
                                    if(ID_Pressed >-1)
                                    {
                                                if (collButton[ID_Pressed].action == "makeExport")
                                                {
                                                            ref.Export(); 
                                                            collButton[ID_Pressed].pressed = false; 
                                                            ID_LastPressed = ID_Pressed ;          
                                                            ID_Pressed = -1;
                                                }
                                    }
                        }

                        else
                        {
                                    boolean someSelect = false;

                                    for( int i = 0; i < area.length; i++)
                                    {
                                                if(area[i].isOver) 
                                                {
                                                            area[i].isSelected = true;
                                                            someSelect = true;
                                                            break;
                                                }
                                    }
                                    for( int i = 0; i < S.length; i++)
                                    {
                                                if(S[i].isOver) 
                                                {
                                                            S[i].isSelected = true;
                                                            someSelect = true;
                                                            break;
                                                }
                                    }
                                    for( int i = 0; i < A.length; i++)
                                    {
                                                if(A[i].isOver) 
                                                {
                                                            A[i].isSelected = true;
                                                            someSelect = true;
                                                            break;
                                                }
                                    }
                                    for( int i = 0; i < F.length; i++)
                                    {
                                                if(F[i].isOver) 
                                                {
                                                            F[i].isSelected = true;
                                                            someSelect = true;
                                                            break;
                                                }
                                    }

                                    if(! someSelect) 
                                    {
                                                for( int i = 0; i < area.length; i++)
                                                {           
                                                            area[i].isSelected = false;
                                                }    
                                                for( int i = 0; i < S.length; i++)
                                                {           
                                                            S[i].isSelected = false;
                                                }    
                                                for( int i = 0; i < A.length; i++)
                                                {           
                                                            A[i].isSelected = false;
                                                }       
                                                for( int i = 0; i < F.length; i++)
                                                {           
                                                            F[i].isSelected = false;
                                                }          
                                    }
                        }

            }

            void RClick()
            {
                        if(ID_Pressed >-1) 
                        {
                                    collButton[ID_Pressed].pressed = false; 
                                    ID_LastPressed = ID_Pressed ;  
                                    ID_Pressed  = -1;
                        }
                        else 
                        {
                                    if(ID_LastPressed != -1)
                                    {
                                                collButton[ID_LastPressed].pressed = true; 
                                                ID_Pressed  = ID_LastPressed;     
                                    }       
                        }
            }

            void Draw()
            {
                        // toolbar cara
                        stroke(120);
                        line(2,20,2,height-20);
                         line(w,20,w,height-20);


                        // vykresli tlacitka
                        for(int i = 0; i < collButton.length; i++)
                        {
                                    collButton[i].Draw();
                        }

fill(200);
                        String[] info;
                        for(int i = 0; i < F.length; i ++)
                        {
                                    if(F[i].isSelected)
                                    {
                                                info = F[i].GetInfo();
                                                for(int m = 0 ; m < info.length; m++)
                                                {
                                                            text(info[m],20,200+fontSize*m);           
                                                }
                                    }
                        }
                        for(int i = 0; i < A.length; i ++)
                        {
                                    if(A[i].isSelected)
                                    {
                                                info = A[i].GetInfo();
                                                for(int m = 0 ; m < info.length; m++)
                                                {
                                                            text(info[m],20,200+fontSize*m);           
                                                }
                                    }
                        }
                         for(int i = 0; i < area.length; i ++)
                        {
                                    if(area[i].isSelected)
                                    {
                                                info = area[i].GetInfo();
                                                for(int m = 0 ; m < info.length; m++)
                                                {
                                                            text(info[m],20,200+fontSize*m);           
                                                }
                                    }
                        }


                        text("FrameRate : " + frameRate, 20, height -50);
                        text("numberOfAnt : " + numberOfAnt, 20, height -35);
                        text("numberOfFeromon : " + numberOfFeromon, 20, height -20);
            }

}

class Button 
{
            PImage ikona[];
            int x, y, w, h, ID;
            boolean permanentAction;
            boolean pressed;
            boolean imageLoaded;
            String action;

            Button(int scrX, int scrY, int toolW, int toolH)
            {
                        x = scrX;
                        y = scrY;
                        w = toolW;
                        h = toolH;
            }

            void LoadImage(String fileName)
            {
                        String path =  ref.path + "/picture/";

                        ikona = new PImage[3];
                        String name[] = new String[3];

                        name[0] = "Button_"+fileName+"_Basic";
                        name[1] = "Button_"+fileName+"_Blue";
                        name[2] = "Button_"+fileName+"_Orange";

                        for(int i = 0; i < name.length; i++)
                        {
                                    ikona[i] = loadImage(path+name[i]+".png");
                        }
                        imageLoaded = true;
            }

            void SetAction(String name)
            {
                        action = name;
            }

            boolean IsOver()
            {
                        if (x<mouseX && mouseX<(x+w))
                        {
                                    if (y<mouseY && mouseY<(y+h))
                                    {
                                                return true;
                                    }
                        }
                        return false;
            }

            void Draw()
            {
                        if (imageLoaded)
                        {
                                    if(pressed)  image(ikona[2],x,y);
                                    else   if(IsOver())  image(ikona[1],x,y);
                                    else image(ikona[0],x,y);
                        }
                        else
                        {
                                    if(pressed)  
                                    {
                                                fill(255); 
                                                rect(x,y,w,h);
                                    }
                                    else   if(IsOver())  
                                    {
                                                fill(150); 
                                                rect(x,y,w,h);
                                    }
                                    else 
                                    {
                                                noFill(); 
                                                rect(x,y,w,h);
                                    }
                        }
            }


}

void ControlSetup()
{
            Button spray = new Button(20,20,50,50);
            spray.permanentAction = true;
            spray.SetAction("makeSpray");
            spray.LoadImage("Spray");
            tool.AddControl(spray);

            Button block = new Button(80,20,50,50);
            block.permanentAction = true;
            block.LoadImage("Wall");
            block.SetAction("makeWall");
            tool.AddControl(block);

            Button im = new Button(20,height-300,50,50);
            im.LoadImage("Import");
            im.SetAction("makeImport");
            tool.AddControl(im);

            Button export = new Button(80,height-300,50,50);
            export.LoadImage("Export");
            export.SetAction("makeExport");
            tool.AddControl(export);

            Button tArea = new Button(20, 80, 50,50);
            tArea.permanentAction = true;
            tArea.SetAction("testArea");
            tool.AddControl(tArea);



}




























































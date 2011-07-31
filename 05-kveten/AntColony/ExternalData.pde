
class ExternalData
{
  String path;
  float scaleKoef = 0.007;

  ExternalData()
  {
    this.path = sketchPath;
  }

  void Import()
  {
    int noPt, noLine;
    noPt = noLine = 0;
    while(true)
    {
      try{

        String radek[] = loadStrings(path + "/data/import.txt");
        for (int i=0; i < radek.length; i++)
        {
          String[] data = split(radek[i], " ");

          if(data[0].equals("pt"))
          {
            new Spray(float(data[1])*scaleKoef,float(data[2])*scaleKoef,float(data[3])*scaleKoef);
            noPt++;
          }
          if(data[0].equals("ln"))
          {
            Wall w = new Wall(new Point(float(data[1])*scaleKoef,float(data[2])*scaleKoef,0) , new Point(float(data[4])*scaleKoef,float(data[5])*scaleKoef,0));
            w.AddWall();
            noLine++;
          }
        }    
        println("nactena data ze souboru import.txt : " + noPt + " Spray; " + noLine + " Wall" ); 

        break;
      }
      catch(NullPointerException e) 
      {
        continue;
      }
    }

  }

  void Export()
  {
    int noPt =0;
    int noPolyline = 0;
    int noSeg;

    while(true)
    {
      try{

        String[] radek = new String[0];

        // zapis kotev
        for (int i = 0; i < F.length ; i++)
        {
          radek = (String[]) append(radek, "pt "+ noPt + " " + F[i].origin.x*1/scaleKoef + " " + F[i].origin.y*1/scaleKoef + " " + F[i].origin.z*1/scaleKoef + "\t");
          noPt++;
        }
        /*
                         // zapis retezu
         for(int i = 0 ; i < R.length; i++)
         {
         String temp = "polyline "+ noPolyline +  " " + R[i].noSegment + " ";
         noSeg = 0;
         for(int j = 0; j < R[i].seg.length; j++)
         {
         temp += R[i].seg[j].origin.x*1/scaleKoef + " " + R[i].seg[j].origin.y*1/scaleKoef + " " + R[i].seg[j].origin.z*1/scaleKoef + " ";           
         noSeg++;
         }
         temp += "\t";
         radek = (String[]) append(radek,temp);
         noPolyline++;
         }
         
         for(int i = 0 ; i < Konz.length; i++)
         {
         String temp = "polyline "+ noPolyline +  " " + 2 + " ";
         
         temp += Konz[i].ptStart.origin.x*1/scaleKoef + " " + Konz[i].ptStart.origin.y*1/scaleKoef + " " + Konz[i].ptStart.origin.z*1/scaleKoef + " ";           
         temp += Konz[i].ptEnd.origin.x*1/scaleKoef + " " + Konz[i].ptEnd.origin.y*1/scaleKoef + " " + Konz[i].ptEnd.origin.z*1/scaleKoef + " ";   
         
         temp += "\t";
         radek = (String[]) append(radek,temp);
         noPolyline++;
         }
         */

        saveStrings(path + "/data/export.txt", radek);
        println("zapsana data do souboru export.txt"); 

        break;
      }
      catch(NullPointerException e) 
      {
        createOutput(path + "/data/export.txt");
      }
    }

  }

  void Load()
  {
    // DOPSAT VYBER SOUBORU K NACTENI

    int noPt =0;
    /*
                        while(true)
     {
     try{
     // pri loadu smaze Kotvay na scene
     // NEFUNGUJE DOBRE            
     for (int i = 0; i<K.length; i++)
     {
     K[i].Destroy();           
     }
     
     // nacitani souboru
     String radek[] = loadStrings(path + "/save.txt");
     for (int i=0; i < radek.length; i++)
     {
     String[] data = split(radek[i], " ");
     
     if(data[0].equals("pt"))
     {
     new Kotva(new Point(float(data[1]),float(data[2]),float(data[3])));
     noPt++;
     }
     }    
     println("nactena data ze souboru save.txt : " + noPt + " Kotev" ); 
     
     break;
     }
     catch(NullPointerException e) 
     {
     continue;
     }
     }
     */
  }

  void Save()
  {
    // DOPSAT VYBER SOUBORU K ULOZENI

    int noPt =0;
    /*
                        while(true)
     {
     try{
     
     String[] radek = new String[K.length];
     for (int i = 0; i < K.length ; i++)
     {
     radek[i] = "pt " + K[i].origin.x + " " + K[i].origin.y + " " + K[i].origin.z + "\t";
     noPt++;
     }
     saveStrings(path + "/save.txt", radek);
     println("uspesne ulozeni do souboru save.txt : " + noPt + " Kotev" ); 
     
     break;
     }
     catch(NullPointerException e) 
     {
     createOutput(path + "/save.txt");
     }
     }
     */
  }

}





































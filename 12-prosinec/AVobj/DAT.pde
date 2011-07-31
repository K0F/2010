
// this signal uses the mouseX and mouseY position to build a signal
class Data implements AudioSignal
{
  /*void generate(float[] samp)
  {
    float range = 1;
    float peaks = 1;
    float inter = float(samp.length) / peaks;
    
    for ( int i = 0; i < samp.length; i += inter )
    {
      for ( int j = 0; j < inter && (i+j) < samp.length; j++ )
      {
        samp[i + j] = map(j, 0, inter, -range, range);
      }
    }
    
  }*/
 
 
   void generate(int id,float[] samp){
     for ( int i = 0; i < samp.length; i += 1 )
    {
     samp[i] = samp[i]+random(-.1,.1);
    } 
   }

  // this is a stricly mono signal
  void generate(float[] left, float[] right)
  {
    generate(left);
    generate(right);
  }
}


static int seed;
static int countNext;

class PseudoRandom
{
            int radku, sloupcu;
            float[][] nahodneCislo;

            public PseudoRandom(int radku, int sloupcu)
            {
                        seed++;
                        Random rnd = new Random(seed);
                        this.radku = radku;
                        this.sloupcu = sloupcu;

                        nahodneCislo = new float[0][0];

                        for (int i = 0; i < radku; i++)
                        {
                                    float[] temp = new float[sloupcu + i];
                                    for (int k = 0; k < sloupcu + i; k++)
                                    {
                                                temp[k] = random(-1,1);
                                    }
                                    temp[0] = 0;
                                    nahodneCislo = (float[][]) append(nahodneCislo,temp);
                        }
            }

            public float Next()
            {
                        float answ = 0;

                        for (int i = 0; i < radku; i++)
                        {
                                    int zbytek = (countNext * (i + 1)) % nahodneCislo[i].length;
                                    answ += nahodneCislo[i][zbytek];
                        }
                        answ /= radku;

                        countNext++;
                        return (answ);
            }
}



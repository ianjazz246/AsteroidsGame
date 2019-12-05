public class Explosion extends Floater
{
    private int explodeStartTime, explodeDuration;

    public Explosion(
        double myCenterX, double myCenterY,
        double myDirectionX, double myDirectionY,
        double myPointDirection,
        int explodeDuration
    )
    {
        this.myCenterX = myCenterX;
        this.myCenterY = myCenterY;
        this.myDirectionX = myDirectionX;
        this.myDirectionY = myDirectionY;

        this.explodeStartTime = 0;
        this.explodeDuration = explodeDuration;

    }
    public void show()
    {
        int currTime = millis();
        if (currTime - this.explodeStartTime > this.explodeDuration)
        {
            for (int i = 0; i < 5; i++)
            {
                int innerRadius = 1;
                int outerRadius = currTime / 100;
                int angle = 360 / i;
                line(
                    (float)(innerRadius * Math.cos(angle) - innerRadius * Math.sin(angle) + this.myCenterX),
                    (float)(innerRadius * Math.sin(angle) + innerRadius * Math.cos(angle) + this.myCenterY),
                    (float)((innerRadius + 5) * Math.cos(angle) - innerRadius * Math.sin(angle) + this.myCenterX),
                    (float)((innerRadius + 5) * Math.sin(angle) + innerRadius * Math.cos(angle) + this.myCenterY)
                );
            }
        }
        else
        {
        	explosionList.remove(this);
        }
    }




        public void startExplode()
        {
            this.explodeStartTime = millis();
        }

        public boolean isExploding()
        {
            return this.explodeStartTime != 0;
        }
    }
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
        if (currTime - this.explodeStartTime < this.explodeDuration)
        {
            for (int i = 0; i < 9; i++)
            {
                int innerRadius = 5;
                int outerRadius = 10 * (currTime - this.explodeStartTime) / this.explodeDuration;
                double angle = 2*Math.PI * i/8;
                line(
                    (float)(innerRadius * Math.cos(angle) - 0*Math.sin(angle) + this.myCenterX),
                    (float)(innerRadius * Math.sin(angle) + 0*Math.cos(angle) + this.myCenterY),
                    (float)((innerRadius + outerRadius) * Math.cos(angle) -  0*Math.sin(angle) + this.myCenterX),
                    (float)((innerRadius + outerRadius) * Math.sin(angle) +  0*Math.cos(angle) + this.myCenterY)
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
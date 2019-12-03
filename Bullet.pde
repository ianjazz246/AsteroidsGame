class Bullet extends Floater {
  boolean dead;
  Bullet(
    int myColor, 
    double myCenterX, double myCenterY, 
    double myDirectionX, double myDirectionY, 
    double myPointDirection
    )
  {
    this.myColor = myColor;
    this.myCenterX = myCenterX;
    this.myCenterY = myCenterY;
    this.myDirectionX = myDirectionX;
    this.myDirectionY = myDirectionY;
    this.myPointDirection = myPointDirection;

    this.dead = false;
  }
  
  public void show() {
    fill(this.myColor);
    ellipse((float)this.myCenterX, (float)this.myCenterY, 3, 3); 
  }

  public void move() {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //set death if outside of bounds
    if (myCenterX > width || myCenterX < 0 || myCenterY > height || myCenterY < 0) 
    {     
      this.dead = true;
    }
  }

  public boolean isDead() {
    return this.dead;
  }
}

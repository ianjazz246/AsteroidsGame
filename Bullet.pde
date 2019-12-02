class Bullet extends Floater {
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
  }
  
  public void show() {
    fill(this.myColor);
    ellipse((float)this.myCenterX, (float)this.myCenterX, 3, 3); 
  }
}

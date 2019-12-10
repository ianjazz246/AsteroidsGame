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
		//						get Red 										blue 											green   through bit shifts
		stroke(color(this.myColor >> 16 & 0xFF, this.myColor >> 8 & 0xFF, this.myColor & 0xFF));
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

	public double getX() {
		return this.myCenterX;
	}
	public double getY() {
		return this.myCenterY;
	}
}

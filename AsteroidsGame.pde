// import java.util.Scanner;

//your variable declarations here
Spaceship spaceship;
ArrayList<Star> starList;
ArrayList<Asteroid> asteroidList;
ArrayList<Bullet> bulletList;
ArrayList<Explosion> explosionList;
boolean accelerating;
//turn right key is down
boolean rightDown;
//turn lef tkey is down
boolean leftDown;
//currently in hyperspace
boolean hyperspace;
//firing button is down
boolean fireDown;

boolean isGameOver;

PImage heartImg;


//temporary
int[] asteroidVertexesX = /*{5, 5, -5, -5};*/ {15, 8, 0, -7, -14, -8, -6, 0, 8};
int[] asteroidVertexesY = /*{5, -5, -5, 5};*/ {3, 6, 8, 4, -2, -8, -10, -12, -4};
int[] shipVertexesX = {-8, 16, -8};
int[] shipVertexesY = {-8, 0, 8};

public void setup()
{
    //your code here
    size(500, 500);


    spaceship = new Spaceship(3, new int[] {-8, 16, -8}, new int[] {-8, 0, 8}, color(255), width / 2, height / 2, 0, 0, 0);
    starList = new ArrayList<Star>();
    for (int i = 0; i < 50; i++)
    {
        starList.add(new Star((int)(width * Math.random()), (int)(height * Math.random())));
    }

    asteroidList = new ArrayList<Asteroid>();
    //int[] asteroidVertexesX = {15, 8, 0, -7, -14, -8, -6, 0, 8};
    //int[] asteroidVertexesY = {3, 6, 8, 4, -2, -8, -10, -12, -4};
    for (int i = 0; i < 15; i++)
    {
        asteroidList.add(new Asteroid(asteroidVertexesX.length, asteroidVertexesX, asteroidVertexesY, color(240), Math.random() * width, Math.random() * height, Math.random() * 5 - 2, Math.random() * 5 - 2, Math.random() * 360, Math.random() * 5 - 2));
    }
    //asteroidList.add(new Asteroid(asteroidVertexesX.length, asteroidVertexesX, asteroidVertexesY, color(240), 300, 300, 0, 0, Math.random() * 360, 0));
    accelerating = false;
    rightDown = false;
    leftDown = false;
    fireDown = false;

    isGameOver = false;

    bulletList = new ArrayList<Bullet>();
    //bulletList.add(new Bullet(color(125), 300, 300, 2, 2, 90));
    explosionList = new ArrayList<Explosion>();
    // explosionList.add(new Explosion(200, 200, 5, 5, 3, 1000));
    // explosionList.get(0).startExplode();


    //heart image from https://www.needpix.com/photo/1138710/pixel-heart-heart-pixel-symbol-red-valentine-romantic-shape-pixelated
    heartImg = loadImage("pixel-heart.png");

}
public void draw()
{
    if (!isGameOver)
    {
        background(0);
        //spaceship.setX(mouseX);
        //spaceship.setY(mouseY);
        //text(mouseX + " " + mouseY, 20, 30);
        //spaceship.setX(355);
        //spaceship.setY(258);
        spaceship.show(accelerating);
        spaceship.move();
        if (fireDown)
        {
            Bullet newBullet = spaceship.fireBullet();
            if (newBullet != null)
            {
                bulletList.add(newBullet);
            }
        }


        for (Star i : starList)
        {
            i.show();
        }

        for (int i = explosionList.size() - 1; i > -1; i--)
        {
            explosionList.get(i).show();
        }

        for (int i = bulletList.size() - 1; i >= 0; i--)
        {
            Bullet bullet = bulletList.get(i);
            bullet.move();
            if (bullet.isDead())
            {
                bulletList.remove(i);
                continue;
            }
            bullet.show();
        }

        //check collisions
        //Todo: Grid to reduce amount of checking
        for (int i = asteroidList.size() - 1; i >= 0; i--)
        {
            boolean collision = false;
            Asteroid asteroid = asteroidList.get(i);
            if (dist((float)asteroid.getX(), (float)asteroid.getY(), (float)spaceship.getX(), (float)spaceship.getY()) < 60)
            {
                //between ship and asteroid collision

                //implement SAT collision detection
                //https://gamedevelopment.tutsplus.com/tutorials/collision-detection-using-the-separating-axis-theorem--gamedev-169
                //get vertexes from asteroids instead next time

                if (true)
                {
                    double[] shiftedAsteroidVertexesX = new double[asteroidVertexesX.length];
                    double[] shiftedAsteroidVertexesY = new double[asteroidVertexesY.length];
                    //double[] shiftedAsteroidVertexesX, shiftedAsteroidVertexesY, shiftedShipVertexesX, shiftedShipVertexesY;
                    //shift vertexes by the center positions and then rotate around center point

                    shiftRotatePoints(asteroidVertexesX, asteroidVertexesY, asteroid.getX(), asteroid.getY(), asteroid.getPointDirection(), shiftedAsteroidVertexesX,  shiftedAsteroidVertexesY);

                    double[] shiftedShipVertexesX = new double[shipVertexesX.length];
                    double[] shiftedShipVertexesY = new double[shipVertexesX.length];

                    shiftRotatePoints(shipVertexesX, shipVertexesY, spaceship.getX(), spaceship.getY(), spaceship.getPointDirection(), shiftedShipVertexesX,  shiftedShipVertexesY);

                    Point[] shipNormals = new Point[shipVertexesX.length]; //<>//

                    //Calculate normal of each side in the shipvertex //<>//
                    for (int j = 0; j < shipVertexesX.length - 1; j++)
                    {
                        shipNormals[j] = calcNormal(shiftedShipVertexesX[j + 1], shiftedShipVertexesY[j + 1], shiftedShipVertexesX[j], shiftedShipVertexesY[j]);
                    }
                    shipNormals[shipNormals.length - 1] = calcNormal(shiftedShipVertexesX[shipNormals.length - 1], shiftedShipVertexesY[shipNormals.length - 1], shiftedShipVertexesX[0], shiftedShipVertexesY[0]);

                    Point[] asteroidNormals = new Point[asteroidVertexesX.length];

                    for (int j = 0; j < asteroidVertexesX.length - 1; j++)
                    {
                        asteroidNormals[j] = calcNormal(shiftedAsteroidVertexesX[j + 1], shiftedAsteroidVertexesY[j + 1], shiftedAsteroidVertexesX[j], shiftedAsteroidVertexesY[j]);
                    }

                    asteroidNormals[asteroidNormals.length - 1] = calcNormal(shiftedAsteroidVertexesX[asteroidNormals.length - 1], shiftedAsteroidVertexesY[asteroidNormals.length - 1], shiftedAsteroidVertexesX[0], shiftedAsteroidVertexesY[0]);

                    for (int j = 0; j < shipNormals.length; j++)
                    {
                        collision = checkCollision(shipNormals[j], shiftedShipVertexesX, shiftedShipVertexesY, shiftedAsteroidVertexesX, shiftedAsteroidVertexesY);
                        if (!collision)
                        {
                            break;
                        }
                    }
                    if (collision)
                    {
                        for (int j = 0; j < asteroidNormals.length; j++)
                        {
                            collision = checkCollision(asteroidNormals[j], shiftedShipVertexesX, shiftedShipVertexesY, shiftedAsteroidVertexesX, shiftedAsteroidVertexesY);
                            if (!collision)
                            {
                                break;
                            }
                        }
                    }

                    if (collision)
                    {
                        //handle collision

                        if (spaceship.reduceLives() < 1)
                        {
                            gameOver();
                        }

                    }
                    else
                    {
                        //System.out.println("No Collision");
                    }

                    //System.out.println("Going");
                    //loop through each vertex of the asteroid
                    /*for (int j = 0; j < asteroidVertexesX.length; j++)
                    {

                    	//calculate left normal of each side of each shape
                    	//System.out.println("Iteration" + j);
                    	double asteroidNormalX;
                    	double asteroidNormalY;

                    	//if on last vertex of the side, go back to first
                    	if (j == shiftedAsteroidVertexesX.length - 1)
                    	{
                    	asteroidNormalX = shiftedAsteroidVertexesY[0] - shiftedAsteroidVertexesY[j];
                    	asteroidNormalY = -(shiftedAsteroidVertexesX[0] - shiftedAsteroidVertexesX[j]);
                    	} else
                    	{
                    	asteroidNormalX = shiftedAsteroidVertexesY[j+1] - shiftedAsteroidVertexesY[j];
                    	asteroidNormalY = -(shiftedAsteroidVertexesX[j+1] - shiftedAsteroidVertexesX[j]);
                    	}


                    	double shipMax, shipMin;
                    	double asteroidMax, asteroidMin;
                    	shipMax = shipMin = shiftedShipVertexesX[0] * asteroidNormalX + shiftedShipVertexesY[0] * asteroidNormalY;
                    	asteroidMax = asteroidMin = shiftedAsteroidVertexesX[0] * asteroidNormalX + shiftedAsteroidVertexesY[0] * asteroidNormalY;

                    	//for each vertex, project onto normal
                    	for (int k = 0; k < shiftedAsteroidVertexesX.length; k++)
                    	{
                    	double projection = shiftedAsteroidVertexesX[k] * asteroidNormalX + shiftedAsteroidVertexesY[k] * asteroidNormalY;

                    	if (projection > asteroidMax)
                    	{
                    		asteroidMax = projection;
                    	} else if (projection < asteroidMin)
                    	{
                    		asteroidMin = projection;
                    	}
                    	}

                    	for (int k = 0; k < shiftedShipVertexesX.length; k++)
                    	{
                    	double projection = shiftedShipVertexesX[k] * asteroidNormalX + shiftedShipVertexesY[k] * asteroidNormalY;

                    	if (projection > shipMax)
                    	{
                    		shipMax = projection;
                    	} else if (projection < shipMin)
                    	{
                    		shipMin = projection;
                    	}
                    	}


                    	//System.out.println("Calculated Normals");
                    	//check if there is a gap
                    	//if so, doesn't collide
                    	if (asteroidMax < shipMin || shipMax < asteroidMin)
                    	{
                    	//System.out.println("No collision");
                    	collision = false;
                    	break;
                    	}
                    	else
                    	{
                    	collision = true;
                    	}
                    }

                    if (collision)
                    	{
                    	System.out.println("collision");
                    	asteroidList.remove(i);
                    	}
                    	else
                    	{
                    	System.out.println("No Collision");
                    	}*/
                }
            }
            if (!collision)
            {
                for (int j = bulletList.size() - 1; j > -1; j--)
                {
                    Bullet bullet = bulletList.get(j);
                    if (dist((float)bullet.getX(), (float)bullet.getY(), (float)asteroid.getX(), (float)asteroid.getY()) < 20)
                    {
                        for (int k = 0; k < asteroidVertexesX.length - 1; k++)
                        {
                            //collosion if distance between bullet and asteroid vertexes less than 3
                            //Technically would miss collisions, but because of small asteroid size and its rotation, it gets most of them
                            if (dist((float)(asteroidVertexesX[k] + asteroid.getX()), (float)(asteroidVertexesY[k] + asteroid.getY()), (float)bullet.getX(), (float)bullet.getY()) < 3 ||
                                    dist((float)(asteroidVertexesX[k + 1] + asteroid.getX()), (float)(asteroidVertexesY[k + 1] + asteroid.getY()), (float)bullet.getX(), (float)bullet.getY()) < 3)
                            {
                                collision = true;
                                bulletList.remove(j);
                                break;
                            }
                        }
                    }
                }
            }
            if (collision)
            {
                asteroidList.remove(i);
                Explosion newExplosion = new Explosion(asteroid.getX(), asteroid.getY(), 0, 0, 0, 200);
                explosionList.add(newExplosion);
                newExplosion.startExplode();
                if (asteroidList.size() < 1)
                {
                    gameOver();
                }
            }
            else
            {
                asteroid.move();
                asteroid.show();
            }
        }

        if (!spaceship.inHyperspace())
        {
            if (accelerating)
            {
                spaceship.accelerate(0.1);
            }

            if (leftDown && rightDown == false)
            {
                spaceship.turn(-4);
            }
            else if (rightDown && leftDown == false)
            {
                spaceship.turn(4);
            }
        }

        //---------------
        //Draw UI
        //--------------
        //Lives indicator
        fill(255);
        textSize(12);
        textAlign(CENTER, CENTER);
        image(heartImg, width - 40, 5, 20, 20);
        text(spaceship.getLives(), width - 15, 13);

        generateRandomConvex(4, 16);
    }
}

public void keyPressed()
{
    switch(key)
    {
    case 'w':
    case 'W':
        accelerating = true;
        break;
    case 's':
    case 'S':
        accelerating = false;
        break;
    case 'a':
    case 'A':
        leftDown = true;
        break;
    case 'd':
    case 'D':
        rightDown = true;
        break;
    case 'f':
    case 'F':
        spaceship.hyperspace();
        break;
    case 'r':
    case 'R':
        if (isGameOver)
        {
            setup();
            loop();
        }
        break;
    case ' ':
        fireDown = true;
        break;
    }
}

public void keyReleased()
{
    switch(key)
    {
    case 'w':
    case 'W':
        accelerating = false;
        break;
    /*case 's':
    			case 'S':
    				accelerating = false;
    				break;*/
    case 'a':
    case 'A':
        leftDown = false;
        break;
    case 'd':
    case 'D':
        rightDown = false;
        break;
    case ' ':
        fireDown = false;
        break;
    }
}

public void gameOver()
{
    fill(255);
    textSize(40);
    textAlign(CENTER, CENTER);
    isGameOver = true;
    if (asteroidList.size() > 0)
    {
        text("Game Over", width / 2, height / 2);
    }
    else
    {
        text("You win!", width / 2, height / 2);
    }
}


//--------
//util functions and classes
//--------

class Point
{
    private double x;
    private double y;

    Point(double x, double y)
    {
        this.x = x;
        this.y = y;
    }

    public double getX()
    {
        return this.x;
    }
    public double getY()
    {
        return this.y;
    }
    public void setX(double newX)
    {
        this.x = newX;
    }
    public void setY(double newY)
    {
        this.y = newY;
    }
}

public Point calcNormal(double x1, double y1, double x2, double y2)
{
    return new Point(y1 - y2, -(x1 - x2));
}

public boolean checkCollision(Point normal, double[] x1, double[] y1, double[] x2, double[] y2)
{
    double[] minMax1 = findMinMaxProjection(normal, x1, y1);
    double[] minMax2 = findMinMaxProjection(normal, x2, y2);

    boolean collision = false;

    if (minMax1[1] < minMax2[0] || minMax2[1] < minMax1[0])
    {
        return false;
    }
    else
    {
        return true;
    }


}

public double[] findMinMaxProjection(Point vector, double[] x, double[] y)
{
    double vectorX = vector.getX();
    double vectorY = vector.getY();

    double min, max;
    max = min = vectorX * x[0] + vectorY * y[0];

    //find object 1's projections
    for (int i = 1; i < x.length; i++)
    {
        double projection = vectorX * x[i] + vectorY * y[i];
        if (projection > max)
        {
            max = projection;
        }
        else if (projection < min)
        {
            min = projection;
        }
    }
    return new double[] {min, max};
}

public double[][] shiftRotatePoints(int[] vertexesX, int[] vertexesY, double x, double y, double angle, double[] outputArrayX, double[] outputArrayY)
{
    double[] newPointsX = new double[vertexesX.length];
    double[] newPointsY = new double[vertexesX.length];
    for (int i = 0; i < vertexesX.length; i++)
    {
        double translatedX = vertexesX[i] + x;
        double translatedY = vertexesY[i] + y;

        outputArrayX[i] = (translatedX - x) * Math.cos(angle) + x - (translatedY - y) * Math.sin(angle); //<>//
        outputArrayY[i] = (translatedX - x) * Math.sin(angle) + (translatedY - y) * Math.cos(angle) + y;
    } //<>//
    return new double[][] {outputArrayX, outputArrayY};
}

public double[][] shiftRotatePoints(int[] vertexesX, int[] vertexesY, double x, double y, double angle)
{
    double[] newPointsX = new double[vertexesX.length];
    double[] newPointsY = new double[vertexesX.length];
    double angleRad = Math.PI / 180 * angle;
    for (int i = 0; i < vertexesX.length; i++)
    {
        double translatedX = vertexesX[i] + x;
        double translatedY = vertexesY[i] + y;

        newPointsX[i] = (translatedX - x) * Math.cos(angleRad) + x - (translatedY - y) * Math.sin(angleRad);
        newPointsY[i] = (translatedX - x) * Math.sin(angleRad) + (translatedY - y) * Math.cos(angleRad) + y;
    }
    return new double[][] {newPointsX, newPointsY};
}

public int[][] generateRandomConvex(int numVertexes, int size)
{
    if (numVertexes < 3)
    {
        return null;
    }
    //Some extra amount
    int numRandomPoints = numVertexes * 5 + 10;
    ArrayList<Point> randomPoints = new ArrayList<Point>();
    //generate random points
    //x, y are in ranges from -size/2 to size/2, exclusive
    for(int i = 0; i < numRandomPoints; i++)
    {
        randomPoints.add(new Point((Math.random()-0.5) * size, (Math.random()-0.5) * size));
    }


    /*for (Point i : randomPoints) {
    	fill(255, 0, 0);
    	ellipse((float)(200 + i.getX()), (float)(200 + i.getY()), 5, 5);
    	noLoop();

    }*/

    //Graham scan

    ArrayList<Point> shapePoints = new ArrayList<Point>();
    Point minYPoint = randomPoints.get(0);
    for (Point i : randomPoints) {
    	if (i.getY() == minYPoint.getY()) {
    		if (i.getX() < minYPoint.getX()) {
    			minYPoint = i;
    		}
    	}
    	else if (i.getY() < minYPoint.getY()) {
    		minYPoint = i;
    	}
    }

    //sort by polar angle of point between lowest-Y point and itself
    //Collections.sort(numRandomPoints, )

    /*fill(0, 255, 0);
    ellipse((float)(200 + minYPoint.getX()), (float)(200 + minYPoint.getY()), 5, 5);*/


    return new int[][] {};
}

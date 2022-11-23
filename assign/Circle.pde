// Adapted from https://github.com/brianshaler/Circle-Packing-in-Processing

class Circle {
  int x, y, i;
  int radius;
  
  // Default is "not placed"
  boolean computed;
  
  Circle (int r, int num) {
    x=0; y=0;
    radius = r;
    i=num;
    computed=false;
  }
  
  Point[] computePosition (Circle[] c) {
    int i, j;
    boolean collision;
    Point[] openPoints = new Point[0];
    int ang;
    Point pnt;
    
    // This circle already placed, so just quit
    if (computed) { return(openPoints); }
    
    // Check all other circles currently in place
    for (i=0; i<c.length; i++)
    {
      if (c[i].computed)
      {
        for (ang=0; ang<360; ang++) // for each point on this "other" circle's circumference
        {
          collision = false;
          pnt = new Point();
          pnt.x = c[i].x + int(cos(ang*PI/180) * (radius+c[i].radius+1)); // int cast causes loss of precision
          pnt.y = c[i].y + int(sin(ang*PI/180) * (radius+c[i].radius+1));
          print("Ang "+ang+"...");
          for (j=0; j<c.length; j++)
          {
            if (c[j].computed && !collision)
            {
              // Two circles intersect if, and only if, the distance between 
              // their centre points is between the sum and the difference of their radii
              if (dist(pnt.x, pnt.y, c[j].x, c[j].y) < radius + c[j].radius)
              {
                collision = true;
              }
            }
          }
          
          if (!collision)
          {
            openPoints =  (Point[]) expand(openPoints, openPoints.length+1);
            openPoints[openPoints.length-1] = pnt;
            println("...adding new open point "+(openPoints.length-1)+" at "+pnt.x+", "+pnt.y+" with dist "+
            dist(pnt.x, pnt.y, cx, cy));
          }
     
        }
      }
    }
    
    float min_dist = -1;
    int best_point = 0;
    for (i=0; i<openPoints.length; i++)
    {
      if (min_dist == -1 || dist(cx, cy, openPoints[i].x, openPoints[i].y) < min_dist)
      {
        best_point = i;
        min_dist = dist(cx, cy, openPoints[i].x, openPoints[i].y);
        println("New best point "+i+" at "+openPoints[i].x+", "+ openPoints[i].y+" with dist "+min_dist);
      }
    }
    if (openPoints.length == 0)
    {
      println("no points?");
    } else
    {
      //println(openPoints.length + " points");
      x = openPoints[best_point].x;
      y = openPoints[best_point].y;
    }
    computed = true;
    return(openPoints);
  }
  
  void draw () 
  {
      fill(255);
      ellipseMode(CENTER);
      ellipse(x, y, radius*2, radius*2);
      fill(255,0,0);
      textFont(f,12);
      text(""+i, x, y);
  }
 
}
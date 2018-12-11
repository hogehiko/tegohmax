
class Box{
  double centerX = width/2;
  double centerY = height /2;
  
  double vectorX = 0;
  double vectorY = 0;
   
  int size = 0;
  int digree = 0;
  
  public int alpha = 255;
  
  void deformation(){
    digree++;
    size += 1;
    if(alpha > 0)
      alpha --;
  }
  
  int random(int min, int max){
    return min + (int)(Math.random() * (max-min));
  }
  
  void move(){
    double digree = Math.random() * 2 * PI;
    vectorX = Math.sin(digree) * size / 10;
    vectorY = Math.cos(digree) * size / 10;
  }
  
  void draw(){
    centerX += vectorX;
    centerY += vectorY;
    strokeWeight(3);
    translate((int)centerX, (int)centerY);
    rotate(PI * filterFreqRate);
    stroke(color(255,255, 255, alpha));
    noFill();
    rect(- size/2, - size /2, size, size);
    rotate(-PI * filterFreqRate);
    translate((int)-centerX, (int)-centerY);
    vectorX *= 0.9;
    vectorY *= 0.9;
  }
}
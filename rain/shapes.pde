class Note{
  public int note;
  public int velocity;
}
class RainDrop{
  int delay;
  int clock = 0;
  
  Note note;
  
  float INITIAL_SPEED=3;
  
  int AFTER_DELAY= 120;
  
  public RainDrop(int delay, Note note){
      this.delay = delay;
      this.note = note;
  }
  
  double centerX = width * Math.random();
  
  public void deformation(){
     clock++; 
  }
  
  float centerY(){
    float max_y_pos = 0.9*height;
    return  min(max_y_pos, max_y_pos * ((float) clock/delay));
  }
  
  float sizeX(){
     if(clock>=delay){
         return (clock-delay)*3;
     }else{
         return 1;
     }
  }
  
  float sizeY(){
     if(clock>=delay){
         return (clock-delay)*0.8;
     }else{
         return 1;
     }
  }
  
  int MAX_ALPHA=255;
  
  int alpha(){
    return min(MAX_ALPHA, max(0, (delay+AFTER_DELAY-clock) * (MAX_ALPHA/AFTER_DELAY)));
  }
  
  boolean lastClock(){
     return clock == delay; 
  }
  
  void draw(){
    if(note.velocity == 0)return;
    strokeWeight(3);    
    stroke(color(255,255, 255, alpha()));
    noFill();
    ellipse((int)centerX, centerY() , sizeX(),  sizeY());
     
  }
  
  
}

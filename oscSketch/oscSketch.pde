import oscP5.*;
import java.util.*;

OscP5 oscP5;

void setup(){
  oscP5 = new OscP5(this, 2346);
  size(400, 300);
  
}

List<Box> shapes = new ArrayList();

int INTERVAL = 60;
int count = 0;

int blur = 0;

int BLUR_INITIAL = 6;

void draw(){
  background(0);
  count++;
  if(count >= INTERVAL){
    shapes.add(new Box());
    count = 0;
  }
  
  for(Box b : shapes){
    b.deformation();
    b.draw();
  }
  
  if(shapes.size() > 0 && shapes.get(0).alpha <= 0){
    shapes.remove(0);
  }
  
  if(blur > 0){
    filter(BLUR, blur);
    blur--;
  }
}

synchronized void oscEvent(OscMessage msg){
  if(msg.checkAddrPattern("/Velocity1")==true) {
      println(msg.get(0).intValue());
      if(msg.get(0).intValue() != 0){
         for(Box b : shapes){
            b.move(); 
         }
        blur= BLUR_INITIAL; 
      }else{
        
      }
  }
  println(msg);
} 
import oscP5.*;
import netP5.*;
import java.util.*;
import java.lang.Thread;

OscP5 oscP5, oscP5Control;
NetAddress oscRemoteLocation;


void setup(){
  oscP5 = new OscP5(this, 2346);
  size(400, 300);
  oscRemoteLocation = new NetAddress("127.0.0.1", 2347);  
}

List<RainDrop> shapes = new ArrayList();

List<Note> notes = new ArrayList();

void draw(){
  synchronized(this){
    for(Note n: notes){
      shapes.add(new RainDrop(30, n)); 
       
    }
    notes = new ArrayList();
    
    background(128);
    for(RainDrop b : shapes){
      b.deformation();
      b.draw();
      
      if(b.lastClock()){
        OscMessage msg = new OscMessage("/midi/noteon");
        msg.add(1);
        msg.add(b.note.note);
        msg.add(b.note.velocity);
        oscP5.send(msg, oscRemoteLocation);
      }
    }
  
    Iterator<RainDrop> it = shapes.iterator();
    while(it.hasNext()){
      if(it.next().alpha() == 0){
         it.remove();
      }  
    }
    for(RainDrop r:shapes){
       if(r.alpha()==0){
          shapes.remove(r);
       }
    }
  }   
  
}


synchronized void oscEvent(OscMessage msg){

     if(msg.checkAddrPattern("/midi/noteon")==true) {

      int ch = msg.get(0).intValue();
      
      int n = msg.get(1).intValue();
      int v = msg.get(2).intValue();
      Note note = new Note();
      note.note = n;
      note.velocity = v;
      
      notes.add(note);
  }

} 

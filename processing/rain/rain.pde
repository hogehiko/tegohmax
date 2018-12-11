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

int minNote=Integer.MAX_VALUE, maxNote=Integer.MIN_VALUE;
void draw(){
  synchronized(this){
    for(Note n: notes){
      shapes.add(new RainDrop(30, n)); 
       
    }
    notes = new ArrayList();
    
    background(128);
    for(RainDrop b : shapes){
      minNote = min(minNote, b.note.note);
      maxNote = max(maxNote, b.note.note);
    }
    for(RainDrop b : shapes){
      b.deformation();
      b.draw(minNote, maxNote);
      
      if(b.lastClock()){
        oscP5.send(b.note.toOscMessage(), oscRemoteLocation);
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
      notes.add(new Note(msg));
  }
} 

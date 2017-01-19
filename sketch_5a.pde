float d;
float ex;
int dragX, dragY;
int moveX,moveY;
float easing = 0.05;


void setup(){
  size(500,500);
  for(int i=0; i<30; i++){
    Rect tempRect = new Rect();
    rectArray = (Rect[]) append(rectArray, tempRect);
  }
  

}
void draw(){
  cursor(CROSS);
  background(255,198,229);
  
  if (key == CODED) { 
  //click "UP" to move the rectangle up.
    if (keyCode == UP) {
      d = 0;
//click "DOWN" to move the rectangle down. (background)
    } else if (keyCode == DOWN) {
      d = 250;
    }
  } else {
    d = 0;
  }
  fill(255,70); //white color rectangle (half transparent)
  rect(0, d, 500, 250);

  if (mouseX < 250) { //when the mouseX more than 250
    fill(201,241,255,100);
    rect(0, 0, 250, 500); // Left Rectange (background)
  } else {
    fill(201,241,255,100);
    rect(250, 0, 250, 500); // Right rectange (background)
  }
  
  //mouse data
float z = mouseX;
float d = mouseY;
  float ix = width - mouseX; // Inverse X
  float iy = height - mouseY; // Inverse Y
//if mouseX is bigger than 250 and less than 500, mouse Y is bigger than 0 and less than 500, the circle will change its size.
  if ((mouseX > 250) && (mouseX < 500) && (mouseY > 0) && (mouseY < 500)) {
  fill(0, 50);
    }else{
      fill(0,80);
    }
      ellipse(ex, height/2, d, d);
  fill(255,50);
  ellipse(ix, height/2, iy, iy);
  
  float targetX = mouseX;
  float dx = targetX - ex;
  ex += dx * easing; //increase the size of circle
  
  float targetY = mouseY;
  float dy = targetY - d;
  d += dy * easing; //increase the size of circle

  for(int i=0; i < rectArray.length; i++){
    if(rectArray[i].status == 1){   //if alive then draw & move
      rectArray[i].drawRect();  //i = locker id
      rectArray[i].moveRect();
    }else{  //if dead, don't move it
      rectArray[i].drawRect();
    }
    float dist = dist(mouseX,mouseY,rectArray[i].x,rectArray[i].y);
    if(dist <= rectArray[i].radius){
      rectArray[i].status = 0;  //set status to "dead"
    }
  }
  
        
rect(dragX-40,dragY-40,80,80);
 
    if (keyPressed == true) { // If the key is pressed,
ellipse(mouseX, mouseY, 50, 50); //draw a ball.
   
  } else { // Otherwise,

rect(mouseX-25,mouseY-25,50,50);


  }
  
}
class Rect{
  float x, y, radius, alpha;    //attributes
  color fillCol, strokeCol;     //attributes
  float pn, pn1, pn2;                     //perlin noise
  int status;  //0=dead, 1=alive
  Rect(){                     //constructor
    status = 1;  //alive
    pn = random(width);  
    pn1 = random(height);
    pn2 = random(300);
    fillCol = color(random(200),random(200),random(200));
  }
  void drawRect(){            //method (job)
    noStroke();
    fill(fillCol,alpha);
    rect(x,y,radius*2,radius*2);
  }
  void moveRect(){
    pn = pn + 0.0015;  //increment perlin noise variable
    pn1 = pn1 + 0.0015;
    pn2 = pn2 + 0.015;
    x = map(noise(pn),0,1,0,width);
    y = map(noise(pn1),0,1,0,height);
    radius = map(noise(pn2),0,1,0,45);
    alpha = map(noise(pn),0,1,0,200);
  }
}
Rect[] rectArray = {};  //define & create array (lockers)

void mousePressed(){
  Rect tempRect = new Rect();
  rectArray = (Rect[]) append(rectArray, tempRect);
}
void mouseMoved() { 
  moveX = mouseX;
  moveY = mouseY;
}

void mouseDragged() { 
  dragX = mouseX;
  dragY = mouseY;
}

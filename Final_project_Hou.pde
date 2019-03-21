//Yuhan Hou

// menu
  //name of game, author
  //start
  //quit
  //instruction menu

//difficulty selection
  //easy: fewer bubbles and colors, speed of generating new ones slow
  //hard: more colors and bubbles, speed of generating new ones fast
  //main menu

//game
  //checkBoundary();
  
  //checkCollision();
  
    //popBubbles();
      //gameOver();
    
    //sound,image
    
  //displayGun();
    //mouse control
    //clicked
    
    //key control
    //press r to restart when game over
     
    //shoot
    //point ball
      
  //timer Class
    //after some time points have to be that much when new appears
    
  //displayScore();
  
  //displayBubbles();
import processing.sound.*;
SoundFile file,file1,file2,file3;
PImage bg,bg1,bg2;
boolean mainMenu, instructionMenu, easyGame, difficultGame, restart,select;
Timer timer1,timer2,timer3,timer4;
float x = 300;
float y = 590;
float dx = 3;
float dy = -5;
int temp;
int count=0;
int points=0;
float h=600;
boolean[][] inside=new boolean[5][20];//easy level bubbles
boolean[][] inside1=new boolean[10][20];//difficult level bubbles
color[] color1=new color[3];//for easy level colors
color[] color2=new color[6];//for difficult level colors
void setup(){
  size(600,600);
   frameRate(60);
  smooth();
  bg=loadImage("bg.jpg");
  bg1=loadImage("bg1.jpg");
  bg2=loadImage("bg2.jpg");
  file=new SoundFile(this,"bubble.mp3");
  file1=new SoundFile(this,"magic.mp3");
  file2=new SoundFile(this,"fail.mp3");
  file3=new SoundFile(this,"click.mp3");
  initGame();         
}
void draw(){
  if(mainMenu){          
    displayMenu();
    file1.play();
  }
  else if(instructionMenu){
    displayInstruction();
  }
  else if(select){
    displaySelection();
  }
  else if(easyGame){
    displayeasyLevel();
  }
  else if(difficultGame){
    displaydifficultLevel();
  }
}
void initGame(){
  mainMenu = true;
    instructionMenu = false;
    select=false;
    easyGame = false;
    difficultGame = false;
    restart=false;
  timer1=new Timer(10000);
  timer1.start();
  timer2=new Timer(5000);
  timer2.start();
  timer3=new Timer(40000);
  timer3.start();
  timer4=new Timer(30000);
  timer4.start();
   //intialize Bubble arrays with color arrays
   color1[0]=color(255,0,0);
 color1[1]=color(0,255,0);
 color1[2]=color(0,0,255);
 color2[0]=color(255,255,0);
 color2[1]=color(255,0,255);
 color2[2]=color(0,255,255);
 color2[3]=color(138,43,226);
 color2[4]=color(255,127,80);
 color2[5]=color(255,105,180);
}

void displayMenu(){
  //start, quit, go to instruction
  background(bg);
 fill(0);
  rect(80,40,500,100);
 rect(200,200,200,100);
 rect(200,400,200,100);
 textSize(80);
 fill(255,0,0);
 text("instructions", 100,115);
 text("start",210,280);
 text("quit",215,480);
}

void displayInstruction() {
  background(bg);
  fill(0);
  rect(40,500,550,80);            //main menu button
  fill(255,0,0);                //display instructions
  textSize(40);
  text("Instructions",200,40);
  fill(0);
  textSize(35);
  text("Move mouse to move bar" ,10,100);
  text("to control point ball,do not drop it!",6,150);
  text("Pop bubbles to get enough points",10,200);
  text("within certain time period.",10,250);
  text("pop fast!they will restore!",10,300);
  fill(255,0,0);
  text("Back to Menu", 200,550);
}

void displaySelection(){
  //go to choose levels
  background(bg);
  fill(0);
  rect(50,200,200,100);
  rect(300,200,250,100);
  textSize(50);
  fill(255,0,0);
  text("easy",60,250);
  text("difficult",350,250);
}

void displayeasyLevel(){//easy level game starts
 if(temp==0){
  background(bg1);
  displayGun();
  resetMatrix();
  stroke(0);
  strokeWeight(10);   //draw the point to hit bubbles
    point(x,y);
    strokeWeight(1);
    randomSeed(1);
    
  for(int i=0;i<inside.length;i++) {
    for(int j=0;j<inside[0].length;j++) {
      float dx2=15+30*j-x;
        float dy2=15+30*i-y;
        float dis2=sqrt(pow(dx2,2)+pow(dy2,2));//calculate distance
        if (dis2>=15.&& inside[i][j]==false) {
          fill(color1[(int)random(color1.length)]);   //draw bublles with colors
          ellipse(15+30*j,15+30*i,30,30);
   }
   else if (dx2<=(dis2*cos(PI/4))&& dy2<=-(dis2*sin(PI/4))&& inside[i][j]==false) {
          dy*=-1;
         inside[i][j]=true;   //pop bubbles when hit and inverse direction
          points++;         //pop one add one point
          file.play();
        }
        else if (dx2<=(dis2*cos(PI/4)) && dy2>=(dis2*sin(PI/4))&& inside[i][j]==false ) {
          dy*=-1;
          inside[i][j]=true;
          points++;
          file.play();
        }
        else if (dy2<=(dis2*sin(PI/4)) && dx2<=-(dis2*cos(PI/4)) && inside[i][j]==false) {
          dx*=-1;
          inside[i][j]=true;
          points++;
          file.play();
        }
        else if (dy2<=(dis2*sin(PI/4)) && dx2>=(dis2*cos(PI/4))&& inside[i][j]==false) {
          dx*=-1;
          inside[i][j]=true;
          points++;
          file.play();
        }
    }
    
    
  }
   h=mouseY;
 
    //draw Bar to bounce point ball on
    float bar=75.;
    strokeWeight(3);
    line(mouseX-bar,h,mouseX+bar,h);
    strokeWeight(1);
 
    // change direction if moving point hits boundaries
    if (x>=width || x<=0) {
      dx*=-1;
    }
     if (y<=0) {
      dy*=-1;
    }
    // change direction if moving point hits bar
    if (y>=h && y<h+10) {
      //left part
      if (x>(mouseX-bar) && x< (mouseX-(1./3)*bar) && dx>0 && dy>0) {
        dy*=-0.95;
        dx*=-1.05;
      }
      //left part
      else if (x>(mouseX-bar) && x< (mouseX-(1./3)*bar) && dx<0 && dy>0) {
        dy*=-0.95;
        dx*=1.05;
      }
      //right part
      else if (x>(mouseX+(1./3)*bar) && x< (mouseX+bar) && dx>0 && dy>0) {
        dy*=-0.95;
        dx*=1.05;
      }
      //right part
      else if (x>(mouseX+(1./3)*bar) && x< (mouseX+bar) && dx<0 && dy>0) {
        dy*=-0.95;
        dx*=-1.05;
      }
      //middle part
      else if (x>(mouseX-(1./3)*bar) && x< (mouseX+(1./3)*bar) && dy>0) {
        dy*=-1.05;
        dx*=0.95;
      }
    }
   
    if(y>height){ //point ball drops,game over,display scores
    gameOver();//can go to main menu
    }
    displayScore();
    
  x=x+dx;
    y=y+dy;//move the point ball
    count++;
}
   else if(temp==1) {
    x = 300;
    y = 590;
    dx = 3;
    dy = -5;
    count=0;
    points=0;
    if(keyPressed) {
      if(key=='r'){
      temp=0;          //restart this level game
      inside=new boolean[inside.length][inside[0].length];
      }
    }
    
  }
if (timer1.isPassed()) {  //check timer
   for(int i=0;i<inside.length;i++) {
    for(int j=0;j<inside[0].length;j++) {
      if(inside[i][j]==true){
        inside[i][j]=false;
      }  //certain time passes, bubbles that were popped are restored.
    }
   }
    timer1.start();
  }
 
 if(timer3.isPassed()){
   if(points<100){
     gameOver();              //in certain time not reach enough points, game over.
     displayScore();
   }
   timer3.start();
 }
}

void displaydifficultLevel(){//difficult level game starts
if(temp==0){
  background(bg1);
  displayGun();
  resetMatrix();
  stroke(0);    //draw point ball
  strokeWeight(5);
    point(x,y);
    strokeWeight(1);
    randomSeed(1);
    
  for(int i=0;i<inside1.length;i++) {
    for(int j=0;j<inside1[0].length;j++) {
      float dx2=15+30*j-x;
        float dy2=15+30*i-y;  //calculate distance
        float dis2=sqrt(pow(dx2,2)+pow(dy2,2));
        if (dis2>=15.&& inside1[i][j]==false) {
          fill(color2[(int)random(color2.length)]);
          ellipse(15+30*j,15+30*i,30,30); //draw bubbles with colors
   }
   else if (dx2<=(dis2*cos(PI/4))&& dy2<=-(dis2*sin(PI/4))&& inside1[i][j]==false) {
          dy*=-1;
         inside1[i][j]=true; //point hits bubbles and pop it, add points.
          points++;
          file.play();
        }
        else if (dx2<=(dis2*cos(PI/4)) && dy2>=(dis2*sin(PI/4))&& inside1[i][j]==false ) {
          dy*=-1;
          inside1[i][j]=true;
          points++;
          file.play();
        }
        else if (dy2<=(dis2*sin(PI/4)) && dx2<=-(dis2*cos(PI/4)) && inside1[i][j]==false) {
          dx*=-1;
          inside1[i][j]=true;
          points++;
          file.play();
        }
        else if (dy2<=(dis2*sin(PI/4)) && dx2>=(dis2*cos(PI/4))&& inside1[i][j]==false) {
          dx*=-1;
          inside1[i][j]=true;
          points++;
          file.play();
        }
    }
    
    
  }
   h=mouseY;
 
    //draw Bar to bounce point ball on
    float bar=75.;
    strokeWeight(3);
    line(mouseX-bar,h,mouseX+bar,h);
    strokeWeight(1);
 
    // change direction if moving point hits boundaries
    if (x>=width || x<=0) {
      dx*=-1;
    }
     if (y<=0) {
      dy*=-1;
    }
    // change direction if moving point hits bar
    if (y>=h && y<h+10) {
      //left part
      if (x>(mouseX-bar) && x< (mouseX-(1./3)*bar) && dx>0 && dy>0) {
        dy*=-0.95;
        dx*=-1.05;
      }
      //left part
      else if (x>(mouseX-bar) && x< (mouseX-(1./3)*bar) && dx<0 && dy>0) {
        dy*=-0.95;
        dx*=1.05;
      }
      //right part
      else if (x>(mouseX+(1./3)*bar) && x< (mouseX+bar) && dx>0 && dy>0) {
        dy*=-0.95;
        dx*=1.05;
      }
      //right part
      else if (x>(mouseX+(1./3)*bar) && x< (mouseX+bar) && dx<0 && dy>0) {
        dy*=-0.95;
        dx*=-1.05;
      }
      //middle part
      else if (x>(mouseX-(1./3)*bar) && x< (mouseX+(1./3)*bar) && dy>0) {
        dy*=-1.05;
        dx*=0.95;
      }
    }
   
    if(y>height){ //drop the point ball, game over
    gameOver();//return to main menu
    }//display Scores
    displayScore();
    
  x=x+dx;//move point ball
    y=y+dy;
    count++;
}
   else if(temp==1) {
    x = 300;
    y = 590;
    dx = 3;
    dy = -5;
    count=0;
    points=0;
    if(keyPressed) {
      if(key=='r'){//restart this level game
      temp=0;
      inside1=new boolean[inside1.length][inside1[0].length];
      }
    }
    
  }
if (timer2.isPassed()) {  //check timer
  for(int i=0;i<inside1.length;i++) {
    for(int j=0;j<inside1[0].length;j++) {
      if(inside1[i][j]==true){
        inside1[i][j]=false;
      }//certain time passes, bubbles that were popped are restored.
    }
   }
    timer2.start();
  }
  if(timer4.isPassed()){
   if(points<200){
     gameOver();
     displayScore(); //certain time passes not reach enough points game over.
   }
   timer4.start();
 }
}

void gameOver(){
  background(bg2);
  file2.play();
  fill(0);
  rect(200,400,100,100);
  fill(255,0,0);
  textSize(30);
  text("menu",210,460);
  restart=true;//restart game, go to main menu
  
      temp=1;
      fill(0);
      text("GAME OVER, try again!", 100, 300);  //press r to restart current level
      text("Press r TO RESTART", 100, 400);
}

void displayScore(){
  //display scores
    fill(255,0,0);
    text(points, 500, 500);
}
void mousePressed(){  //mouse press to choose button and go to menus
  if(mainMenu){
   if(mouseX>80&&mouseX<580&&mouseY>40&&mouseY<140){//instructions
         mainMenu=false;
         instructionMenu=true;
         file3.play();
        }
   if(mouseX>200&&mouseX<400&&mouseY>200&&mouseY<300){//start
     mainMenu=false;
     select=true;
      file3.play();
   }
   if(mouseX>200&&mouseX<400&&mouseY>400&&mouseY<500){//quit
     exit();
      file3.play();
   }
 }
 else if(instructionMenu) {
       if(mouseX>40&&mouseX<590&&mouseY>500&&mouseY<580){//return to menu
         mainMenu=true;
         instructionMenu=false;
          file3.play();
        }     
   }
 else if(select){
 if(mouseX>50&&mouseX<250&&mouseY>200&&mouseY<300){//easy
   select=false;
     easyGame=true;
      file3.play();
   }
   if(mouseX>300&&mouseX<550&&mouseY>200&&mouseY<300){//difficult
     select=false;
     difficultGame=true;
      file3.play();
   }
   }
 else{
   if(restart){
     if(mouseX>200&&mouseX<300&&mouseY>400&&mouseY<500){
       initGame();
        file3.play();
     }            
   }
 }
}





void displayGun(){ //display gun
strokeWeight(4);
stroke(0);
  line(width/2-20, height-10, width/2+20, height-10);//supporting lines
  line(width/2, height-30 , width/2, height+10);
  translate(width/2,height-10);
  line(0,0,27,-50);   //aiming line
  }

 
 
  
 
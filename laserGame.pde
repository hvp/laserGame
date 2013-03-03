
PFont font;


LaserGun [] lasers = new LaserGun[20];
PickUps [] PickUp = new PickUps[3];
int LaserCount;
public int ActivePickUpCount;
public int s;
public int Score, Health;
public int Speed;
public int Q;

 public int  screenWidth = 500;
 public int screenHeight = 500;

boolean menu = false;
boolean pasue;
boolean HealthPickUpActive;
boolean HealthPickedUp;
boolean PauseCheck;
boolean SpeedUpdater;
boolean Dead;




void setup(){
  int  screenWidth = 500;
   int screenHeight = 500;
   size(screenWidth, screenHeight, P2D);
  orientation(LANDSCAPE); 
  smooth();
  rectMode(CENTER);
  
  
  Health = 10;
  Score = 0;
  Speed = 5;
  Dead = false;
 
   
  font = loadFont("PigIronBold-48.vlw");
  textFont(font, 32); 
  
  menu = false;
  pasue = false;
  
  SpeedUpdater = false;
  
  HealthPickUpActive = false;
  HealthPickedUp = false;
  
  LaserCount = 3;
  ActivePickUpCount = 2;
  
  PauseCheck = false;
    
 PickUp[0] = new PickUps(200,205,0,255,0,1);
 PickUp[1] = new PickUps(200,40,0,255,0,2);
    
    
    
  
  
  
  for(int i = 0; i < LaserCount; i++)
  {
    if(i%2 == 0){
      lasers[i] = new LaserGun(0,5);
    }
    
    if(i%2 != 0){
      
      lasers[i] = new LaserGun(1,5);
    
  }
  
  
}
}


void draw(){
  
  background(255);
  smooth();
  noStroke();
  s = second();
  
  text(Score,15,30);
  text(Health,200,30);
  
  if(pasue)
  {
    fill(20,200,2);
    text("Pasued",190,150);
    //text(s,250,300);
    
    
    
  }
  
  
  if(menu)
  {
 
    fill(0);
    text("2",490,170);
    text("Welcome To [LASER]",80,200);
    
    text("Click To Play",160,250);
    
     
    
    
    
  }
  else{
 for (int i = 0; i < LaserCount; i++)
{
  
  lasers[i].display();
  
  if(pasue == false)
  
  {
 
  lasers[i].move(Speed);
  
  lasers[i].collisonCheck();
  
  }
 
}

for (int k = 0; k < ActivePickUpCount; k++)
{
 
  PickUp[k].update();
  
  if(pasue == false)
  {
      
      
      PickUp[k].display();
      
  
      
  }
}


  
  SpeedUp();
  if(Health  == 0)
  {
   death(); 
    
  }
  fill(0);
  
  rect(mouseX,mouseY,20,20);
  
}
}

public void keyPressed (){
  
 if(key == ' ')
{ 
      if(pasue == false)
     {
        pasue = true;
      
     }
     else
     {
       pasue = false;
       
     }
}


}

public void mouseClicked (){
  

  if(menu)
  {
    
    menu = false;
    
    
  }
  else
  {
   
     if(LaserCount < 20)
      {
        
        if(LaserCount % 2 == 0)
        {
             lasers[LaserCount] = new LaserGun(0,5);
   
             LaserCount += 1;
             
        }
        else
        {
          
            lasers[LaserCount] = new LaserGun(1,5);
   
             LaserCount += 1;
        }
        
   
     }
   
}
}

void SpeedUp(){
  
  if(s != 30 && s != 59)
   {
   SpeedUpdater = true;
   }
   
   
 if(SpeedUpdater){
   
   
  if((s == 30 || s == 59) && LaserCount < 20)
      {
        
        
        Speed += 0.5;
        
        
        if(LaserCount % 2 == 0)
        {
             lasers[LaserCount] = new LaserGun(0,Speed);
   
             LaserCount += 1;
             SpeedUpdater = false;
             
        }
        else
        {
          
            lasers[LaserCount] = new LaserGun(1,Speed);
   
             LaserCount += 1;
             SpeedUpdater = false; 
        }
        
      }
        
            
     
}

}
   
  
     
  

  
  


  
  


class LaserGun{
  
 float LD;
 float laserspeed;
 float x;
 float y;
 
 
 
 LaserGun(float tempX,float tempY)
 {
   LD = tempX;
   laserspeed = tempY;
   
   if(LD == 0){ // y
    x = random(screenWidth);
    y = 0;
    
   }
   if (LD == 1){
     
     x = 0;
     y = random(screenHeight);
   }
   
   
   
 }
 
 void move(int Speed) {
   
 
   
   
   if(LD == 0)
   {
     if(y < 0 || y > screenHeight){
    
       laserspeed *= -1;
       
     x = random(screenWidth);
   }
     y += laserspeed;
     
   
   }
   if(LD == 1)
   {
    if(x < 0 || x > screenWidth){
     laserspeed *= -1;
     y = random(screenHeight);
   }
     
     
    x += laserspeed; 
     
   }
  
 
 }
 
 void display(){
   
   fill(255,0,0);
   
   if(LD == 0)
   {
     
     rect(x,y,5,20);
     
   }
   
   if(LD == 1)
   {
    
     rect(x,y,20,5);
   }
   
 }
 
 void collisonCheck(){
   
    // where 'rect1' is at the mouse location and rect2 is the target
    if(LD == 0)
    
    {
        if(mouseX + 10 > x - 2.5
           && mouseX - 10 < x + 2.5
           && mouseY + 10 > y - 10
           && mouseY - 10 < y - 10
  ) {
     
    background(255,0,0);
    x = random(480);
    y = 0;
    Health -= 1;
  
}
   
 }
 
 if(LD == 1)
 {
   
        if(mouseX + 10 > x - 10
           && mouseX - 10 < x + 10
           && mouseY + 10 > y - 2.5
           && mouseY - 10 < y - 2.5
  ) {
     
    background(255,0,0);
    y = random(screenWidth);
    x = 0;
    Health -= 1;
  
}
   
   
   
   
 }
 

  
}
}

class PickUps{
  
 float PosX;
 float PosY;
 int color1;
 int color2;
 int color3;
 int ID;

 
 
 
 PickUps(float tempX,float tempY, int tempCol_1,int tempCol_2,int tempCol_3, int tempID)
 {
   PosX = tempX;
   PosY = tempY;
   color1 = tempCol_1;
   color2 = tempCol_2;
   color3 = tempCol_3;
   ID = tempID;
   
   
   
   
 }
 
 
 void update(){
   
   
   if(ID == 1)
   {
     
        if(mouseX + 10 > PosX - 5
           && mouseX - 10 < PosX + 5
           && mouseY + 10 > PosY - 5
           && mouseY - 10 < PosY - 5
           || pasue == true )
   {
       PosX = random(90);
       PosY = random(300);
      if(pasue == false)
     { 
       Score += 2*(LaserCount);
       Speed += 0.1;
     } 
       //background(100,155,210);
    
  
  }
   }
  
  else if(ID == 2)
   {
     
        if(mouseX + 10 > PosX - 5
           && mouseX - 10 < PosX + 5
           && mouseY + 10 > PosY - 5
           && mouseY - 10 < PosY - 5
           || pasue == true && HealthPickUpActive == true
  ) {
       PosX = random(00);
       PosY = random(300);
       HealthPickUpActive = false;
       HealthPickedUp = true;
       Health+= 1;
     
       
       
       //background(100,155,210);
    
    
  }
   }
 
   
 }
 
 
 void display() {
           if(ID == 1)
           {
               fill(0,0,255);
               rect(PosX,PosY,10,10);
           }
           else if(ID == 2)
           {
           if(s == 21)
              {
           
              HealthPickedUp = false;
             HealthPickUpActive = false; 
             }
             if(s > 10 && s < 20 && HealthPickedUp == false)
            { 
              HealthPickUpActive = true;
              
            }
          if(HealthPickUpActive == true)
          {
               fill(0,255,0);
               rect(PosX,PosY,10,10);
            
      
            
          }
           }
    
    }
  
 
} 


void death(){
  
  setup();
  
  
}



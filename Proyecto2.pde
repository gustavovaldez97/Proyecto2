import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import processing.sound.*;

ArrayList obstaculos;
ArrayList <Pelota>balls;
ArrayList limites;
Bola b;
Mover mover;
int g=0;
int pantalla=0;
PImage logo;
SoundFile main;

Box2DProcessing box2d;


void setup(){
  size(400,600);
  logo=loadImage("logo.jpg");
  main=new SoundFile(this,"main.mp3");
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  b=new Bola(width/2,450);
  mover = new Mover();
  limites = new ArrayList();
  limites.add(new Caja(25,350,10,300));
  limites.add(new Caja(165,350,10,300));
  limites.add(new Caja(95,500,150,10));
  limites.add(new Caja(225,350,10,300));
  limites.add(new Caja(365,350,10,300));
  limites.add(new Caja(295,500,150,10));
  limites.add(new Caja(200,5,width,10));
  limites.add(new Caja(200,595,width,10));
  limites.add(new Caja(5,300,10,height));
  limites.add(new Caja(395,300,10,height));
  obstaculos = new ArrayList();
  obstaculos.add(new Obstruccion(60,200,5));
  obstaculos.add(new Obstruccion(95,200,5));
  obstaculos.add(new Obstruccion(130,200,5));
  obstaculos.add(new Obstruccion(77.5,250,5));
  obstaculos.add(new Obstruccion(112.5,250,5));
  obstaculos.add(new Obstruccion(60,300,5));
  obstaculos.add(new Obstruccion(95,300,5));
  obstaculos.add(new Obstruccion(130,300,5));
  obstaculos.add(new Obstruccion(77.5,350,5));
  obstaculos.add(new Obstruccion(112.5,350,5));
  obstaculos.add(new Obstruccion(60,400,5));
  obstaculos.add(new Obstruccion(95,400,5));
  obstaculos.add(new Obstruccion(130,400,5));
  obstaculos.add(new Obstruccion(260,200,5));
  obstaculos.add(new Obstruccion(295,200,5));
  obstaculos.add(new Obstruccion(330,200,5));
  obstaculos.add(new Obstruccion(277.5,250,5));
  obstaculos.add(new Obstruccion(312.5,250,5));
  obstaculos.add(new Obstruccion(260,300,5));
  obstaculos.add(new Obstruccion(295,300,5));
  obstaculos.add(new Obstruccion(330,300,5));
  obstaculos.add(new Obstruccion(277.5,350,5));
  obstaculos.add(new Obstruccion(312.5,350,5));
  obstaculos.add(new Obstruccion(260,400,5));
  obstaculos.add(new Obstruccion(295,400,5));
  obstaculos.add(new Obstruccion(330,400,5));
  balls=new ArrayList();
  balls.add(new Pelota(200,130,10));
  balls.add(new Pelota(189,112,10));
  balls.add(new Pelota(210,112,10));
  balls.add(new Pelota(179,94,10));
  balls.add(new Pelota(200,94,10));
  balls.add(new Pelota(221,94,10));
  main.loop();
  
}

void mouseReleased() {
  mover.destroy();
}

void mousePressed() {
  // Check to see if the mouse was clicked on the box
  if (b.contains(mouseX, mouseY)) {
    // And if so, bind the mouse location to the box with a spring
    mover.bind(mouseX,mouseY,b);
  }
}

void draw(){
  background(0);
   if(pantalla==0){
    pantallaInicio();
  }
  if(pantalla==1){
    pantallaJuego();
  }
}

void pantallaInicio(){
  background(0);
  image(logo,50,50,325,300);
  tint(255,random(255,175));
  text("Presione cualquier tecla para continuar",50,400);
  
}

 void pantallaJuego(){
   background(0);
   text("Arrastre la pelota blanca con el mouse para lanzarla",90,550);
    box2d.step();
  if(g==0){
    box2d.setGravity(0,0);
  }
  else if(g==1){
    box2d.setGravity(0,-10);
  }

  mover.update(mouseX,mouseY);
  for (int i = 0; i < limites.size(); i++) {
    Caja c = (Caja) limites.get(i);
    c.display();
  }
  
  for (int i = 0; i < obstaculos.size(); i++) {
    Obstruccion o = (Obstruccion) obstaculos.get(i);
    o.display();
  }
  
  for (int i = 0; i < balls.size(); i++) {
    Pelota p = (Pelota) balls.get(i);
    p.display();
  }
  
  b.display();
} //<>//

void keyPressed(){
  if(pantalla==0)
  pantalla=1;
}

// Collision event functions!
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Pelota.class && o2.getClass() == Pelota.class) {
    Pelota p1 = (Pelota) o1;
    p1.cambio();
    Pelota p2 = (Pelota) o2;
    p2.cambio();
  }

}

// Objects stop touching each other
void endContact(Contact cp) {
}

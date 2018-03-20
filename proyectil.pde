class Bola{
  float r;
  Body body;
  float xl;
  float yl;
  
  Bola(float x_, float y_){
   float x=x_;
   float y=y_;
   r=10;
   
   makeBody(x,y,r);
    }
    
  void killBody() {
    box2d.destroyBody(body);
  }
    
  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }
 /*   
 void applyForce(Vec2 force) {
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }
  */
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(255);
    noStroke();
    ellipseMode(CENTER);
    ellipse(0,0,r*2,r*2);
    popMatrix();
  }
  
  void makeBody(float x, float y, float r) {
    BodyDef bd = new BodyDef();
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.3;
    
    body.createFixture(fd);

    //body.setLinearVelocity(new Vec2(random(-10f,10f), 20));
    //body.setAngularVelocity(random(-10,10));
  }
  /*
  void mover(float xl_, float yl_){
    body.setLinearVelocity(new Vec2(xl_, yl_));
  }
  
  Vec2 returnPosition(){
     return box2d.getBodyPixelCoord(body);
  }*/
}

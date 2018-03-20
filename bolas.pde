class Pelota{
  float r;
  color c;
  Body body;
  
  Pelota(float x, float y, float r_){
   r=r_;
   c=color(255,0,0);
   makeBody(x,y,r);
    }
    
  void killBody() {
    box2d.destroyBody(body);
  }
  
    void cambio() {
    c = color(0,255, 0);
  }

  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(c);
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

    //body.setLinearVelocity(new Vec2(random(-10f,10f), 40));
    //body.setAngularVelocity(random(-10,10));
  }
}

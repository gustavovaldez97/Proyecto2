class Obstruccion{
  float r;
  Body body;
  
  Obstruccion(float x, float y, float r_){
   r=r_;
   
   makeBody(x,y,r);
    }
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x,pos.y);
    fill(random(255),random(255),random(255));
    stroke(0,0,255);
    ellipseMode(CENTER);
    ellipse(0,0,r*2,r*2);
    popMatrix();
  }
  
  void makeBody(float x, float y, float r) {
    BodyDef bd = new BodyDef();
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.STATIC;
    body = box2d.world.createBody(bd);

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.3;
    
    body.createFixture(fd);
  }
}

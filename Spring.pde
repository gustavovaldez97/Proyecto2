class Mover {

  MouseJoint mouseJoint;

  Mover() {
    mouseJoint = null;
  }
 
  void update(float x, float y) {
    if (mouseJoint != null) {
      Vec2 mouseWorld = box2d.coordPixelsToWorld(x,y);
      mouseJoint.setTarget(mouseWorld);
    }
  }

  void bind(float x, float y, Bola b) {
    MouseJointDef md = new MouseJointDef();
    md.bodyA = box2d.getGroundBody();
    md.bodyB = b.body;
    Vec2 mp = box2d.coordPixelsToWorld(x,y);
    md.target.set(mp);
    md.maxForce = 1000.0 * b.body.m_mass;
    md.frequencyHz = 5.0;
    md.dampingRatio = 0.9;

    mouseJoint = (MouseJoint) box2d.world.createJoint(md);
  }

  void destroy() {
    if (mouseJoint != null) {
      box2d.world.destroyJoint(mouseJoint);
      mouseJoint = null;
    }
  }

}

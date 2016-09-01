import processing.core.PApplet;

public class Globe {
	public float R;
	public PApplet p;
	
	public Globe() {
	}
	
	public Globe(PApplet p, float radius) {
		this.p = p;
		R = radius;
	}
	
	public void display() {
		p.pushMatrix();
		p.translate(0,0,0);
		p.noStroke();
		p.fill(0,0,255);
		p.sphere(R-5);
		p.popMatrix();
	}
}

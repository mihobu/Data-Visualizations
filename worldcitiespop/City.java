import processing.core.*;

public class City {
	public PApplet p;
	public float R;
	public float lat;
	public float lon;
	public float pop;
	public String name;
	
	public City() {
	}
	
	public City(PApplet p, float R, float lat, float lon, float pop, String name) {
		this.p = p;
		this.R = R;
		this.lat = lat;
		this.lon = lon;
		this.pop = pop;
		this.name = name;
	}
	
	public void display() {
		float theta = lat * (PConstants.PI / 180);
		float phi   = lon * (PConstants.PI / 180);
		float popRoot = (float)Math.cbrt(pop); // sphere volume is proportional to the cube root of population
		float a = (p.frameCount % 360 ) * (PConstants.PI / 180); // current rotational position

		// These calculations are a little different from the "textbook" calculations
		// since Processing's axes are a little weird.
		float x = (float) (R * Math.cos(theta) * Math.cos(phi+a));
		float y = (float) (-R * Math.sin(theta) );
		float z = (float) (-R * Math.cos(theta) * Math.sin(phi+a));
		
		p.pushMatrix();
		p.translate(x,y,z);
		if ( pop > 10000000 ) {
			p.fill(255,0,0);
		}
		else if ( pop > 1000000 ) {
			p.fill(255,128,0);
		}
		else if ( pop > 100000 ) {
			p.fill(255,255,0);
		}
		else {
			p.fill(255,255,255);
		}
		p.noStroke();
		p.sphere(PApplet.map(popRoot,10,318,1,10));
		p.popMatrix();
	}
}

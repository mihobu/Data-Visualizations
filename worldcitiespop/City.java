import processing.core.*;

public class City {
	public PApplet p;
	public float R;
	public float lat;
	public float lon;
	public float pop;
	public String name;
	public float x;
	public float y;
	public float z;
	public float radius;
	
	public City() {
	}
	
	public City(PApplet p, float R, float lat, float lon, float pop, String name) {
		this.p = p;
		this.R = R;
		this.lat = lat;
		this.lon = lon;
		this.pop = pop;
		this.name = new String(name);
		this.radius = PApplet.map((float)Math.cbrt(pop),10,318,1,10);
	}
	
	public void display() {
		float theta = lat * (PConstants.PI / 180);
		float phi   = lon * (PConstants.PI / 180);
		float a = (p.frameCount % 360 ) * (PConstants.PI / 180); // current rotational position

		// These calculations are a little different from the "textbook" calculations
		// since Processing's axes are a little weird.
		this.x = (float) (R * Math.cos(theta) * Math.cos(phi+a));
		this.y = (float) (-R * Math.sin(theta) );
		this.z = (float) (-R * Math.cos(theta) * Math.sin(phi+a));
		
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
		p.sphere(this.radius);
		p.popMatrix();
	}

	public boolean isOver() {
		boolean isVisible = (z>0);
		float mx_trans = (float)p.mouseX - p.width/2;
		float my_trans = (float)p.mouseY - p.height/2;
		PApplet.print(String.format("x: %d, y: %d\n", (int)mx_trans, (int)my_trans));
		return(isVisible && PApplet.dist(x,y,mx_trans,my_trans)<10);
/*
		p.pushMatrix();
		p.translate(x,y,z);
		boolean retval = isVisible && ( PApplet.dist(x,y,(float)p.mouseX,(float)p.mouseY) < 10 );
		PApplet.print(String.format("x: %d, y: %d\n", p.mouseX, p.mouseY));
		p.popMatrix();
		return(retval);
*/
	}
	
	public float mouseDist() {
		float mx_trans = (float)p.mouseX - p.width/2;
		float my_trans = (float)p.mouseY - p.height/2;
		return(PApplet.dist(x,y,mx_trans,my_trans) / this.radius);
	}
	
	public boolean isVisible() {
		return(z > 0);
	}
}

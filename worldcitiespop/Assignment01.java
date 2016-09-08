import java.util.ArrayList;
import processing.core.PApplet;
import processing.core.PFont;
import processing.data.Table;
import com.hamoid.*;

public class Assignment01 extends PApplet {

	float R = (float)150;
	Globe glb;
	City c;
	float a = PI;
	Table worldpop;
	City[] cities;
	ArrayList<City> CityList = new ArrayList<City>();
	int minPop = 100000;
	VideoExport ve;
	boolean saveVideo = false;
	PFont dispFont; 
	int closestCity = -1;

	public static void main(String[] args) {
		PApplet.main("Assignment01");
	}

	public void settings() {
		size(400,400,P3D);
		smooth(8);
	}

	public void setup() {
		ortho();
		fill(120,50,240);
		frameRate(5);
		background(25);
		shininess(90);
		ambientLight(150,150,150);
		ambient(180);
		sphereDetail(15); // default=30
		
		dispFont = createFont("Arial Narrow Bold",18);
		
		//camera(width/2,0,(float)((height/2)/Math.tan(PConstants.PI*30/180)),width/2,height/2,0,0,1,0);
		
		glb = new Globe(this,R); // This is the base globe (a blank Earth, if you will)

		// LOAD THE DATA INTO A LIST OF CITY OBJECTS
		worldpop = loadTable("worldcitiespop2.txt","csv");
		for ( int i = 0 ; i < worldpop.getRowCount() ; i++ ) {
			int citypop = worldpop.getInt(i,4);
			if ( citypop >= minPop ) {
			//if ( Math.random() < 0.1 ) {
				String cityname = worldpop.getString(i,2);
				float citylat = worldpop.getFloat(i,5);
				float citylon = worldpop.getFloat(i,6);
				City tmpcity = new City(this,R,citylat,citylon,citypop,cityname);
				CityList.add(tmpcity);
			}
		}
		
		if ( saveVideo ) {
			ve = new VideoExport(this,"assignment1.mp4");
		}
	}

	public void mouseClicked() {
		float lastMouseDist = 100000;
		for ( int i = 0 ; i < CityList.size() ; i++ ) {
			City c = (City)CityList.get(i);
			if ( c.isVisible() && c.mouseDist() < lastMouseDist ) {
				lastMouseDist = c.mouseDist();
				closestCity = i;
			}
		}
	}
	
	public void draw() {
		translate(width/2,height/2,0); // place (0,0,0) at center screen

		background(0);
		directionalLight(254,254,254,-1,1,-1);
		//directionalLight(128,128,128,1,-1,1);
		glb.display(); // display the base globe

		// Report the current X,Y position of the mouse
		String mousePos = String.format("x: %d , y: %d",mouseX-width/2,mouseY-height/2);
		writeMessage(0,170,mousePos);

		for ( int i = 0 ; i < CityList.size() ; i++ ) {
			City c = (City)CityList.get(i);
			c.display();
		}

		if ( closestCity >= 0 ) {
			City c2 = (City)CityList.get(closestCity);
			//writeMessage(0,-170,String.format("%s\nx:%d, y:%d, z:%d (dist=%d)",c2.name,(int)c2.x,(int)c2.y,(int)c2.z,(int)c2.mouseDist()));
			writeMessage(0,-170,String.format("%s (Pop. %d)\nLat: %.2f, Lon: %.2f",c2.name,(int)c2.pop,c2.lat,c2.lon));
			
			// stop displaying when city rotates out of view:
			if ( ! c2.isVisible() ) {
				closestCity = -1;
			}
		}

		if ( saveVideo && frameCount <= 360 ) {
			ve.saveFrame();
		}
		
	}

	private void writeMessage(float x, float y, String s) {
		textAlign(CENTER,CENTER);
		textFont(dispFont);
		fill(255);
		text(s,x,y,0);
	}
}

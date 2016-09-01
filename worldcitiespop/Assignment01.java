import java.util.ArrayList;
import processing.core.PApplet;
import processing.core.PConstants;
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
	int minPop = 10000;
	VideoExport ve;

	public static void main(String[] args) {
		PApplet.main("Assignment01");
	}

	public void settings() {
		size(400,400,P3D);
		smooth(8);
	}

	public void setup() {
		fill(120,50,240);
		frameRate(24);
		background(25);
		shininess(90);
		ambientLight(150,150,150);
		ambient(180);
		sphereDetail(15); // default=30

		camera(width/2,0,(float)((height/2)/Math.tan(PConstants.PI*30/180)),width/2,height/2,0,0,1,0);

		glb = new Globe(this,R); // This is the base globe (a blank Earth, if you will)

		worldpop = loadTable("worldcitiespop2.txt","csv");

		for ( int i = 0 ; i < worldpop.getRowCount() ; i++ ) {
			int citypop = worldpop.getInt(i,4);
			if ( citypop >= minPop ) {
				String cityname = worldpop.getString(i,2);
				float citylat = worldpop.getFloat(i,5);
				float citylon = worldpop.getFloat(i,6);
				City tmpcity = new City(this,R,citylat,citylon,citypop,cityname);
				CityList.add(tmpcity);
			}
		}

		ve = new VideoExport(this,"assignment1.mp4");
	}

	public void draw() {
		//a = (float) (a + PI/180); // 1° of spin each frame
		// one full rotation should take exactly 15 seconds (360 frames).

		translate(width/2,height/2,0);
		//rotateZ((float)0.4084);
		//rotateX((float)-0.3);
		//rotateY(a);

		background(0);
		directionalLight(254,254,254,-1,1,-1);
		//directionalLight(128,128,128,1,-1,1);
		glb.display(); // display the base globe

		for ( int i = 0 ; i < CityList.size() ; i++ ) {
			((City)CityList.get(i)).display();
		}


		if ( frameCount <= 360 ) {
			ve.saveFrame();
		}
	}
}

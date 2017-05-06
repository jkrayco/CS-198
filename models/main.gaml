model main	//lives + k1c + bounce2 + equilibrium
import "../models/myGlobal.gaml"
import "../models/mySpecies.gaml"

//experiment now type:gui {
experiment now type:gui {
	//parameter "Photons: " var:initial_photon min:1 max:500 category:"Photons";
	//parameter "Catalyst: " var:initial_cat min:1 max:200 category:"Catalyst agents";
	//parameter "Sulfide: " var:initial_sulfide min:0 max:500 category:"S2 agents";
	//parameter "Sulfite: " var:initial_sulfite min:0 max:500 category:"SO3 agents";
	 
	output{
		//shows all agents involved in the hydrogen reaction
		/*
		 * display all type:opengl{
			graphics "env"{
				draw box(environmentWidth,environmentHeight,environmentLength) color:#black empty:true;
			}
			species photon aspect:base;
			species cat aspect:base;
			species electron aspect:base;
			species cat_H2O aspect:base;
			species cat_H aspect:base;
			species hydrogen aspect:base;
		}*/
		//shows the main agents involved in the hydrogen reaction
		display Visual type:opengl{
			graphics "env"{
				draw box(environmentWidth,environmentHeight,environmentLength) color:#black empty:true;
			}
			species photon aspect:base;
			species cat aspect:base;
			species electron aspect:base;
			species cat_H2O aspect:base;
			species cat_H aspect:base;
			species hydrogen aspect:base;
		}
		//displays a chart indicating the number of molecules of each agent over time
		
		display Graphical{
			chart "Molecules vs Time"{
				data "Photon" value:length(photon) color:#yellow;
				data "Catalyst" value:length(cat) color:#red;
				data "Electron" value:length(electron) color:#silver;
				data "cat-H2O" value:length(cat_H2O) color:#purple;
				data "cat-H*" value:length(cat_H) color:#blue;
				data "Hydrogen" value:length(hydrogen) color:#cyan;
			}
		}
		monitor "Catalyst" value:length(cat);
		monitor "Sulfide" value:length(sulfide);
		monitor "Sulfite" value:length(sulfite);
		monitor "Hydrogen" value:length(hydrogen);
	}
}

experiment batch type:batch repeat:1 until: (cycle = (cph*4)+1){//cycle = (cph*8)+1)){
	parameter "Batch Code" var: batchCode among: ["model1l_SO3"];
	//parameter "Catalyst:" var: initial_cat among: list_cat;
	//parameter "Sulfide:" var: initial_sulfide among: list_sulfide;
	parameter "Sulfite:" var: initial_sulfite among: list_sulfite;
	parameter "Run:" var: run among: [1,2,3];
}
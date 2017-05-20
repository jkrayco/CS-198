model main	//lives + k1c + bounce2 + equilibrium
import "../models/initialize.gaml"
import "../models/parameters.gaml"
import "../models/species_list.gaml"
import "../models/reaction_list.gaml"

global {
	reflex updateLight {
		create photon number:(initial_photon-length(photon)){
			location <- {0,rnd(environment_height),rnd(environment_length)}; //new photons arrive
		}
	}
	reflex updateOutput{
		//saves the number of hydrogen produced on 4th hour in a csv file
		if (cycle = cph*4){
			save [run, length(cat), length(sulfide), length(sulfite), length(hydrogen), length(photon), length(electron), length(hole), length(cat_H2O), length(HS), length(OH), length(cat_HS), length(cat_sulfite), length(cat_H), length(cat_OH), length(cat_HS0), length(cat_S0), length(cat_HS2), length(HS2), length(S2O3), length(cat_S2O3)] to: batchCode+"_hour4.csv" type:csv;
		}
		//saves the number of hydrogen produced per cycle-hour in a csv file
		if (mod(cycle,cph) = 0){
			save [run, cycle/cph, length(cat), length(sulfide), length(sulfite), length(hydrogen), length(photon), length(electron), length(hole), length(cat_H2O), length(HS), length(OH), length(cat_HS), length(cat_sulfite), length(cat_H), length(cat_OH), length(cat_HS0), length(cat_S0), length(cat_HS2), length(HS2), length(S2O3), length(cat_S2O3)] to: batchCode+".csv" type:csv;
		}
	}
}

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
				draw box(environment_width,environment_height,environment_length) color:#black empty:true;
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
				draw box(environment_width,environment_height,environment_length) color:#black empty:true;
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
		monitor "HS2" value:length(HS2);
		monitor "Hydrogen" value:length(hydrogen);
	}
}

experiment batch type:batch repeat:1 until: (cycle = (cph*4)+1){//cycle = (cph*8)+1)){
	parameter "Batch Code" var: batchCode among: ["model_newbase_S"];
	//parameter "Catalyst:" var: initial_cat among: [100, 300, 400, 800];
	parameter "Sulfide:" var: initial_sulfide among: [12, 24, 60, 120, 240, 720];
	//parameter "Sulfite:" var: initial_sulfite among: [24, 60, 120, 240, 720];
	parameter "Run:" var: run among: [1,2,3];
}
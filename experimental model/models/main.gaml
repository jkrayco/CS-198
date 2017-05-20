model main	//
import "../models/initialize.gaml"
import "../models/parameters.gaml"
import "../models/species_list.gaml"
import "../models/reaction_list.gaml"

global {
	init {
		if (run = 1){
			save ["run", "cat", "S", "SO3", "H2", "photon", "electron", "hole", "cat_H2O", "HS", "OH", "cat_HS", "cat_sulfite", "cat_H", "cat_OH", "cat_HS0", "cat_S0", "cat_HS2", "HS2", "S2O3", "cat_S2O3"] to: batch_code+"_"+K1+"_"+K2+"_"+K3+"_"+K4+"_"+K5+"_"+K6+"_"+K7+"_"+K8+"_"+K9+"_"+K10+"_"+K11+"_"+K12+"_"+K13+"_"+K14+"_"+K15+var_code+"_hour4.csv" type:csv;
			save ["run", "time", "cat", "S", "SO3", "H2", "photon", "electron", "hole", "cat_H2O", "HS", "OH", "cat_HS", "cat_sulfite", "cat_H", "cat_OH", "cat_HS0", "cat_S0", "cat_HS2", "HS2", "S2O3", "cat_S2O3"] to: batch_code+"_"+K1+"_"+K2+"_"+K3+"_"+K4+"_"+K5+"_"+K6+"_"+K7+"_"+K8+"_"+K9+"_"+K10+"_"+K11+"_"+K12+"_"+K13+"_"+K14+"_"+K15+var_code+".csv" type:csv;
		}
	}
	reflex updateLight {
		create photon number:(initial_photon-length(photon)){
			location <- {0,rnd(environment_height),rnd(environment_length)}; //new photons arrive
		}
	}
	reflex updateOutput{
		//saves the number of hydrogen produced on 4th hour in a csv file
		if (cycle = cph*4){
			save [run, length(cat), length(sulfide), length(sulfite), length(hydrogen), length(photon), length(electron), length(hole), length(cat_H2O), length(HS), length(OH), length(cat_HS), length(cat_sulfite), length(cat_H), length(cat_OH), length(cat_HS0), length(cat_S0), length(cat_HS2), length(HS2), length(S2O3), length(cat_S2O3)] to: batch_code+"_"+K1+"_"+K2+"_"+K3+"_"+K4+"_"+K5+"_"+K6+"_"+K7+"_"+K8+"_"+K9+"_"+K10+"_"+K11+"_"+K12+"_"+K13+"_"+K14+"_"+K15+var_code+"_hour4.csv" type:csv;
		}
		//saves the number of hydrogen produced per cycle-hour in a csv file
		if (mod(cycle,cph) = 0){
			save [run, cycle/cph, length(cat), length(sulfide), length(sulfite), length(hydrogen), length(photon), length(electron), length(hole), length(cat_H2O), length(HS), length(OH), length(cat_HS), length(cat_sulfite), length(cat_H), length(cat_OH), length(cat_HS0), length(cat_S0), length(cat_HS2), length(HS2), length(S2O3), length(cat_S2O3)] to: batch_code+"_"+K1+"_"+K2+"_"+K3+"_"+K4+"_"+K5+"_"+K6+"_"+K7+"_"+K8+"_"+K9+"_"+K10+"_"+K11+"_"+K12+"_"+K13+"_"+K14+"_"+K15+var_code+".csv" type:csv;
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
		monitor "K1c" value:K1c;
	}
}

experiment batch type:batch repeat:1 until: (cycle = (cph*4)+1){//cycle = (cph*8)+1)){
	parameter "Batch Code" var: batch_code among: ["model_test"];
	parameter "Variable Code" var: var_code among: ["_k1d_sqrt_cat"];

	parameter "k" var: k among: [7.15389833503297722927527502179145812988281250];
	parameter "K1" var: K1 among: [36.0];	//hv + cat -> cat + electron + hole 							
	parameter "K2" var: K2 among: [62.5, 87.5];
//	parameter "K3" var: K3 among: [0.045]; 							
	parameter "K4" var: K4 among: [0.12];	//S 2- + H2O -> HS- + OH -	x					
	parameter "K5" var: K5 among: [60.0];	//cat + HS - -> cat-HS -							
//	parameter "K6" var: K6 among: [0.15, 0.45];	//cat + SO3 2- -> cat-SO3 2-						
//	parameter "K7"  var: K7 among: [45.0];	//cat-H2O + cat + electron -> cat-H. + cat-OH - 	
//	parameter "K8"  var: K8 among: [50.0];	//2cat-H. -> 2cat + H2
//	parameter "K9"  var: K9 among: [49.0];	//cat-HS - + hole -> cat-HS. 						
//	parameter "K10"  var: K10 among: [25.5];	//cat-HS. + cat-OH - -> cat-S. - + cat + H2O			
//	parameter "K11"  var: K11 among: [46.5];	//cat-HS. + cat-S. - -> cat-HS2 - + cat								
//	parameter "K13"  var: K13 among: [35.0];	//HS2 - + SO3 2- -> S2O3 2- + HS - 								
//	parameter "K15"  var: K15 among: [4.475, 13.425];	//cat + S2O3 2- -> cat-S2O3 2-
	parameter "Catalyst:" var: initial_cat among: [100, 300, 400, 800];
//	parameter "Sulfide:" var: initial_sulfide among: [12, 24, 60, 120, 240, 720];
//	parameter "Sulfite:" var: initial_sulfite among: [24, 60, 120, 240, 720];
	parameter "Run:" var: run among: [1,2,3];
}
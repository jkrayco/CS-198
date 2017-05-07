model reaction_list
import "../models/parameters.gaml"
import "../models/species_speed.gaml"

species parent_species skills:[moving3D]{ //catalyst	
	action reaction_photon {
		ask self{
			do goto speed:speed_of_photon target:{environment_width,myself.location.y,myself.location.z}; //to move in one direction
			do move speed:(speed_of_photon*3) heading:rnd(360); //to wiggle a little
			if (myself.location.x>(environment_width-5)){ //dies when it reaches the other side
				do die;
			}
		}	
	}
	int reaction_1(int lives) {
		if (rnd_float(100)<K1*(1-10*((length(cat)*(4*#pi*(3^3)/3)+length(HS2)*(4*#pi*(2^3)/3))/(side^3)))){ //reaction 1: hv (photon) + cat -> electron + hole
			create electron number:1{
				location <- myself.location;
				do move speed:0.5 heading:rnd(360);
			}
			create hole number:1{
				location <- myself.location;
				do move speed:0.5 heading:rnd(360);
			}
			ask photon closest_to self{
				do die;
			}
			lives <- lives - 1;
			if (lives <= 0){
				do die;
			}
		}
		else {
			ask photon closest_to self{
				do move speed:5 heading:180;
			}
		}
		return lives;
	}
	
	action reaction_2{
		if (rnd_float(100)<K2){ //reaction 2: electron + hole -> {}
			ask hole closest_to self{
				do die;
			}
			do die;
		}
	}
	action reaction_3 {
		if (rnd_float(100)<K3){ //reaction 3: cat + H2O -> cat-H2O
			//save [run, cycle/cph, length(cat), length(sulfide), length(sulfite), length(hydrogen), length(photon), length(electron), length(hole), length(cat_H2O), length(HS), length(OH), length(cat_HS), length(cat_sulfite), length(cat_H), length(cat_OH), length(cat_HS), length(cat_S0), length(cat_HS2), length(HS2), length(S2O3), length(cat_S2O3)] to: batchCode+".csv" type:csv;
			create cat_H2O number:1{
				location <- myself.location;
			}
			do die;
		}
	
	}
	action reaction_4{
		if (rnd_float(100)<K4){ //reaction 4: S 2- + H2O -> HS- +OH-
			create HS number:1{
				location <- myself.location;
			}
			create OH number:1{
				location <- myself.location;
			}
			do die;
		}		
	}
	action reaction_5{
		if (rnd_float(100)<K5){ //reaction 5: cat + HS - -> cat-HS -
			create cat_HS number:1{
				location <- myself.location;
			}
			ask cat closest_to self{
				do die;
			}
			do die;
		}		
	}
	action reaction_6{
		if (rnd_float(100)<K6 and length(cat_sulfite)<100){ //reaction 6: cat + SO3 2- -> cat-SO3 2- 
			create cat_sulfite number:1{
				location <- myself.location;
			}
			ask cat closest_to self{
				do die;
			}
			do die;
		}		
	}
	action reaction_7{
		if (rnd_float(100)<K7){ //reaction 7: cat-H2O + cat + electron -> cat-H. + cat-OH -
			//save [run, cycle/cph, length(cat), length(sulfide), length(sulfite), length(hydrogen), length(photon), length(electron), length(hole), length(cat_H2O), length(HS), length(OH), length(cat_HS), length(cat_sulfite), length(cat_H), length(cat_OH), length(cat_HS), length(cat_S0), length(cat_HS2), length(HS2), length(S2O3), length(cat_S2O3)] to: batchCode+".csv" type:csv;
			create cat_OH number:1{
				location <- myself.location;
			}
			create cat_H number:1{
				location <- myself.location;
			}
			ask electron closest_to self{
				do die;
			}
			ask cat closest_to self{
				do die;
			}
			do die;
		}		
	}
	action reaction_8{
		if (rnd_float(100)<K8){ //reaction 8: 2cat-H. -> 2cat + hydrogen
			//save [run, cycle/cph, length(cat), length(sulfide), length(sulfite), length(hydrogen), length(photon), length(electron), length(hole), length(cat_H2O), length(HS), length(OH), length(cat_HS), length(cat_sulfite), length(cat_H), length(cat_OH), length(cat_HS), length(cat_S0), length(cat_HS2), length(HS2), length(S2O3), length(cat_S2O3)] to: batchCode+".csv" type:csv;
			create hydrogen number:1{
				location <- myself.location;
			}
			create cat number:2{
				location <- myself.location;
			}
			ask cat_H closest_to self{
				do die;
			}
			do die;
		}		
	}
	action reaction_9{
		if (rnd_float(100)<K9){ //reaction 9: cat-HS - + hole -> cat-HS.
			create cat_HS0 number:1{
				location <- myself.location;
			}
			ask hole closest_to self{
				do die;
			}
			do die;
		}		
	}
	action reaction_10{		
		if (rnd_float(100)<K10){ //reaction 10: cat-HS. + cat-OH - -> cat-S. - + cat +H2O
			create cat_S0 number:1{
				location <- myself.location;
			}
			create cat number:1{
				location <- myself.location;
			}
			ask cat_OH closest_to self{
				do die;
			}
			do die;
		}
	}
	action reaction_11{
		if (rnd_float(100)<K11){ //reaction 11: cat-S. - + cat-HS. -> cat + cat-HS2 -
			create cat_HS2 number:1{
				location <- myself.location;
			}
			create cat number:1{
				location <- myself.location;
			}
			ask cat_HS0 closest_to self{
				do die;
			}
			do die;
		}	
	}
	action reaction_12{
		if (rnd_float(100)<K12){ //reaction 12: cat-HS2 - -> cat + HS2 -
			create cat number:1{
				location <- myself.location;
			}
			create HS2 number:1{
				location <- myself.location;
			}
			do die;
		}		
	}
	action reaction_13{
		if (rnd_float(100)<K13){ //reaction 13: HS2 - + SO3 2- -> HS - + S2O3 2-
			create S2O3 number:1{
				location <- myself.location;
			}
			create HS number:1{
				location <- myself.location;
			}
			ask sulfite closest_to self{
				do die;
			}
			do die;
		}	
	}
	action reaction_14{
		if (rnd_float(100)<K14){ //reaction 14: OH- + cat -> cat-OH - 
			create cat_OH number:1{
				location <- myself.location;
			}
			ask cat closest_to self{
				do die;
			}
			do die;
		}
	}
	action reaction_15{
		if (rnd_float(100)<K15){ //reaction 15: cat + S2O3 2- -> cat-S2O3 2-
			create cat_S2O3 number:1{
				location <- myself.location;
			}
			ask cat closest_to self{
				do die;
			}
			do die;
		}}
}
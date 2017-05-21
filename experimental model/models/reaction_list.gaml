model reaction_list
import "../models/parameters.gaml"
import "../models/species_speed.gaml"

species parent_species skills:[moving3D]{ //catalyst	
	//K1
	float K1_d{
//		float x <- ((length(cat)*(4*#pi*(cat_size^3)/6)+length(HS2)*(4*#pi*(sulfur_size^3)/6))/(side^3));
		int t <- length(cat);
		int t0 <- 300;
		float x <- (-1.4571*10^(-8))*(t^4) + (6.0454*10^(-9))*(t^3) + (-8.5972*10^(-10))*(t^2) + (-2.6055*10^2)*t + (3.6791*10);
		float x0 <- (-1.4571*10^(-8))*(t0^4) + (6.0454*10^(-9))*(t0^3) + (-8.5972*10^(-10))*(t0^2) + (-2.6055*10^2)*t0 + (3.6791*10);
		K1d <- x/abs(x0) + 1;
		return K1d;
	}
	float K1_F_ext{
		float x <- location.x;
		float r <- (70*11/10 + x);
		float cos_theta <- 1.0;
		float cos_theta_max <- cos(0);
		float r_min <- 70*11/10;
		/*
		ask photon closest_to self{
			float this_x <- abs(x - list(self.location)[0]);
			float this_r <- abs(self distance_to myself);
			cos_theta <- this_x/this_r;
		}
		*/
		float result <- (cos_theta/(4*#pi*r^2))/(cos_theta_max/(4*#pi*r_min^2));
		return result;
	}
	action reaction_photon {
		ask self{
			do goto speed:3*photon_speed target:{environment_width,myself.location.y,myself.location.z}; //to move in one direction
			//do move speed:(photon_speed*3) heading:rnd(360); //to wiggle a little
			if (myself.location.x>=(environment_width)){ //dies when it reaches the other side
				do die;
			}
		}
	}
	int reaction_1(int lives) {
		if (rnd_float(100) < K1*K1_d() and length(cat) <= 400){ //reaction 1: hv (photon) + cat -> electron + hole
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
			//lives
			lives <- lives - 1;
			if (lives <= 0){
				do die;
			}
		}
		else {
			//bounce
			ask photon closest_to self{
				do goto speed:3*photon_speed target:{-myself.location.x,-myself.location.y,-myself.location.z};
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
		//equillibrium
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
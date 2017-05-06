model mySpecies	//lives + k1c + bounce2 + equilibrium
import "../models/myInitial.gaml"

species cat skills:[moving3D]{ //catalyst
	int lives <- 188;
	reflex move{
		do wander_3D;
		
		if (rnd_float(100)<K3){ //reaction 3: cat + H2O -> cat-H2O
			//save [run, cycle/cph, length(cat), length(sulfide), length(sulfite), length(hydrogen), length(photon), length(electron), length(hole), length(cat_H2O), length(HS), length(OH), length(cat_HS), length(cat_sulfite), length(cat_H), length(cat_OH), length(cat_HS), length(cat_S0), length(cat_HS2), length(HS2), length(S2O3), length(cat_S2O3)] to: batchCode+".csv" type:csv;
			create cat_H2O number:1{
				location <- myself.location;
			}
			do die;
		}
	}
	reflex forward1 when: (length(photon at_distance collision_range)>=1){
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
	}
	aspect base{
		draw sphere(3) color:#red;
	}
}

species photon skills:[moving3D]{ //hv
	float speed_of_photon <- 1.0;
	
	reflex move{
		ask self{
			do goto speed:speed_of_photon target:{environmentWidth,myself.location.y,myself.location.z}; //to move in one direction
			do move speed:(speed_of_photon*3) heading:rnd(360); //to wiggle a little
			if (myself.location.x>(environmentWidth-5)){ //dies when it reaches the other side
				do die;
			}
		}	
	}
	aspect base{
		draw sphere(1) color:#yellow;
	}
}

species electron skills:[moving3D]{	//electron
	reflex move{
		do wander_3D;
	}
	reflex forward2 when: (length(hole at_distance collision_range)>=1){
		if (rnd_float(100)<K2){ //reaction 2: electron + hole -> {}
			ask hole closest_to self{
				do die;
			}
			do die;
		}
	}
	aspect base{
		draw sphere(1) color:#silver;
	}
}

species hole skills:[moving3D]{ //hole
	reflex move{
		do wander_3D;
	}
	aspect base{
		draw sphere(2) color:#black;
	}
}

species cat_H2O skills:[moving3D]{ //cat-H2O
	reflex move{
		do wander_3D;
	}
	reflex forward7 when: ((length(electron at_distance collision_range)>=1)and(length(cat at_distance collision_range)>=1)){
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
	aspect base{
		draw cube(3) color:#purple;
	}
}

species cat_OH skills:[moving3D]{ //cat-OH -
	reflex move{
		do wander_3D;
	}
	aspect base{
		draw cube(3) color:#blue;
	}
}

species cat_H skills:[moving3D]{ //cat-H*
	reflex move{
		do wander_3D;
	}
	reflex forward8 when: (length(cat_H at_distance collision_range)>=1){
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
	aspect base{
		draw cube(3) color:#blue;
	}
}

species hydrogen skills:[moving3D]{ //H2
	float speed_of_floating <- 1.0;
	
	reflex move{
		ask self{
			do goto speed:speed_of_floating target:{myself.location.x,myself.location.y,environmentLength}; //floats to the top
		}	
	}
	aspect base{
		draw sphere(2) color:#cyan;
	}
}

species sulfide skills:[moving3D]{ //S 2- sulfide
	reflex move{
		do wander_3D;
		
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
	aspect base{
		draw sphere(2) color:#gold; 
	}
}

species OH skills:[moving3D]{ //OH - 
	reflex move{
		do wander_3D;
	}
	reflex forward14 when: (length(cat at_distance collision_range)>=1){
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
	aspect base{
		draw sphere(1) color:#blue;
	}
}

species HS skills:[moving3D]{ //HS -
	reflex move{
		do wander_3D;
	}
	reflex forward5 when: (length(cat at_distance collision_range)>=1){
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
	aspect base{
		draw sphere(2) color:#green;
	}
}

species cat_HS skills:[moving3D]{ //cat-HS -
	reflex move{
		do wander_3D;
	}
	reflex forward9 when: (length(hole at_distance collision_range)>=1){
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
	aspect base{
		draw cube(3) color:#green;
	}
}

species sulfite skills:[moving3D]{ //SO3 2- sulfite
	reflex move{
		do wander_3D;
	}
	reflex forward6 when: (length(cat at_distance collision_range)>=1){
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
	aspect base{
		draw sphere(2) color:#brown;
	}
}

species cat_sulfite skills:[moving3D]{ //cat-SO3 2-
	reflex move{
		do wander_3D;
	}
	aspect base{
		draw cube(3) color:#brown;
	}
}

species cat_HS0 skills:[moving3D]{ //cat-HS.
	reflex move{
		do wander_3D;
	}
	reflex forward10 when: (length(cat_OH at_distance collision_range)>=1){
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
	aspect base{
		draw cube(3) color:#orange;
	}
}

species cat_S0 skills:[moving3D]{ //cat-S. -
	reflex move{
		do wander_3D;
	}
	reflex forward11 when: (length(cat_HS0 at_distance collision_range)>=1){
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
	aspect base{
		draw cube(3) color:#yellow;
	}
}

species cat_HS2 skills:[moving3D]{ //cat-HS2 - 
	reflex move{
		do wander_3D;
		
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
	aspect base{
		draw cube(3) color:#yellowgreen;
	}
}

species HS2 skills:[moving3D]{ //HS2 -
	reflex move{
		do wander_3D;
	}
	reflex forward13 when: (length(sulfite at_distance collision_range)>=1){
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
	reflex bounce when: (length(photon at_distance collision_range)>=1){
		ask photon closest_to self{
			do move speed:5 heading:180;
		}
	}
	aspect base{
		draw sphere(2) color:#yellowgreen;
	}
}

species S2O3 skills:[moving3D]{ //S2O3 2-
	reflex move{
		do wander_3D;
	}
	reflex forward15 when: (length(cat at_distance collision_range)>=1){
		if (rnd_float(100)<K15){ //reaction 15: cat + S2O3 2- -> cat-S2O3 2-
			create cat_S2O3 number:1{
				location <- myself.location;
			}
			ask cat closest_to self{
				do die;
			}
			do die;
		}
	}
	aspect base{
		draw sphere(2) color:#orange;
	}
}

species cat_S2O3 skills:[moving3D]{ //cat-S2O3 2-
	reflex move{
		do wander_3D;
	}
	aspect base{
		draw cube(3) color:#orange;
	}
}
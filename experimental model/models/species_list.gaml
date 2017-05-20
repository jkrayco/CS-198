model species_list
import "../models/parameters.gaml"
import "../models/reaction_list.gaml"
import "../models/reaction_rate.gaml"
import "../models/reaction_radius.gaml"
import "../models/species_shape.gaml"
import "../models/species_size.gaml"

global {
}

species cat parent: parent_species skills:[moving3D]{ //catalyst
	int lives <- 94;	
	reflex move{
		do wander_3D;
		do reaction_3;		
	}
	reflex reflex_1 when: (length(photon at_distance collision_range)>=1){
		lives <- reaction_1(lives);
	}
	aspect base{
		draw sphere(cat_size) color:#red;
	}
}

species photon parent: parent_species skills:[moving3D]{ //hv	
	reflex move{
		do reaction_photon;
	}
	aspect base{
		draw sphere(photon_size) color:#lightyellow;
	}
}

species electron parent: parent_species skills:[moving3D]{	//electron
	reflex move{
		do wander_3D;
	}
	reflex reflex_2 when: (length(hole at_distance collision_range)>=1){
		do reaction_2;
	}
	aspect base{
		draw sphere(electron_size) color:#silver;
	}
}

species hole parent: parent_species skills:[moving3D]{ //hole
	reflex move{
		do wander_3D;
	}
	aspect base{
		draw sphere(electron_size) color:#black;
	}
}

species hydrogen parent: parent_species skills:[moving3D]{ //H2	
	reflex move{
		ask self{
			do goto speed:hydrogen_speed target:{myself.location.x,myself.location.y,environment_height}; //floats to the top
		}	
	}
	aspect base{
		draw sphere(hydrogen_size) color:#lightcyan;
	}
}

species cat_H parent: parent_species skills:[moving3D]{ //cat-H*
	reflex move{
		do wander_3D;
	}
	reflex reflex_8 when: (length(cat_H at_distance collision_range)>=1){
		do reaction_8;
	}
	aspect base{
		draw sphere(cat_size) color:#cyan;
	}
}

species cat_H2O parent: parent_species skills:[moving3D]{ //cat-H2O
	reflex move{
		do wander_3D;
	}
	reflex reflex_7 when: ((length(electron at_distance collision_range)>=1)and(length(cat at_distance collision_range)>=1)){
		do reaction_7;
	}
	aspect base{
		draw sphere(cat_size) color:#darkcyan;
	}
}

species OH parent: parent_species skills:[moving3D]{ //OH - 
	reflex move{
		do wander_3D;
	}
	reflex reflex_14 when: (length(cat at_distance collision_range)>=1){
		do reaction_14;
	}
	aspect base{
		draw sphere(oxygen_size) color:#blue;
	}
}

species cat_OH parent: parent_species skills:[moving3D]{ //cat-OH -
	reflex move{
		do wander_3D;
	}
	aspect base{
		draw sphere(cat_size) color:#darkblue;
	}
}

species HS parent: parent_species skills:[moving3D]{ //HS -
	reflex move{
		do wander_3D;
	}
	reflex reflex_5 when: (length(cat at_distance collision_range)>=1){
		do reaction_5;
	}
	aspect base{
		draw sphere(sulfur_size) color:#green;
	}
}

species cat_HS parent: parent_species skills:[moving3D]{ //cat-HS -
	reflex move{
		do wander_3D;
	}
	reflex reflex_9 when: (length(hole at_distance collision_range)>=1){
		do reaction_9;
	}
	aspect base{
		draw sphere(cat_size) color:#darkgreen;
	}
}

species sulfite parent: parent_species skills:[moving3D]{ //SO3 2- sulfite
	reflex move{
		do wander_3D;
	}
	reflex reflex_6 when: (length(cat at_distance collision_range)>=1){
		do reaction_6;
	}
	aspect base{
		draw sphere(sulfur_size) color:#brown;
	}
}

species cat_sulfite parent: parent_species skills:[moving3D]{ //cat-SO3 2-
	reflex move{
		do wander_3D;
	}
	aspect base{
		draw sphere(cat_size) color:#darkkhaki;
	}
}

species sulfide parent: parent_species skills:[moving3D]{ //S 2- sulfide
	reflex move{
		do wander_3D;
		do reaction_4;
	}
	aspect base{
		draw sphere(sulfur_size) color:#yellow; 
	}
}

species cat_S0 parent: parent_species skills:[moving3D]{ //cat-S. -
	reflex move{
		do wander_3D;
	}
	reflex reflex_11 when: (length(cat_HS0 at_distance collision_range)>=1){
		do reaction_11;
	}
	aspect base{
		draw sphere(cat_size) color:#gold;
	}
}

species cat_HS0 parent: parent_species skills:[moving3D]{ //cat-HS.
	reflex move{
		do wander_3D;
	}
	reflex reflex_10 when: (length(cat_OH at_distance collision_range)>=1){
		do reaction_10;
	}
	aspect base{
		draw sphere(cat_size) color:#lightseagreen;
	}
}

species HS2 parent: parent_species skills:[moving3D]{ //HS2 -
	reflex move{
		do wander_3D;
	}
	reflex reflex_13 when: (length(sulfite at_distance collision_range)>=1){
		do reaction_13;
	}
	reflex bounce when: (length(photon at_distance collision_range)>=1){
		ask photon closest_to self{
			do move speed:5 heading:180;
		}
	}
	aspect base{
		draw sphere(sulfur_size) color:#seagreen;
	}
}

species cat_HS2 parent: parent_species skills:[moving3D]{ //cat-HS2 - 
	reflex move{
		do wander_3D;
	}
	reflex reflex_12 {
		do reaction_12;
	}
	aspect base{
		draw sphere(cat_size) color:#mediumseagreen;
	}
}

species S2O3 parent: parent_species skills:[moving3D]{ //S2O3 2-
	reflex move{
		do wander_3D;
	}
	reflex reflex_15 when: (length(cat at_distance collision_range)>=1){
		do reaction_15;
	}
	aspect base{
		draw sphere(sulfur_size) color:#orange;
	}
}

species cat_S2O3 parent: parent_species skills:[moving3D]{ //cat-S2O3 2-
	reflex move{
		do wander_3D;
	}
	aspect base{
		draw sphere(cat_size) color:#darkorange;
	}
}
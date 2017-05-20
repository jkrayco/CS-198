model initialize	//lives + k1c + bounce2 + equilibrium
import "../models/species_list.gaml"

global{
	//create initial number of species
	init{
		create photon number:initial_photon{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}
		create cat number:initial_cat{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create sulfide number:initial_sulfide{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create sulfite number:initial_sulfite{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create hydrogen number:initial_hydrogen{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create electron number:initial_electron{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create hole number:initial_hole{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create cat_H2O number:initial_catH2O{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create cat_OH number:initial_catOH{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create cat_H number:initial_catH0{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create HS number:initial_HS{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create OH number:initial_OH{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create cat_HS number:initial_catHS{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create cat_sulfite number:initial_catSulfite{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create cat_HS0 number:initial_catHS0{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create cat_S0 number:initial_catS0{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}	
		create cat_HS2 number:initial_catHS2{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}
		create HS2 number:initial_HS2{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}
		create S2O3 number:initial_S2O3{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}
		create cat_S2O3 number:initial_catS2O3{
			location <- {rnd(environment_width),rnd(environment_height),rnd(environment_length)};
		}
	}
}
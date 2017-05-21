model parameters	//lives + k1c + bounce2 + equilibrium
import "../models/species_list.gaml"

global{
	float k <- 7.0;
	float K1d <- 0.0;
	
	//batch variables
	string batch_code <- "model";
	string var_code <- "";
	int cph <- int(2100/4);
	int run <- 1;
	int side <- 70;
	
	//environment
	int environment_width <- side;	//x-axis
	int environment_height <- side;	//y-axis
	int environment_length <- side;	//z-axis
	geometry shape <- box(environment_width, environment_length, environment_height); //beaker represented as a cube
		
	//initial number of constant objects
	int initial_photon <- 800;//int((side^2)/3);		
	int initial_cat <- 400;
	int initial_sulfide <- 240;
	int initial_sulfite <- 240;
	int initial_hydrogen <- 0;
	int initial_electron <- 0;
	int initial_hole <- 0;
	int initial_catH2O <- 0;
	int initial_HS <- 0;
	int initial_OH <- 0;
	int initial_catHS <- 0;
	int initial_catSulfite <- 0;
	int initial_catH0 <- 0;
	int initial_catOH <- 0;
	int initial_catHS0 <- 0;
	int initial_catS0 <- 0;
	int initial_catHS2 <- 0;
	int initial_HS2 <- 0;
	int initial_S2O3 <- 0;
	int initial_catS2O3 <- 0;
	
	//initial number of variable objects
	//int list_cat <- [100, 300, 400, 800];
	//int list_sulfide <- [12, 24, 60, 120, 240, 720];
	//int list_sulfite <- [24, 60, 120, 240, 720];
}
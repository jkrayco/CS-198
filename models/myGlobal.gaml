model myGlobal	//lives + k1c + bounce2 + equilibrium
import "../models/mySpecies.gaml"

global{
	//batch variables
	string batchCode <- "model1l";
	int cph <- int(2100/4);
	int run <- 1;
	int side <- 70;
	
	//environment
	int environmentWidth <- side;	//x-axis
	int environmentHeight <- side;	//y-axis
	int environmentLength <- side;	//z-axis
	geometry shape <- box(environmentWidth, environmentLength, environmentHeight); //beaker represented as a cube
		
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
	list list_cat <- [100, 300, 400, 800];
	list list_sulfide <- [12, 24, 60, 120, 240, 720];
	list list_sulfite <- [24, 60, 120, 240, 720];
	
	//rates of the 15 reactions
	float K1 <- 28.0;	//hv + cat -> cat + electron + hole				
	float K2 <- 98.0;	//electron + hole -> {} 						
	float K3 <- 0.030;	//cat + H2O -> cat-H2O 							
	float K4 <- 0.16;	//S 2- + H2O -> HS- + OH -						
	float K5 <- 90.00;	//cat + HS - -> cat-HS -							
	float K6 <- 0.30;	//cat + SO3 2- -> cat-SO3 2-						
	float K7 <- 90.0;	//cat-H2O + cat + electron -> cat-H. + cat-OH - 	
	float K8 <- 100.0;	//2cat-H. -> 2cat + H2
	float K9 <- 98.0;	//cat-HS - + hole -> cat-HS. 						
	float K10 <- 51.0;	//cat-HS. + cat-OH - -> cat-S. - + cat + H2O			
	float K11 <- 93.0;	//cat-HS. + cat-S. - -> cat-HS2 - + cat					
	float K12 <- 0.11;	//cat-HS2 - -> cat + HS2 -								
	float K13 <- 70.0;	//HS2 - + SO3 2- -> S2O3 2- + HS -						
	float K14 <- 0.051;	//cat + OH - -> cat-OH - 								
	float K15 <- 8.95;	//cat + S2O3 2- -> cat-S2O3 2-	
	
	int collision_range <- 5;
	
	//create initial number of species
	init{
		create photon number:initial_photon{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}
		create cat number:initial_cat{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create sulfide number:initial_sulfide{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create sulfite number:initial_sulfite{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create hydrogen number:initial_hydrogen{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create electron number:initial_electron{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create hole number:initial_hole{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create cat_H2O number:initial_catH2O{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create cat_OH number:initial_catOH{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create cat_H number:initial_catH0{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create HS number:initial_HS{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create OH number:initial_OH{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create cat_HS number:initial_catHS{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create cat_sulfite number:initial_catSulfite{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create cat_HS0 number:initial_catHS0{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create cat_S0 number:initial_catS0{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}	
		create cat_HS2 number:initial_catHS2{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}
		create HS2 number:initial_HS2{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}
		create S2O3 number:initial_S2O3{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}
		create cat_S2O3 number:initial_catS2O3{
			location <- {rnd(environmentWidth),rnd(environmentHeight),rnd(environmentLength)};
		}
		if (run = 1){
			save ["run", "cat", "S", "SO3", "H2", "photon", "electron", "hole", "cat_H2O", "HS", "OH", "cat_HS", "cat_sulfite", "cat_H", "cat_OH", "cat_HS0", "cat_S0", "cat_HS2", "HS2", "S2O3", "cat_S2O3"] to: batchCode+"_hour4.csv" type:csv;
			save ["run", "time", "cat", "S", "SO3", "H2", "photon", "electron", "hole", "cat_H2O", "HS", "OH", "cat_HS", "cat_sulfite", "cat_H", "cat_OH", "cat_HS0", "cat_S0", "cat_HS2", "HS2", "S2O3", "cat_S2O3"] to: batchCode+".csv" type:csv;
		}
	}
	
	reflex updateLight {
		create photon number:((initial_photon-length(photon))*rnd(200)/100){
			location <- {0,rnd(environmentHeight),rnd(environmentLength)}; //new photons arrive
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
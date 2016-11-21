model model1n	//lives + k1c + bounce3 + equilibrium2

global{
	//batch variables
	string batchCode <- "";
	int cph <- int(2100/4);
	int run <- 1;
	int side <- 70;
	int bounce <- 5;
	
	//environment
	int environmentWidth <- side;	//x-axis
	int environmentHeight <- side;	//y-axis
	int environmentLength <- side;	//z-axis
	geometry shape <- box(environmentWidth, environmentLength, environmentHeight); //beaker represented as a cube
		
	//initial number of molecules
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
				do move speed:bounce heading:180;
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
		if (rnd_float(100)<K6 and length(cat_sulfite)<80){ //reaction 6: cat + SO3 2- -> cat-SO3 2- #Equilibrium 
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
			do move speed:bounce heading:180;
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

//experiment now type:gui {
experiment now type:gui {
	//parameter "Photons: " var:initial_photon min:1 max:500 category:"Photons";
	//parameter "Catalyst: " var:initial_cat min:1 max:200 category:"Catalyst agents";
	//parameter "Sulfide: " var:initial_sulfide min:0 max:500 category:"S2 agents";
	//parameter "Sulfite: " var:initial_sulfite min:0 max:500 category:"SO3 agents";
	 
	output{
		//shows all agents involved in the hydrogen reaction
		/*display all type:opengl{
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
		/*
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
		*/
		//displays a chart indicating the number of molecules of each agent over time
		/*
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
		*/
	}
}

experiment batch type:batch repeat:1 until: (cycle = (cph*4)+1){//cycle = (cph*8)+1)){
	parameter "Batch Code" var: batchCode among: ["model1n_cat_bounce4"];
	parameter "Bounce" var: bounce among: [4];
	parameter "Catalyst:" var: initial_cat among: [100, 300, 400, 800];
	//parameter "Sulfide:" var: initial_sulfide among:[12, 24, 60, 120, 240, 720];
	//parameter "Sulfite:" var: initial_sulfite among:[24, 60, 120, 240, 720];
	parameter "Run:" var: run among: [1,2,3];
}
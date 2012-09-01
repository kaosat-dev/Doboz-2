// Doboz 2 H-bot reprap 
//It is licensed under the Creative Commons -Attribution-NonCommercial-ShareAlike licence
// © 2012 by Mark "Ckaos" Moissette
//http://www.thingiverse.com/thing:27202

include <MCAD/stepper.scad>
include <MCAD/bearing.scad>
include <MCAD/nuts_and_bolts.scad>


////////////X ENDS
//TODO: adjust lateral mount bolt head size for x ends -->DONE
//TODO: enlarge y bearinjg and x rods holes slightly-->DONE
//TODO: adjust belt notch height based on correct washer height-->DONE
//TODO , either move current top assemlby hole or add another-->DONE
//TODO : check x arm offset extra -->DONE
//TODO : modify parametrization of belt bearing holder-->DONE
//TODO: fix x_ends left right/ front back logic-->DONE
////////////X CARRIAGE
//TODO: fix payload mount holes distance to border -->DONE
//TODO : fix belt idler (front) hole size -->DONE
//TODO: fix tightening mechanism?-->DONE?
//TODO: print & test single bearing version -->DONE 
////////////Z PLATFORM
//TODO: fix all the "back" elements correctly (not just thrown together like right now)-->DONE
//TODO: cleanup/refactor all elements-->DONE
//TODO: improve mounting arms-->DONE
//TODO: fix nut hole cap/nut heights (should default to actual nut neight/ cap height)-->DONE
//TODO : fix mounting sections assembly IT IS ALLL WRONG !! only amount of ok overlap in the current version can be 23.0003 , the width of the blocks-->DONE
////////////GENERAL
//TODO: decide on width vs length structure

//INFO ON CURRENT PROTOTYPE MACHINE
//max X movement:220
//max Y movement:330
//Target max X:250
//Target max Y:300
//Max gain on X by modyfing X ends : 18 *2
///////////////////////////////
// USER PARAMETERS
///////////////////////////////
$fs=0.2; // def 1, 0.2 is high res
$fa=3;//def 12, 3 is very nice


machine_length=380;//455;
machine_width=455;//380;
machine_height=445;
angle_extrusions_width=30;
angle_extrusions_thickness=2;
bottom_extrusions_width=50;

z_axis_extrusion_width=40;

y_rods_dia=8;
y_rods_dist=390;//325;
y_rods_len= 325;//430;
y_rods_z_dist=432;

y_rod_holder_width=25;
y_rod_holder_height=25;
y_rod_holder_bolt_dia=4;


//////x elements//////
x_rods_dia=8;
x_rods_bearing_dia=15;
x_rods_dist=30;
x_rods_len=y_rods_dist-50;
x_rods_z_dist=408;

x_platform_width=40;
x_platform_length=20;
x_platform_height=50;

x_end_width=18;
x_end_length=25;
/////////////////////////////

z_rod_len=370;
z_s_rods_dist=200;
z_platform_with=315;//260;
z_platform_length=255;//315;

z_coupling_dia=20;
z_coupling_height=25;

pulley_od=28;
pulley_height=11.5;
pulley_feet_od=18;
pulley_feet_height=6;

belt_thickness=1.5;
belt_width=6;

xtra=0.1;
tolerance = +0.0001;

FRONT = "front";
BACK = "back";
LEFT="left";
RIGHT="right";
BOTH = "both";

TIGHTENER="tght";

//for mount holes module
CAP = "cap";
NUT = "nut";

//other
NAN="nan";

MECHA_COLOR =[ 1.0, 0.46, 0.2 ];//[ 1.0, 0.85, 0.0 ]; //
STRUCT_COLOR =[ 0.95, 0.95, 0.95];
///////////////////////////////
//example usage

//draw all
//doboz();

//x_end(half=BOTH);
//mirror([1,0,0]) x_end(half=BACK);
//%x_end(half=BACK);

//mirror([1,0,0]) x_end(half=FRONT);
//%x_end(half=FRONT);



//z_platform_holder();
//%rotate([-90,0,0])y_end();
//rotate([-90,0,0])y_end2();

//foot();

//x_carriage(side=RIGHT);
//x_carriage(side=TIGHTENER);
//translate([0,50,0])x_carriage(side=RIGHT);

//tool_head([0,-28,0]);

 //z_end();

rotate([-90,0,0]) pen_holder();
///////////////////////////////
// OpenSCAD SCRIPT
////////////////////////////////

module doboz()
{
	belts_z_pos = machine_height-bottom_extrusions_width+pulley_feet_height+pulley_height/2;
	x_belt_len=x_rods_len+20;//285;

	//rods
	for(i= [-1,1])
	% translate([y_rods_dist/2*i,0,y_rods_z_dist]) rotate([90,0,0])cylinder(r=y_rods_dia/2, h=y_rods_len, center=true);
	for(i= [-1,1])
	//% translate([0,0,x_rods_z_dist+i*x_rods_dist/2]) rotate([0,90,0])cylinder(r=x_rods_dia/2, h=x_rods_len, center=true);
	% translate([0,0,x_rods_z_dist+i*x_rods_dist/2]) rotate([0,90,0])cylinder(r=x_rods_dia/2, h=x_rods_len, center=true);
	
	//z
	 %translate([0,machine_length/2-bottom_extrusions_width/2,10]) cylinder(r=x_rods_dia/2, h=z_rod_len);
	for(i= [-1,1])
	 %translate([-z_s_rods_dist/2*i,machine_length/2-bottom_extrusions_width/2,10]) cylinder(r=x_rods_dia/2, h=z_rod_len+15);
	

	//structure
	color([ 0.9, 0.9, 0.8 ])
	{
	//front and back vertical
	/*for(i= [-1,1])
	for(j= [-1,1])
	translate([(machine_width/2)*i,j*machine_length/2,0])  mirror([1+i,j+1,0])
	{
		cube([angle_extrusions_width,angle_extrusions_thickness,machine_height]);
		cube([angle_extrusions_thickness,angle_extrusions_width,machine_height]);
	}
	//front and back horizontal
	
	for(i= [-1,1])
	for(j= [0,1])
	translate([-machine_width/2,(-machine_length/2+angle_extrusions_thickness)*i,(machine_height-bottom_extrusions_width)*j]) mirror([0,i-1,0])
	{
		cube([machine_width,angle_extrusions_thickness,bottom_extrusions_width]);
		cube([machine_width,bottom_extrusions_width,angle_extrusions_thickness]);
	}

	for(i= [-1,1])
	for(j= [0,1])
	translate([(-machine_width/2+angle_extrusions_thickness)*i,-machine_length/2,(machine_height-bottom_extrusions_width)*j]) mirror([1-i,0,0])
	{
		cube([bottom_extrusions_width,machine_length,angle_extrusions_thickness]);
		cube([angle_extrusions_thickness,machine_length,bottom_extrusions_width]);

	}*/
	}
	

	//platform
	//color([ 0.6, 0.6, 0.6]) translate([0,20,machine_height/2+50])  cube([z_platform_with,z_platform_length,4],center=true);
	//coupling
	color([ 0.6, 0.6, 0.6]) translate([0,machine_length/2-bottom_extrusions_width/2,370])  cylinder(r=z_coupling_dia/2, h=z_coupling_height);

	//steppers
	translate([machine_width/2-angle_extrusions_width,machine_length/2-bottom_extrusions_width/2,machine_height-bottom_extrusions_width]) mirror([0,0,1]) 
 	rotate([0,0,45])motor(Nema17, size=NemaLong, dualAxis=false);

	translate([-machine_width/2+angle_extrusions_width,machine_length/2-bottom_extrusions_width/2,machine_height-bottom_extrusions_width]) mirror([0,0,1]) 
	 rotate([0,0,45])motor(Nema17, size=NemaLong, dualAxis=false);

	translate([0,machine_length/2-bottom_extrusions_width/2,machine_height-bottom_extrusions_width+angle_extrusions_thickness]) 
	 motor(Nema17, size=NemaLong, dualAxis=false);

	module latteral_belt_and_pulleys(pos=[0,0,0])
	{
		translate(pos)
		{
		pulley(pos=[0,-machine_length/2+bottom_extrusions_width/2,machine_height-bottom_extrusions_width]);
		pulley(pos=[0,machine_length/2-bottom_extrusions_width/2,machine_height-bottom_extrusions_width]);
		belt(pos=[0,0,belts_z_pos],pulley_dia=24);
		}
	}
	
	//main pulleys & belts
	latteral_belt_and_pulleys([y_rods_dist/2,0,0]);
	latteral_belt_and_pulleys([-y_rods_dist/2,0,0]);

	// x belt 
	translate([-x_belt_len/4,-14,belts_z_pos]) color([ 0.3, 0.3, 0.3 ]) cube([x_belt_len/2.2,belt_thickness,belt_width], center=true);
	translate([x_belt_len/4,-14,belts_z_pos]) color([ 0.3, 0.3, 0.3 ]) cube([x_belt_len/2.2,belt_thickness,belt_width], center=true);

	translate([0,14,belts_z_pos]) color([ 0.3, 0.3, 0.3 ]) cube([x_belt_len,belt_thickness,belt_width], center=true);


	//size ref
	//%cube([machine_width,machine_length,angle_extrusions_thickness], center=true);
	
	mount_platform();
	mount_platform([0,0,machine_height-bottom_extrusions_width]);
	module mount_platform(pos=[0,0,0], thickness=5)
	{
		width = machine_width;
		length=machine_length;
		color(STRUCT_COLOR)
		translate(pos)
		{
			difference()
			{
				cube([width,length,thickness], center=true);
				
				translate([0,0,-0.1])
				{
				cube([width-bottom_extrusions_width*2,length-bottom_extrusions_width*2,thickness*2], center=true);

				translate([width/2,-length/2,0]) rotate([0,0,45])cube([40,40,thickness*2],center=true);
				translate([-width/2,-length/2,0]) rotate([0,0,45])cube([40,40,thickness*2],center=true);

				translate([width/2,length/2,0]) rotate([0,0,45])cube([40,40,thickness*2],center=true);
				translate([-width/2,length/2,0]) rotate([0,0,45])cube([40,40,thickness*2],center=true);
				}
			}
		}
	}

	border_planks();
	border_planks([0,0,machine_height-bottom_extrusions_width+5]);
	module border_planks(pos=[0,0,0], thickness=5)
	{
		width = machine_width-60;
		length=machine_length-60;
		height=45;
		color(STRUCT_COLOR)
		translate(pos)
		{
			translate([0,0,height/2]) 
			{
				translate([0,-machine_length/2,0]) cube([width,thickness,height], center=true);
				translate([0,machine_length/2,0]) cube([width,thickness,height], center=true);

				translate([-machine_width/2,0,0]) cube([thickness,length,height], center=true);
				translate([machine_width/2,0,0]) cube([thickness,length,height], center=true);
			}
		}	
	}

	//////////////////////////////////////////////////
	////////////actual elements////////////

	for(i= [-1,1]) for(j= [-1,0])  mirror([0,j,0]) y_end2([y_rods_dist/2*i ,machine_length/2-2*angle_extrusions_thickness-15,y_rods_z_dist]);
	
	translate([0,0,x_rods_z_dist])
	x_carriage();


	for(i= [-1,1])
	mirror([(i+1)*1,0,0]) x_end([-y_rods_dist/2,0,y_rods_z_dist]);

	translate([0,machine_length/2-bottom_extrusions_width/2,machine_height/2])z_platform_holder(srods_dist=z_s_rods_dist);


	for(i= [-1,1]) translate([(machine_width/2-angle_extrusions_width/2)*i,(-machine_length/2+angle_extrusions_width/2),0]) 
	rotate([0,0,90*(i+1)]) mirror([0,i-1,0]) foot();

	for(i= [-1,1]) translate([(machine_width/2-angle_extrusions_width/2)*i,(machine_length/2-angle_extrusions_width/2),0]) 
	rotate([0,0,-90]) mirror([0,i-1,0]) foot();

	
}


module pen_holder(pos=[0,0,0], rot=[0,0,0],id=12.3, arm_thickness=2.5, base_width=24.4,base_thickness=5, base_mount_bolt_dia=4, mount_dia=3, length=15, cut_size=8.5)
{
	
	cap_len_default = METRIC_NUT_THICKNESS[base_mount_bolt_dia]+tolerance+2; 
	mount_bolt_len = base_thickness+arm_thickness;

	mount_block_offset=2.5;

	cut_length=mount_block_offset+id/2+5;

	bla=mount_block_offset+id/2;

	mount_od=9.2;
	cap_len_m_od=METRIC_NUT_THICKNESS[mount_dia]+tolerance; 
	nut_len_m_od=METRIC_NUT_AC_WIDTHS[mount_dia]; 

	mount_width=2.5;


	r_cut_size =  METRIC_NUT_AC_WIDTHS[base_mount_bolt_dia] + tolerance; 
	echo(r_cut_size);

	translate(pos)
	rotate(rot)
	color(MECHA_COLOR)
	difference()
	{
		union()
		{
			cylinder(r=id/2+arm_thickness,h=length);
			translate([-base_width/2,id/2,0]) cube([base_width,base_thickness,length]);


			translate([cut_size/2,-id/2-arm_thickness,0]) cube([arm_thickness,id/2+arm_thickness*2,length]);
			translate([-cut_size/2-arm_thickness,-id/2-arm_thickness,0]) cube([arm_thickness,id/2+arm_thickness*2,length]);

			
			translate([cut_size/2,-bla,length/2-mount_od/2]) cube([mount_width,id,mount_od]);
			translate([-cut_size/2-mount_width,-bla,length/2-mount_od/2]) cube([mount_width,id,mount_od]);

			rotate([90,0,90])  rotate([0,0,90]) mount_hole([length/2,id/2+mount_block_offset,cut_size/2+mount_width/2], dia=mount_dia+2, length=mount_width,variant=CAP, cap_len=mount_width);
			rotate([90,0,90])  rotate([0,0,90]) mount_hole([length/2,id/2+mount_block_offset,-cut_size/2-mount_width/2], dia=mount_dia+2, length=mount_width,variant=NUT, nut_len=mount_width);
			
		}
		translate([0,0,-xtra/2]) cylinder(r=id/2,h=length+xtra);
		translate([-cut_size/2,-cut_length,0-xtra/2])cube([cut_size, cut_length,length+xtra+10]);

		//base mount
		rotate([90,0,0])mount_hole([0,length/2,-id/2-mount_bolt_len/2+xtra/2+2], dia=base_mount_bolt_dia, length=mount_bolt_len,cap_len=cap_len_default ,variant=CAP);

		rotate([90,0,90])   rotate([0,0,90]) mount_hole([length/2,id/2+mount_block_offset,0], dia=mount_dia, length=cut_size+2*mount_width+xtra,nut_len=mount_width/2,cap_len=mount_width/2);

		
	}
}

module z_platform_holder(width=100, len=300, platform_with=220, arms_with=8, t_rod_dia=8, s_rods_dia=8, srods_dist=200, bearing_dia=15, bearing_length=24, bearing_id=9,walls_thickness=4)
{
	t_rod_height=30;
	t_rod_dia_extra=0.8;
	arm_thickness=5.05;
	
	real_center=-z_platform_length/2-15;

	mount_overlap=13;
	linear_bearings_mount_length=20;
	arms_mount_length=(srods_dist-(4*linear_bearings_mount_length))/2+mount_overlap/2;

	echo("arms_mount_length ",arms_mount_length);


	module sr_holders(pos=[0,0,0], height=15, mount_bolt_dia=3)
	{
		translate(pos)
		difference()
		{
			union()
			{
		 		cylinder(r=s_rods_dia/2+walls_thickness, h=height);
				cube([40,20,5],center=true);
			}
		 	cylinder(r=s_rods_dia/2, h=height+xtra,center=true);
		}
	}


	module _hollowing(pos=[0,0,0], length=20, width=10, height=20 )
		{
			translate(pos)
			linear_extrude(height =height)
			{
				hull()
				{
					translate([length,0])	square([0.01,width],center=true);
					translate([width/2,0])circle(r=width/2); 
	
				}
			}
			translate(pos)translate([width/2,0,0]) cylinder(r=1 , h=100,center=true);
			
		}
	module _hollowing2(pos=[0,0,0], length=20, width=10, height=20 )
		{
			translate(pos)
			linear_extrude(height =height)
			{
				hull()
				{
					translate([length,0])	square([0.01,,width],center=true);
					translate([0,0])	square([0.01,width],center=true);
				}
			}
			
		}


	module _hollowing3(pos=[0,0,0], length=20, width=10, height=20 )
		{
			translate(pos)
			linear_extrude(height =height)
			{
				hull()
				{
					translate([length,0])	square([0.01,width],center=true);
					translate([width/2,0])circle(r=width/2); 
	
				}
			}
			translate(pos)translate([width/2,0,0]) cylinder(r=1 , h=100,center=true);
			
		}

	module center_block(pos=[0,0,0],spring_height=15, top_bottom_thickness=10, mount_length=50, mount_overlap=15, mount_bolt_dia=4)
	{
		nutRadius = METRIC_NUT_AC_WIDTHS[t_rod_dia]/2+tolerance;
		nutHeight = METRIC_NUT_THICKNESS[t_rod_dia]+tolerance;
		
		inner_height=nutHeight*2+spring_height;
		height=inner_height+top_bottom_thickness*2;
		//just a test
		height= bearing_length*2;
		od = nutRadius*2 + walls_thickness*2;
		
		mount_width=od;
		mount_total_lng=mount_length+mount_overlap/2;
		mount_bolt_dist=mount_total_lng-mount_overlap/2;
		hollowing_lng= mount_bolt_dist-mount_bolt_dia/2-od/2-walls_thickness;

		echo("center width", od, "height",height, "length",mount_total_lng);

		module _nut_hole(pos=[0,0,0])
		{
			translate(pos)
			{
			//central hole
			translate([0,0, -xtra/2])  cylinder(r=t_rod_dia/2+t_rod_dia_extra, h=height+top_bottom_thickness*2+xtra);
			translate([0,0,top_bottom_thickness])
			{
				//nut emplacement	
				 cylinder(r=nutRadius, h=inner_height+xtra, $fn=6);
			
				//back cut off
				translate([-nutRadius,0,0]) cube([nutRadius*2,nutRadius*2+walls_thickness,inner_height+xtra]);	
			}
			}
		}

		module _body(pos=[0,0,0], length=mount_total_lng, width=od, arms_width=10, height=height )
		{
			translate(pos)
			linear_extrude(height =height)
			{
				hull()
				{
					translate([length,0])	square([0.01,arms_width],center=true);
					translate([0,0])circle(r=width/2); 
					translate([-length,0])	square([0.01,arms_width],center=true);
	
				}
			}
		}
		module _half()
		{
			difference()
			{
				rotate([0,0,180]) _hollowing2([-mount_total_lng,0,0], length=mount_total_lng, width=od, height=height);
				//rotate([0,0,180]) _hollowing2([-mount_total_lng,0,0], length=mount_total_lng, width=12, height=height);
		
				_nut_hole();
				//mount assembly holes
				rotate([180,0,0])mount_hole([mount_bolt_dist,0,-height/2+xtra/4], dia=4, length=height+xtra, cap_len=5,variant=CAP);
			
				//overlap cut off
				_hollowing2([mount_total_lng-mount_overlap,-xtra/2,height/2], length=mount_overlap+xtra, width=od+xtra*2, height=height/2+xtra); 
			
				//////////test cut off
				//bottom
				//translate([-xtra/2,-od/2-xtra/2,-xtra/2])cube([mount_total_lng+xtra,od+xtra,10+nutHeight+xtra]);
				//top
				//translate([-xtra/2,-od/2-xtra/2,10+nutHeight])cube([mount_total_lng+xtra,od+xtra,height-10-nutHeight+xtra]);
			}
		}

	
		translate(pos)
		{
		_half();mirror([1,0,0]) _half();
			
		}

		//%translate([0,0,top_bottom_thickness])  cylinder(r=nutRadius, h=nutHeight, $fn=6);
		//translate([0,0,nutHeight+spring_height+top_bottom_thickness]) %cylinder(r=nutRadius, h=nutHeight, $fn=6);
	}

	module center_block2(pos=[0,0,0],spring_height=15, top_bottom_thickness=10, mount_length=50, mount_overlap=15, mount_bolt_dia=4)
	{
		nutRadius = METRIC_NUT_AC_WIDTHS[t_rod_dia]/2+tolerance;
		nutHeight = METRIC_NUT_THICKNESS[t_rod_dia]+tolerance;
		
		arm_width_extra=0.5;
		arm_mount_length=12;

		inner_height=nutHeight*2+spring_height;
		height=inner_height+top_bottom_thickness*2;
		//just a test
		height= bearing_length*2;
		od = nutRadius*2 + walls_thickness*2;
		
		mount_width=od;
		mount_total_lng=mount_length+mount_overlap/2;
		mount_bolt_dist=mount_total_lng-mount_overlap/2;
		hollowing_lng= mount_bolt_dist-mount_bolt_dia/2-od/2-walls_thickness;

		echo("center width", od, "height",height, "length",mount_total_lng);

		module _nut_hole(pos=[0,0,0])
		{
			translate(pos)
			{
			//central hole
			translate([0,0, -xtra/2])  cylinder(r=t_rod_dia/2+t_rod_dia_extra, h=height+top_bottom_thickness*2+xtra);
			translate([0,0,top_bottom_thickness])
			{
				//nut emplacement	
				 cylinder(r=nutRadius, h=inner_height+xtra, $fn=6);
			
			}
			}
		}

		module _body(pos=[0,0,0], length=mount_total_lng, width=od, arms_width=arm_thickness+2*walls_thickness, height=height )
		{
			translate(pos)
			linear_extrude(height =height)
			{
				hull()
				{
					translate([arm_mount_length+width/2,0])	square([0.01,arms_width],center=true);
					translate([0,0])circle(r=width/2); 
					translate([-arm_mount_length-width/2,0])	square([0.01,arms_width],center=true);
				}
			}
		}

		module _full()
		{
			difference()
			{
				_body();
				_nut_hole();
				//arm cut offs
				translate([nutRadius+walls_thickness,-arm_thickness/2,-xtra/2]) cube([arm_mount_length+xtra,arm_thickness,height+xtra]);
				rotate([0,0,180])translate([nutRadius+walls_thickness,-arm_thickness/2,-xtra/2]) cube([arm_mount_length+xtra,arm_thickness,height+xtra]);

				//mount assembly holes
				rotate([90,0,0])mount_hole([mount_total_lng/1.5,height/3,0], dia=4, length=od-2, cap_len=5, nut_len=6);
				rotate([90,0,0])mount_hole([mount_total_lng/1.5,height/1.5,0], dia=4, length=od-2, cap_len=5, nut_len=6);

				rotate([90,0,0])mount_hole([-mount_total_lng/1.5,height/3,0], dia=4, length=od-2, cap_len=5, nut_len=6);
				rotate([90,0,0])mount_hole([-mount_total_lng/1.5,height/1.5,0], dia=4, length=od-2, cap_len=5, nut_len=6);


				//////////test cut off

				translate([-mount_total_lng-xtra/2,0,0])cube([mount_total_lng*2+xtra,50,height]);
				//bottom
				//translate([-mount_total_lng-xtra/2,-od/2-xtra/2,-xtra/2])cube([mount_total_lng*2+xtra,od+xtra,10+nutHeight+xtra]);
				//top
				//translate([-mount_total_lng-xtra/2,-od/2-xtra/2,10+nutHeight])cube([mount_total_lng*2+xtra,od+xtra,height-10-nutHeight+xtra]);
			}
		}
		translate(pos)
		{
			_full();
		}

		//%translate([0,0,top_bottom_thickness])  cylinder(r=nutRadius, h=nutHeight, $fn=6);
		//translate([0,0,nutHeight+spring_height+top_bottom_thickness]) %cylinder(r=nutRadius, h=nutHeight, $fn=6);
	}

module center_block3(pos=[0,0,0],spring_height=15, top_bottom_thickness=10, mount_length=50, mount_overlap=15, mount_bolt_dia=4)
	{
		nutRadius = METRIC_NUT_AC_WIDTHS[t_rod_dia]/2+tolerance;
		nutHeight = METRIC_NUT_THICKNESS[t_rod_dia]+tolerance;
		
		arm_width_extra=0.5;
		arm_mount_length=8;

		inner_height=nutHeight*2+spring_height;
		
		//just a test
		height=20;// bearing_length*2;
		od = nutRadius*2 + walls_thickness*2;
		
		mount_width=od;
		mount_total_lng=mount_length+mount_overlap/2-8;

	
		echo("center width", od, "height",height, "length",mount_total_lng);

		center_offset=-nutRadius;
echo("prout", center_offset);

		block_width=od+arm_mount_length*2;

		nut_height_adjuster=-0.2;
		module _nut_hole(pos=[0,0,0])
		{
			translate(pos)
			{
		
				//central hole
				translate([0,0, -xtra/2-height])  cylinder(r=t_rod_dia/2+t_rod_dia_extra, h=height+top_bottom_thickness*2+xtra);
				translate([0,0,0])
				{
					//nut emplacement	
					 cylinder(r=nutRadius, h=nutHeight+nut_height_adjuster, $fn=6);
				}
				//back cut off
				translate([-nutRadius,0,0]) cube([nutRadius*2,nutRadius*2+walls_thickness,nutHeight+nut_height_adjuster]);	
			}
		}

		module _body(pos=[0,0,0], width=od, arms_width=walls_thickness, height=height )
		{
			translate(pos)
			linear_extrude(height =height)
			{
				hull()
				{
					translate([arm_mount_length+width/2,0])	square([0.01,arms_width],center=true);
					translate([0,center_offset])circle(r=width/2); 
					translate([-arm_mount_length-width/2,0])	square([0.01,arms_width],center=true);
				}
			}
		}

		module _full()
		{
			difference()
			{
				_body();
				_nut_hole([0,center_offset,height/2-nutHeight/2]);
				//arm cut offs
			//mount assembly holes
				//rotate([90,0,0])mount_hole([mount_total_lng/1.5,height/3,-center_offset-2], dia=4, length=od-2, cap_len=12, variant=CAP);
				//rotate([90,0,0])mount_hole([mount_total_lng/1.5,height/1.5,-center_offset], dia=4, length=od-2, cap_len=10, variant=CAP);

				//rotate([90,0,0])mount_hole([-mount_total_lng/1.5,height/3,-center_offset-3], dia=4, length=od-2, cap_len=10, variant=CAP);
				//rotate([90,0,0])mount_hole([-mount_total_lng/1.5,height/1.5,-center_offset], dia=4, length=od-2, cap_len=10, variant=CAP);

				rotate([90,0,0])mount_hole([-mount_total_lng/1.4,height/2,-center_offset-2], dia=4, length=od-2, cap_len=12, variant=CAP);
				rotate([90,0,0])mount_hole([mount_total_lng/1.4,height/2,-center_offset-2], dia=4, length=od-2, cap_len=12, variant=CAP);


				//////////test cut off

				translate([-block_width/2-xtra/2,0,-xtra/2])cube([block_width+xtra,40,height+xtra]);
				//bottom
				//translate([-mount_total_lng-xtra/2,-od/2-xtra/2,-xtra/2])cube([mount_total_lng*2+xtra,od+xtra,10+nutHeight+xtra]);
				//top
				//translate([-mount_total_lng-xtra/2,-od/2-xtra/2,10+nutHeight])cube([mount_total_lng*2+xtra,od+xtra,height-10-nutHeight+xtra]);
			}
		}
		translate(pos)
		{
			_full();
		}

		//%translate([0,0,top_bottom_thickness])  cylinder(r=nutRadius, h=nutHeight, $fn=6);
		//translate([0,0,nutHeight+spring_height+top_bottom_thickness]) %cylinder(r=nutRadius, h=nutHeight, $fn=6);
	}

	module linear_bearing_holders(pos=[0,0,0], mount_length=50, mount_overlap=15, mount_bolt_dia=4, mount_width= 23.0002, side=LEFT)
	{
		height= bearing_length*2;
		arm_holder_length=25;
		arm_holder_width=arm_thickness+2*walls_thickness+2;
		//arm_holder_width= bearing_dia+walls_thickness*2;
		arm_width_extra=0.5;
		arm_length =260;

		mount_total_lng=mount_length+mount_overlap/2;
		mount_bolt_dist=-mount_total_lng+mount_overlap/2;

		bearing_holder_dia=(bearing_dia/2+walls_thickness);
		echo("mount_total_lng",mount_total_lng);
		module _holder()
		{
		difference()
		{
			% translate([-arm_thickness/2,-arm_length-walls_thickness*3,-xtra/2])  cube([arm_thickness,arm_length,height]);
		 	union()
			{
				//arm holder
				linear_extrude(height =height)
				{
					hull()
					{
						translate([0,-arm_holder_length-bearing_holder_dia])	square([arm_holder_width,0.01],center=true);
						translate([0,0]) circle(r=bearing_dia/2+walls_thickness); 
					}
				}
				//mount stuff
				_hollowing2([-mount_total_lng,0,0], length=mount_total_lng, width=mount_width, height=height);
			}

			//arm notches
			translate([-arm_thickness/2-arm_width_extra/2,-arm_holder_length-walls_thickness*3,-xtra/2])cube([arm_thickness+arm_width_extra,arm_holder_length+walls_thickness*3,height+xtra]);
			//arm additional cut off
			rotate([90,180,90])_hollowing([mount_width/2,-xtra/2,-arm_holder_width], length=40, width=height, height=arm_holder_width*2+xtra); 
			//bearings hole
		 	rotate([0,90,0])bearing_retainer_hole([-height/2,0,0],height);
			
			//arm mount holes
			rotate([0,90,0])mount_hole([-height+height/4,-bearing_holder_dia -arm_holder_width/3+1,0], dia=4, length=arm_holder_width*1.5+xtra, nut_len=5, cap_len=5);
			rotate([0,90,0])mount_hole([-height+height/4,-bearing_holder_dia -arm_holder_width-3,0], dia=4, length=arm_holder_width*1.6+xtra, nut_len=5, cap_len=5);

			//mount overlap cutoff
			rotate([0,0,180])_hollowing2([mount_total_lng-mount_overlap,-xtra/2,-xtra/2], length=mount_overlap+xtra, width=mount_width+xtra*2, height=height/2+xtra); 
			//mount assembly holes
			mount_hole([mount_bolt_dist,0,height/2+xtra/2], dia=4, length=height+xtra, cap_len=15,variant=CAP);

		}
		}

		
		if (side ==LEFT)
		{
			translate(pos)_holder();
		}
		else if (side == RIGHT)
		{	mirror([1,0,0])translate(pos)_holder();
		}
	}


	module linear_bearing_holders2(pos=[0,0,0], mount_length=50, mount_overlap=15, mount_bolt_dia=4, mount_width= 23.0002, side=LEFT)
	{
		height= bearing_length*2;
		arm_holder_length=25;
		arm_holder_width=arm_thickness+2*walls_thickness+2;
	
		arm_width_extra=0.5;
		arm_length =260;

		back_arm_holder_length=14;


		bearing_holder_dia=(bearing_dia/2+walls_thickness);
		mount_total_lng=mount_length+mount_overlap/2;
		mount_bolt_dist=-bearing_holder_dia-back_arm_holder_length/2;
		mount_bolt_z_ref=(height-back_arm_holder_length)/2;
		mount_bolt_z_dist1=height-mount_bolt_z_ref+mount_bolt_z_ref/2;//mount_bolt_z_ref/3.5;
		mount_bolt_z_dist2=height-mount_bolt_z_ref-mount_bolt_z_ref/2;//mount_bolt_z_ref/1.5;

		echo("mount_bolt_z_dist1",mount_bolt_z_dist1,"mount_bolt_z_dist2",mount_bolt_z_dist2);
		
		echo("mount_total_lng",mount_total_lng);
		module _holder()
		{
		difference()
		{
			% translate([-arm_thickness/2,-arm_length-walls_thickness*3,-xtra/2])  cube([arm_thickness,arm_length,height]);
		 	union()
			{
				//arm holder
				linear_extrude(height =height)
				{
					hull()
					{
						translate([0,-arm_holder_length-bearing_holder_dia])	square([arm_holder_width,0.01],center=true);
						translate([0,0]) circle(r=bearing_dia/2+walls_thickness); 
					}
				}

				//mount stuff
				linear_extrude(height =height)
				{
					hull()
					{
						circle(r=bearing_dia/2+walls_thickness); 
						translate([-back_arm_holder_length-bearing_holder_dia,0])	square([0.01, arm_holder_width],center=true);
	
					}
				}
			}

			//arm notches
			translate([-arm_thickness/2-arm_width_extra/2,-arm_holder_length-walls_thickness*3,-xtra/2])cube([arm_thickness+arm_width_extra,arm_holder_length+walls_thickness*3,height+xtra]);
			//arm additional cut off
			rotate([90,180,90])_hollowing([mount_width/2,-xtra/2,-arm_holder_width], length=40, width=height, height=arm_holder_width*2+xtra); 
			//bearings hole
		 	rotate([0,90,0])bearing_retainer_hole([-height/2,0,0],height);
			
			//arm mount holes
			rotate([0,90,0])mount_hole([-height+height/4,-bearing_holder_dia -arm_holder_width/3+1,0], dia=4, length=arm_holder_width*1.5+xtra, nut_len=5, cap_len=5);
			rotate([0,90,0])mount_hole([-height+height/4,-bearing_holder_dia -arm_holder_width-3,0], dia=4, length=arm_holder_width*1.6+xtra, nut_len=5, cap_len=5);

			
			//mount assembly holes
			rotate([90,0,180]) mount_hole([-mount_bolt_dist,mount_bolt_z_dist1,0], dia=4, length=arm_holder_width+10, cap_len=7, nut_len=7);
			rotate([90,0,180]) mount_hole([-mount_bolt_dist,mount_bolt_z_dist2,0], dia=4, length=arm_holder_width+10, cap_len=7, nut_len=7);

			//arm cut offs
			rotate([0,0,180]) translate([bearing_holder_dia+xtra/2-1.2,-arm_thickness/2,-xtra/2]) cube([back_arm_holder_length+xtra+1.2,arm_thickness,height+xtra]);
				//-back_arm_holder_length-bearing_holder_dia-

			translate([-bearing_holder_dia-back_arm_holder_length+1,-20,0]) rotate([0,90,90]) cylinder(r=back_arm_holder_length, h=40);

		}
		}

		
		if (side ==LEFT)
		{
			translate(pos)_holder();
		}
		else if (side == RIGHT)
		{	mirror([1,0,0])translate(pos)_holder();
		}
	}


	module mount_arm(pos=[0,0,0],mount_length=50, mount_overlap=15, mount_bolt_dia=4, mount_width=12)
	{
		//mount_width=23.0002;
		height= bearing_length*2;
		mount_total_lng=mount_length+mount_overlap/2;
		mount_bolt_dist=mount_overlap/2;

		inner_hole_wth=mount_width-6;
		inner_hole_lng=mount_total_lng-2*mount_overlap-inner_hole_wth;
		
		translate(pos)
		difference()
		{
			_hollowing2([0,0,0], length=mount_total_lng, width=mount_width, height=height);

			//overlap cut off
			_hollowing2([mount_total_lng-mount_overlap,-xtra/2,height/2], length=mount_overlap+xtra, width=mount_width+xtra*2, height=height/2+xtra); 
			//overlap cut off 2
			_hollowing2([-xtra/2,-xtra/2,height/2], length=mount_overlap+xtra, width=mount_width+xtra*2, height=height/2+xtra); 

			//mount assembly holes
			mount_hole([mount_bolt_dist,0,height/2-xtra/2], dia=4, length=height+xtra, nut_len=15,variant=NUT);
			mount_hole([mount_total_lng-mount_overlap/2,0,height/2-xtra/2], dia=4, length=height+xtra, nut_len=15,variant=NUT);		

			//inner hole , to make it lightweight and spare plastic
			_hollowing([mount_total_lng/2-inner_hole_lng/2,0,-xtra/2], length=inner_hole_lng, width=inner_hole_wth, height=height+xtra);
			mirror([1,0,0])_hollowing([-mount_total_lng/2-inner_hole_lng/2,0,-xtra/2], length=inner_hole_lng, width=inner_hole_wth, height=height+xtra+10);

		}
	}

	module platform_adjuster(pos=[0,0,0],  bolt_dia=4, base_width=15, base_length=20, mount_pos=[15,-5],side=LEFT)
	{
		//INPUTS:
		//arm thickness
		//mount pos
		//mount bolt dia
		//base length
	
		arm_clamping_dist=bolt_dia+6;
		arm_clamp_top_thickness=4;
		base_height=arm_clamping_dist+arm_clamp_top_thickness;
		
		module _base(pos=[0,0,0])
		{
			translate(pos)
			difference()	
			{
				cube([base_width,base_length,base_height]);

				//cut to mount on arm
				translate([base_width/2-arm_thickness/2,-xtra/2,-xtra/2]) cube([arm_thickness,base_length+xtra,arm_clamping_dist]);

				// mount hole
				//translate([-xtra/2,base_length/2,3+bolt_dia/2]) rotate([0,90,0])	cylinder(r=bolt_dia/2, h=base_width+xtra); 	
				rotate([0,90,0]) mount_hole([-3-bolt_dia/2,base_length/2,base_width/2], dia=bolt_dia, length=base_width+xtra,nut_len=2);

			}
		}

		module _adjuster()
		{
			difference()
			{
				union()
				{
					linear_extrude(height =arm_clamp_top_thickness)
					{
						hull()
						{
							translate([base_width,0]) square([0.01,base_length]);
							translate([mount_pos[0]+base_width, mount_pos[1]]) circle(r=bolt_dia/2+walls_thickness); 	
							
						}
					}
					_base([0,0,-base_height+arm_clamp_top_thickness]);
					
					//mount hole extra block
					translate([mount_pos[0]+base_width, mount_pos[1], -arm_clamp_top_thickness]) cylinder(r=bolt_dia/2+walls_thickness, h=arm_clamp_top_thickness+xtra); 	
				}
				
				//platform mount hole
				translate([mount_pos[0]+base_width, mount_pos[1], -arm_clamp_top_thickness-xtra/2]) cylinder(r=bolt_dia/2, h=arm_clamp_top_thickness*2+xtra); 	
				
			}
		}

		translate(pos)
		if (side ==LEFT)
		{
			_adjuster();
		}
		else if (side == RIGHT)
		{	mirror([1,0,0])_adjuster();
		}
	}

	module thumbscrew(pos=[0,0,0],rot=[0,0,0], nb_teeth=5, teeth_min_dia=4, teeth_max_dia=6, teeth_length=6, teeth_offset=-2, center_dia=12,bolt_dia=4, thickness=4)
	{
		module _tooth(pos=[0,0,0], rot=[0,0,0])
		{
			rotate(rot)
			translate(pos)
			linear_extrude(height =thickness)
			{
				hull()
				{
					translate([0,teeth_length]) circle(r=teeth_min_dia/2);
					translate([0,teeth_length/1.5]) circle(r=teeth_max_dia/2); 	
					translate([0,0]) circle(r=teeth_min_dia/2);		
				}
			}
		}

		translate(pos)
		rotate(rot)
		{
			difference()
			{
				union()
				{
					for(i= [0:nb_teeth])
					_tooth([0,center_dia/2+teeth_offset,0],[0,0,i*(360/nb_teeth)]);
					cylinder(r=center_dia/2,h=thickness);
				}
				mount_hole([0,0,2], dia=bolt_dia, length=thickness+xtra,nut_len=2,variant=NUT);
			}
		}
	}

	color(MECHA_COLOR)
	{
		
		//mirror([0,0,1]) 
		%linear_bearing_holders2([srods_dist/2,0,0],mount_length=linear_bearings_mount_length,mount_overlap=mount_overlap);
		//mirror([0,0,1])
		%linear_bearing_holders2([srods_dist/2,0,0],mount_length=linear_bearings_mount_length,mount_overlap=mount_overlap, side=RIGHT);

		%translate([0,0,24]) cube([ srods_dist,5,48],center=true);
		//%translate([-87,-2.5,0]) cube([ arms_mount_length+10,5,48]);
	
		//%mount_arm([13,0,0], mount_length=arms_mount_length,mount_overlap=mount_overlap);
		//%mount_arm([-87,0,0], mount_length=arms_mount_length,mount_overlap=mount_overlap);
		//rotate([90,0,0])
		mirror([0,0,1]) 
		//center_block([0,0,-48],mount_length=linear_bearings_mount_length,mount_overlap=mount_overlap);

		//rotate([90,0,0]) 
		%center_block3([0,-3,-48],mount_length=linear_bearings_mount_length,mount_overlap=mount_overlap);
	
		//mirror([0,0,1])  platform_adjuster([0,0,0], side=RIGHT);
		%platform_adjuster([93,-260,48]);
		% platform_adjuster([-95,-260,48], side=RIGHT);
		%mirror([0,1,0] )platform_adjuster([93,35,48]);
		%mirror([0,1,0]) platform_adjuster([-93,35,48], side=RIGHT);


		mirror([0,0,1])thumbscrew();// thumbscrew([123,-265,-40]);
	}

}


module foot(pos=[0,0,0] ,element_width=45, element_thickness=5, vertical_element_angle=45, wall_thickness=5, block_height=30)
{
	color(STRUCT_COLOR)
	rotate([0,0,45])
	translate([0,0,222.5])
	cube([element_width,element_thickness,445],center=true);

	clamp_length=20;
	vert_holder_width=wall_thickness*2+element_thickness;
	block_angle_len = cos(vertical_element_angle) * element_width;
	block_width=clamp_length+vert_holder_width+block_angle_len;


	pt0_pos = [0,0];
	pt1_pos = [0,clamp_length];
	pt2_pos = [pt1_pos[0]+block_angle_len, pt1_pos[1]+block_angle_len];
	pt3_pos = [pt2_pos[0]+clamp_length,pt2_pos[1]];
	pt4_pos = [pt3_pos[0],pt3_pos[1]+vert_holder_width];
	pt5_pos = [pt2_pos[0]-element_thickness,pt4_pos[1]];
	pt6_pos = [-vert_holder_width,pt1_pos[1]+element_thickness];
	pt7_pos = [-vert_holder_width,0];

	
	color(STRUCT_COLOR)
	translate(pos)
	difference()
	{

		translate([-block_width/2+vert_holder_width,-block_width/2,0])
		linear_extrude(height=block_height)
		{

			
			polygon(points = [
			pt0_pos,
			pt1_pos,
			pt2_pos,
			pt3_pos,
			pt4_pos,
			pt5_pos,
			pt6_pos,
			pt7_pos
			]
			,paths = [[0,1,2,3,4,5,6,7]]);
		}
		
		translate([-block_width/2+vert_holder_width,-block_width/2,0])
		{
		translate([-vert_holder_width/2-element_thickness/2,-xtra/2,-xtra/2])cube([element_thickness,clamp_length,block_height+xtra]);
		translate([block_width/2-1.5,block_width-vert_holder_width/2-element_thickness/2,-xtra/2]) cube([clamp_length,element_thickness,block_height+xtra]);
		}

		rotate([0,0,45]) cube([element_width,element_thickness,102],center=true);
		
		
	}
	
	
}


module y_end2(pos=[0,0,0], rod_dia=8, width=48, length=6, height=25, holder_length=25, holder_height=5,  holder_length=8,walls_thickness=3, end_fill_thickness =1)
{
	mount_bolt_dia=4;
	mount_bolt_x_dist=35;
	mount_bolt_z_dist=12;

	extra_hole_x_offset= width/2-11;
	extra_hole_z_offset = height/2-13.2;

	
	mount_holes_wall_thickness=2;
	rod_hole_adjuster=0.2;

	nut_height = METRIC_NUT_THICKNESS[mount_bolt_dia]+tolerance;

	color(MECHA_COLOR)
	translate(pos)
	difference()
	{
		union()
		{
			
		 	translate([0,-length,0]) rotate([90,0,0])cylinder(r=rod_dia/2+walls_thickness, h=holder_length);

			 rotate([90,0,0]) 
			linear_extrude(height =length)
			{
				hull()
				{
					translate([-extra_hole_x_offset,extra_hole_z_offset,0])circle(r=mount_bolt_dia+mount_holes_wall_thickness);
					circle(r=rod_dia/2+walls_thickness);
					translate([extra_hole_x_offset,extra_hole_z_offset,0])circle(r=mount_bolt_dia+mount_holes_wall_thickness);

					//translate([mount_bolt_x_dist/2,mount_bolt_z_dist/2,0]) circle(r=mount_bolt_dia+mount_holes_wall_thickness);
					//translate([mount_bolt_x_dist/2,-mount_bolt_z_dist/2,0]) circle(r=mount_bolt_dia+mount_holes_wall_thickness);
				}
			}

		}

		//rod hole
		translate([0,-end_fill_thickness+xtra/2,0]) rotate([90,0,0])  cylinder(r=rod_dia/2+rod_hole_adjuster, h=length+holder_length-end_fill_thickness+xtra);

		translate([-extra_hole_x_offset,0+xtra/2,height/2-13.2]) rotate([90,0,0])  cylinder(r=2, h=length+xtra);
		translate([-extra_hole_x_offset,-length+nut_height-xtra/2,height/2-13.2])  rotate([90,0,0])	 nutHole(mount_bolt_dia);

		translate([extra_hole_x_offset,0+xtra/2,height/2-13.2]) rotate([90,0,0])  cylinder(r=2, h=length+xtra);
		translate([extra_hole_x_offset,-length+nut_height-xtra/2,height/2-13.2])  rotate([90,0,0])	 nutHole(mount_bolt_dia);

		/*for(i= [1]) for(j= [-1,1]) 
		{
			translate([mount_bolt_x_dist/2*i,xtra/2,mount_bolt_z_dist/2*j]) rotate([90,0,0]) cylinder(r=mount_bolt_dia/2, h=length+xtra);
			translate([mount_bolt_x_dist/2*i,-length+nut_height-xtra/2,mount_bolt_z_dist/2*j])  rotate([90,0,0]) nutHole(mount_bolt_dia);
		}*/
	}
}


module z_end(pos=[0,0,0], rod_dia=8, width=48, length=6, height=25, holder_length=25, holder_height=5,  holder_length=8,walls_thickness=3, end_fill_thickness =1)
{
	mount_bolt_dia=4;
	
	holes_offset=[width/2-11, height/2-13.2];
holes_offset=[width/2-11,0];

	mount_holes_wall_thickness=2;
	rod_hole_adjuster=0.2;

	nut_height = METRIC_NUT_THICKNESS[mount_bolt_dia]+tolerance;

	color(MECHA_COLOR)
	translate(pos)
	difference()
	{
		union()
		{
			
		 	translate([0,0,length]) cylinder(r=rod_dia/2+walls_thickness, h=holder_length);

			linear_extrude(height =length)
			{
				hull()
				{
					translate([-holes_offset[0],holes_offset[1],0])circle(r=mount_bolt_dia+mount_holes_wall_thickness);
					circle(r=rod_dia/2+walls_thickness);
					translate([holes_offset[0],holes_offset[1],0])circle(r=mount_bolt_dia+mount_holes_wall_thickness);
				}
			}
		}

		//rod hole
		translate([0,0,end_fill_thickness+xtra/2]) cylinder(r=rod_dia/2+rod_hole_adjuster, h=length+holder_length-end_fill_thickness+xtra);


		translate([-holes_offset[0], holes_offset[1],-xtra/2])   cylinder(r=2, h=length+xtra);
		translate([-holes_offset[0],holes_offset[1],length-nut_height+xtra/2])	 nutHole(mount_bolt_dia);

		translate([holes_offset[0], holes_offset[1],-xtra/2])   cylinder(r=2, h=length+xtra);
		translate([holes_offset[0],holes_offset[1],length-nut_height+xtra/2])	 nutHole(mount_bolt_dia);


	}
}

module x_carriage(bearing_id=8, rod_dist=30, width=40, length=30, height=50, bearing_dia=15, bearing_length=24, bearing_cap_id=14.5, belt_width=6, belt_thickness=1.5, walls_thickness=4, side=BOTH)
{
	holes_min_border=2;
	//TODO: cleanup
	
	x_end_length=26;

	belt_tensionner_holder_thickness=4;
	belt_tensionner_holder_dia=7;
	belt_tensionner_bolt_dia=4;
	bearings_hole_extra= 0.15;


	end_caps_length= 0.7;//for bearing retaining
	block_width =(bearing_length+end_caps_length)*1.0;
echo(block_width);

	length = walls_thickness*2+bearing_dia;

	
	belt_bearing_dims=bearingDimensions(624);//inner, outer, width
	belt_bearings_y_dist=belt_bearing_dims[1]+x_end_length+belt_thickness*2;
	belt_guides_width =4;

	//for all belt holes
	belt_width_extra=0.5;
	belt_hole_width= belt_width + belt_width_extra;
	belt_y_pos = -belt_bearings_y_dist/2+belt_bearing_dims[2]+belt_thickness*1.5;//distance of belts to center

	//extra elements
	payload_bolts_dia=4;
	payload_holes_dist=28; //mounting holes distance for payload/toolhead

	//general dimentions:
	block_height=bearing_dia+rod_dist-4;
	total_height=block_height+length;

	//used only to generate  cut off "halves"
	cutoff_dims=[block_width, length+50 ,block_height+50];

	echo("carriage:","height",total_height, "width",block_width);
	
	
	module belt_tightener(pos=[0,0,0],  length=3, height=belt_width+3*2, buckle_hole_width=2, buckle_hole_dist=3)
	{
		belt_width_extra=0.5;
		belt_hole_length = belt_width + belt_width_extra;
		width = block_width *2 - belt_guides_width*2;

		hammer_len=1.5;
		hammer_hole_len=length+hammer_len-1;

		translate(pos)
		difference()
		{
			union()
			{
				cube([width,length,height], center=true);
				//for tightener only, not joiner
				translate([0,length/2+hammer_len/2,0]) cube([5,hammer_len,height], center=true);
			}
			//buckle holes
			for(i= [1,2,3])
			translate([-width/2+buckle_hole_width*(0.5+i-1)+buckle_hole_dist*i,0,0]) cube([buckle_hole_width,length+xtra,belt_hole_length], center=true);
			for(i= [1,2,3])
			translate([width/2-buckle_hole_width*(0.5+i-1)-buckle_hole_dist*i,0,0]) cube([buckle_hole_width,length+xtra,belt_hole_length], center=true);
			//hammer hole
			rotate([-90,0,0]) translate([0,0,-length/2-xtra])cylinder(r=2.1, h =hammer_hole_len+xtra);
		}
	}


	module belt_tightener2(pos=[0,0,0],  width=block_width-2*belt_guides_width ,thickness=3, length=belt_width+3*2, belt_hole_width=2, belt_hole_dist=2, bolt_dia=4)
	{
		belt_width_extra=0.5;
		belt_hole_length = belt_width + belt_width_extra;
		length_off = (length - belt_hole_length)/2;
		top_offset=belt_hole_dist/2+belt_hole_width;

		nut_height= METRIC_NUT_THICKNESS[bolt_dia]+tolerance;
		nut_width= METRIC_NUT_AC_WIDTHS[bolt_dia]/2+tolerance;
		top_bottom_thickness=2;
		
		total_thickness=top_bottom_thickness*2+nut_height+3;

		top_layer_offset=top_bottom_thickness+nut_height+1;
		module _half()
		{
		difference()
		{
			union()
			{
				cube([width/2,thickness,length]);
				//buckle holes top blocks
			
				translate([0,0,0])cube([width/2-3.3,total_thickness,length]);
				translate([0,top_layer_offset,0])cube([width/2+5,thickness,length]);
				
			}//buckle holes lower
			for(i= [1])
			translate([belt_hole_dist/2+belt_hole_dist*i+belt_hole_width*i,-xtra/2,length_off]) cube([belt_hole_width,thickness+xtra,belt_hole_length]);

			for(i= [1,2])
			translate([belt_hole_dist/2+belt_hole_dist*i+belt_hole_width*i,top_layer_offset-xtra/2,length_off]) cube([belt_hole_width,thickness+xtra,belt_hole_length]);

			//center hole
			translate([0,-xtra/2,length/2]) rotate([-90,0,0]) cylinder(r=bolt_dia/2,  h=20);
			//nut hole
			translate([0,top_bottom_thickness,length/2]) rotate([0,90,90])nutHole(size=bolt_dia);
			//nut side hole
			translate([-xtra-0.43,top_bottom_thickness,-xtra/2]) cube([nut_width,nut_height,length/2]);

		}	
		}
		translate(pos) {_half();mirror([1,0,0]) _half();}	
	}

	module belt_extender(pos=[0,0,0],  width=bearing_length ,thickness=3, length=belt_width+3*2, belt_hole_width=2, belt_hole_dist=3)
	{
		belt_width_extra=0.5;
		belt_hole_length = belt_width + belt_width_extra;
		length_off = (length - belt_hole_length)/2;
		top_offset=belt_hole_dist/2+belt_hole_width;

		module _half()
		{
		difference()
		{
			union()
			{
				cube([width/2,thickness,length]);
				//buckle holes top blocks
				for(i= [0])
				translate([top_offset+belt_hole_dist*i+belt_hole_width*i,thickness,0]) cube([belt_hole_dist,thickness+1,length]);
		
				
			}//buckle holes lower
			for(i= [0,1])
			translate([belt_hole_dist/2+belt_hole_dist*i+belt_hole_width*i,-xtra/2,length_off]) cube([belt_hole_width,thickness+xtra,belt_hole_length]);
			
			//top hole
			translate([0,thickness,length_off])  cube([width,belt_hole_width,belt_hole_length]);
		}	
		}
		translate(pos) {_half();mirror([1,0,0]) _half();}	
	}

	module tightener_knob(pos=[0,0,0], dia=18, height=10, bolt_dia=4)
	{
		capHeight = METRIC_NUT_THICKNESS[bolt_dia]+tolerance; 
		nutHeight = METRIC_NUT_AC_WIDTHS[bolt_dia];

		translate(pos)
		difference()
		{
			cylinder(r= dia/2, h=height);
			cylinder(r=bolt_dia/2, h=height+xtra);
			 rotate([180,0,0]) translate([0,0,capHeight-xtra/2-height]) boltHole(size=bolt_dia, length =height+xtra);
			translate([0,0,-xtra/2])nutHole(bolt_dia);
		}
	}

	module bearing_holder(pos=[0,0,0])
	{
		bearing_r=bearing_dia/2+bearings_hole_extra;

		belt_block_length = belt_thickness + 4;
		belt_block_height= belt_width+3*2;

		front_extra=10; ///needed to allow passage for belt
		front_trench_dia=17;
		front_trench_length=front_trench_dia;
		back_trench_length=7;//for belt attachment inset

		front_thickness=2;
		block_length=length+front_extra;
		
		roundings_r= length/2;

		front_mount_holes_dist= (block_length/2+front_extra)/2;


		translate(pos)
		{
			difference()
			{
				union()
				{
					//main block 
					translate([-block_width/2,0,0]) rotate([0,90,0])
					linear_extrude(height =block_width)
					{
						hull()
						{
							translate([0,length/2+front_extra])square([block_height+length,0.01],center=true);
							translate([-block_height/2,0]) circle(r=roundings_r); translate([block_height/2,0]) circle(r=roundings_r);
						}
					}
				
					//belt tensionner helper
					translate([-block_width/2,-length/2,0]) 
					rotate( [0,90,0])
					linear_extrude(height =belt_guides_width)
					{
						hull()
						{
							translate([block_height/2,0,0]) square([0.01,0.01],center=true);
							translate([0,-belt_block_length/2,0]) square([belt_block_height,belt_block_length],center=true);
						}
					}		
					translate([block_width/2-belt_guides_width,-length/2,0]) 
					rotate( [0,90,0])
					linear_extrude(height =belt_guides_width)
					{
						hull()
						{
							translate([block_height/2,0,0]) square([0.01,0.01],center=true);
							translate([0,-belt_block_length/2,0]) square([belt_block_height,belt_block_length],center=true);
						}
					}				
				}

				//front belt hole
				translate([-(block_width+xtra)/2,block_length/2+front_extra/2-front_thickness,0])
				rotate( [0,90,0])
					linear_extrude(height =block_width+xtra)
					{
						hull()
						{
							square([front_trench_dia,0.01],center=true);
							translate([0,-front_trench_dia/2]) scale (v=[1,0.5,1]) circle(r = front_trench_dia/2);
						}
					}	

				//lateral belt holes
				translate([0,belt_y_pos,0]) cube([block_width+xtra+10,belt_thickness,belt_hole_width], center=true);
				//belt tensionner bolt hole
				translate([0,-6,0]) rotate([90,0,0]) cylinder(r1=2.5 , r2=3, h=10);
				//translate([0,-length/2+back_trench_length/2-xtra/2-2.2,0])cube([block_width-2*belt_guides_width,back_trench_length+xtra,belt_block_height+0.5], center=true);

		

				//mount holes
				rotate([0,-90,0])mount_hole(length=block_width+xtra,cap_len=5,nut_len=5);
				translate([0,front_mount_holes_dist,rod_dist/2+bearing_dia/3]) rotate([0,-90,0])mount_hole(length=block_width+xtra,cap_len=5,nut_len=5);
				translate([0,front_mount_holes_dist,-rod_dist/2-bearing_dia/3]) rotate([0,-90,0])mount_hole(length=block_width+xtra,cap_len=5,nut_len=5);

				//tightener knob hole
				translate([0, -length/2,0]) rotate([90,0,0]) cylinder(r=2,h=10);

				//bearing holes
				//for(i= [-1,1]) bearing_retainer_hole([0,0,rod_dist/2*i], block_width,bearing_dia,bearings_hole_extra,bearing_length,bearing_cap_id,end_caps_length);
				for(i= [-1,1]) bearing_retainer_hole([0,0,rod_dist/2*i], block_width);

				//extra, for mounting
				for(j= [-1,1])
				translate([0,(block_length+xtra)/2-bearing_dia/2-walls_thickness,j*payload_holes_dist]) rotate([-90,0,0]) mount_hole(length=block_length+xtra, variant=NUT,nut_len=10);
			}
		}

	}



	color(MECHA_COLOR)
	{
		//translate(pos)
		%rotate([90,0,0])tightener_knob([0,0,-30]);
			%belt_extender([0,-18,-6]);
			%belt_tightener2([0,11,-5]);
			
			//some helpers to visualize belts and bearings
			//for(i= [-1,1])for(j= [0,1]) 
			//%bearing(pos=[80*j-40,belt_bearings_y_dist/2*i,-belt_bearing_dims[2] /2], model=624, outline=false);
			translate([0,-belt_bearings_y_dist/2+belt_bearing_dims[2]+belt_thickness*1.5,0]) %cube([200,belt_thickness,belt_width], center=true);
			translate([0,belt_bearings_y_dist/2-belt_bearing_dims[2]-belt_thickness*1.5,0]) %cube([200,belt_thickness,belt_width], center=true);
		if (side == LEFT)
		{
			rotate([0,90,0]) translate([-block_width/2,0,0])
			difference()
			{bearing_holder(); translate([-cutoff_dims[0]/2,0,0]) cube(cutoff_dims,center=true);}
		}
		else if (side == RIGHT)
		{
			rotate([0,-90,0]) translate([block_width/2,0,0]) rotate([180,0,0]) 
			difference()
			{bearing_holder(); translate([cutoff_dims[0]/2,0,0]) cube(cutoff_dims,center=true);}
		}
		else if(side==TIGHTENER)
		{
			//rotate([0,0,0])  belt_extender();
			rotate([180,0,0])  belt_tightener2();
		}
		else
		{
			 mirror([0,1,0]) bearing_holder();
		}
	
	}

	
}


module tool_head(pos=[0,0,0], carriage_width=24.7, carriage_height=64, carriage_border_extra=4,carriage_front=2, payload_holes_dist=28)
{
	length=8;
	translate(pos)
	difference()
	{
		union()
		{
			cube([carriage_width+carriage_border_extra*2,length,carriage_height],center=true);
			difference()
			{
				cylinder(r=carriage_width/2+carriage_border_extra, h =30);
				cube([15,15,30]);
			}
		}

		translate([0,4.1,0]) cube([carriage_width,carriage_front,carriage_height+xtra],center=true);
		for(j= [-1,1])
		translate([0,0,j*payload_holes_dist]) rotate([90,0,0]) mount_hole(length=length+xtra, variant=CAP,cap_len=3);

	}
}

module x_end(pos=[0,0,0], rod_dia=8, rod_dist=30, width=16, length=26, walls_thickness=4, y_bearing_dia=15, y_bearing_length=24, y_bearing_cap_id=14.5,y_arm_safe_dist= 4, x_arm_extra_distance=8,bearing_holder_thickness=5, belt_thickness=1.5, belt_width=6,x_axis_top_offset= 0,half=BOTH)
{
	//all components based on offset between pulley+ belts
	belt_pulley_od =24;
	belt_pulley_height=11.5;
	x_rod_holes_undersize=0.0;
	y_bearings_hole_extra= 0.2;
	bearing_end_blocker_thickness=0.7;
	x_cap_len=1;//cap at end of rods

	y_arm_height= y_bearing_dia + 2*walls_thickness;
	

	belt_bearing_washer_height=1;
	belt_bearing_dims=bearingDimensions(624);//inner, outer, width
	belt_bearings_holder_width=belt_bearing_dims[1]+bearing_holder_thickness*2;
	belt_bearings_y_dist=belt_bearing_dims[1]+length+belt_thickness*2;
	belt_bearings_z_dist= y_arm_safe_dist + y_arm_height;
	belt_bearings_x_dist= belt_pulley_od/2+belt_bearing_dims[1]/2;

	belt_guide_height= 2*belt_bearing_dims[2] + 2* belt_bearing_washer_height;
	belt_guide_z_offset=  y_arm_height+ y_arm_safe_dist +belt_pulley_height/2;//+belt_guide_height/2;// distance from top to middle of belt position

	belt_guide_notch_depth=3;

	x_rods_z_offset= belt_guide_z_offset+x_axis_top_offset; //how high up to put holes for x axis rods
	x_arm_height = x_rods_z_offset+rod_dist/2+length/2; //x_axis_top_offset + rod_dist + rod_dia + length;
	x_arm_x_offset= belt_bearings_x_dist+x_arm_extra_distance;

	
	assembly_bolt_dia=4;
	assembly_bolt_inset_dia=METRIC_NUT_AC_WIDTHS[assembly_bolt_dia]+tolerance;;//7;
	assembly_bolt_inset_depth=8;


	lower_assembly_hole_pos = belt_guide_z_offset+rod_dist/2+rod_dia/2 + 0.5*(x_arm_height-(belt_guide_z_offset+rod_dist/2+rod_dia/2)) ;
	upper_assembly_hole_pos = (belt_guide_z_offset-rod_dist/2 -rod_dia/2)/2;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	module belt_notch(pos=[0,0,0], depth=belt_guide_notch_depth,  height=belt_guide_height, flat_height=belt_width+1)
	{
		slope_width= (height-flat_height)/2;
		translate(pos)
		{
		translate([0,depth/2,height/2])rotate([0,90,0])
		linear_extrude(height = width+xtra, center = true)
		{
			polygon(points = 
			[[0,0],[slope_width,-depth],[slope_width+flat_height,-depth],[height,0]]
			,paths = [[0,1,2,3]]);
		}
		}
	}

	module bearing_holder(pos=[0,0,0], top=0)
	{
		capHeight = METRIC_NUT_THICKNESS[belt_bearing_dims[0]]+tolerance; 
		thick_offset = bearing_holder_thickness-capHeight;

		translate(pos)
		{
		difference()
		{
			linear_extrude(height =bearing_holder_thickness)
			{
				hull()
				{
					translate([0,-belt_bearings_y_dist/2,0])circle(r=belt_bearing_dims[1]/2+belt_thickness);	
					translate([0,belt_bearings_y_dist/2,0])circle(r=belt_bearing_dims[1]/2+belt_thickness);
					translate([width/2,0,0]) square([width,length],center=true);//circle(r=min(width,length)-1);//
				}
			}
			for(i= [-1,1])
			{
			translate([0,-belt_bearings_y_dist/2*i,-xtra/2]) cylinder(r=belt_bearing_dims[0]/2 ,h= bearing_holder_thickness+xtra);
			if(top==1)
			{
				translate([0,-belt_bearings_y_dist/2*i,xtra/2+bearing_holder_thickness/2]) linear_extrude(height=bearing_holder_thickness/2) nutHole(belt_bearing_dims[0],proj=1);
			}
			else
			{
				translate([0,-belt_bearings_y_dist/2*i,xtra/2+thick_offset]) mirror([0,0,1]) boltHole(belt_bearing_dims[0],length= bearing_holder_thickness+xtra);}
			}
		}
		}
	}

	module bearing_holder_block(pos=[0,0,0])
	{
		translate(pos)
		{
			for(i= [0,1]) mirror([0,0,i]) bearing_holder([0,0,belt_guide_height/2],i);
			for(i= [-1,1])for(j= [0,1]) 
			%mirror([0,0,j])bearing(pos=[0,belt_bearings_y_dist/2*i,-belt_bearing_dims[2] ], model=624, outline=false);
		}
	}

	module x_arm(pos=[0,0,0])
	{
		translate(pos)
		{
			translate([width,0,0])
			rotate([-90,0,90])
			linear_extrude(height =width)
			{
				hull()
				{
					square([length,0.01],center=true);
					translate([0,-x_arm_height+length/2,0])circle(r=length/2);
				}
			}
		}
	}

	module y_arm(pos=[0,0,0])
	{


		end_caps_length= 0.7;
		arm_length =( y_bearing_length+end_caps_length)*2;
		bearing_r=y_bearing_dia/2+y_bearings_hole_extra;

		translate(pos)
		{
			rotate([90,90,0]) translate([-y_arm_height/2,0,-length/2])
			difference()
			{
				union()
				{
				linear_extrude(height =length)
				{
					hull()
					{
						circle(r=y_arm_height/2);
						translate([0,x_arm_x_offset,0]) square([y_arm_height,0.01],center=true);
					}
				}
				translate([0,0,length/2])cylinder(r=y_arm_height/2, h=arm_length-10, center=true);
				translate([0,0,length/2-arm_length/2+2.5])cylinder(r2=y_arm_height/2, r1=y_arm_height/2-2, h=5, center=true);
				translate([0,0,length/2+arm_length/2-2.5])cylinder(r1=y_arm_height/2, r2=y_arm_height/2-2, h=5, center=true);

				}

				translate([0,0,length/2])
				{
				//bearing hole
				translate([0,0,0]) cylinder(r=bearing_r, h=y_bearing_length*2, center=true);

				translate([0,0,arm_length/2-end_caps_length-xtra/2])cylinder(r2=y_bearing_cap_id/2, r1 =bearing_r , h=end_caps_length+xtra);
				translate([0,0,-arm_length/2+end_caps_length+xtra/2]) mirror([0,0,1])cylinder(r2=y_bearing_cap_id/2, r1 =bearing_r , h=end_caps_length+xtra);
				}
			}
		}
	}

	module attach_holes(pos=[0,0,0])
	{
		translate(pos)
		{
			rotate([90,0,0])
			{
				translate([0,0,length/2-assembly_bolt_inset_depth/2+xtra/2])
				cylinder(r=assembly_bolt_inset_dia/2, h=assembly_bolt_inset_depth,center=true);
				cylinder(r=assembly_bolt_dia/2,h=length+xtra, center=true);				
				translate([0,0,-length/2-xtra/2]) 
				linear_extrude(height=assembly_bolt_inset_depth) nutHole(assembly_bolt_dia,proj=1);
			}
		}

	}

	module _x_end()
	{
		
		mirror([0,0,1])
		translate([0,0,-(y_bearing_dia/2+walls_thickness)])
		difference()
		{
			union()
			{
				x_arm([x_arm_x_offset,0,0]);
				y_arm([0,0,0]);
				bearing_holder_block([belt_bearings_x_dist,0,belt_guide_z_offset]);
			}
			
			//xrod holes
			for(i= [-1,1]) translate([-xtra/2+x_arm_x_offset+x_cap_len,0,rod_dist/2*i+x_rods_z_offset]) rotate([0,90,0])  cylinder(r=rod_dia/2-x_rod_holes_undersize/2, h=width+xtra);	
			for(i= [-1,1]) mirror([0,(i-1),0]) belt_notch([x_arm_x_offset+width/2,length/2-belt_guide_notch_depth/2+xtra/2,belt_guide_z_offset]);

			//2 halves attachments
			attach_holes([x_arm_x_offset+width/2,0,lower_assembly_hole_pos]);
			attach_holes([x_arm_x_offset+width/2,0,upper_assembly_hole_pos]);

			if (x_arm_x_offset>23)
			{
				attach_holes([x_arm_x_offset/2+ walls_thickness,0,y_arm_height/2]);
			}
		}
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	color(MECHA_COLOR)
	{
		translate(pos)
		if (half==FRONT)
		{
			rotate([-90,0,0]) difference(){_x_end();translate([-20,0,-x_arm_height+5])cube([150,50,x_arm_height+10]);}
		}
		else if (half ==BACK)
		{	
			rotate([90,0,0]) difference(){_x_end();translate([-25,-50,-75])cube([100,50,100]);}
		}
		else
		{_x_end();}
	}
}



module pulley(pos=[0,0,0])
{
	translate([pos[0], pos[1], pos[2]])
	color([ 0.2, 0.2, 0.2 ])
	{
	translate([0,0,pulley_feet_height]) cylinder(r=pulley_od/2,h=pulley_height);
	cylinder(r=pulley_feet_od/2, h =pulley_feet_height);
	}
}

module belt(pos=[0,0,0], height=6, length=405, pulley_dia=20, thickness=1.5)
{
	translate([pos[0], pos[1], pos[2]])
	color([ 0.3, 0.3, 0.3 ])
	difference()
	{
		union()
		{
			cube([pulley_dia,length,height],center=true);
			translate([0,-length/2,0])cylinder(r=pulley_dia/2,h=height,center=true);
			translate([0,length/2,0])cylinder(r=pulley_dia/2,h=height,center=true);

		}
		translate([xtra/2,0,-xtra/2]) cube([pulley_dia-thickness,length+xtra,height+xtra+10],center=true);

		translate([0,-length/2+thickness,xtra/2])cylinder(r=pulley_dia/2-thickness/2,h=height+xtra+10,center=true);
		translate([0,length/2-thickness,xtra/2])cylinder(r=pulley_dia/2-thickness/2,h=height+xtra+10,center=true);
	}
	
	/*difference()
	{
		linear_extrude(height =height)
		{
		hull()
		{
			translate([0,-length/2,0])circle(r=pulley_dia/2);
			translate([0,length/2,0])circle(r=pulley_dia/2);
		}
		}
		translate([0,0,-xtra])
		linear_extrude(height =height+xtra*2)
		{
		hull()
		{
			translate([0,-length/2+thickness,0])circle(r=pulley_dia/2-thickness);
			translate([0,length/2-thickness,0])circle(r=pulley_dia/2-thickness);
		}
		}
	}*/
}


///////////////////UTILITIES
module mount_hole(pos=[0,0,0], dia=4, length=30, cap_len=NAN, nut_len=NAN,variant=BOTH)//pos it that of center
{
		capRad = METRIC_NUT_AC_WIDTHS[dia]/2 + tolerance; 
		nutRad=METRIC_NUT_AC_WIDTHS[dia]/2+tolerance; 

		cap_len_default = METRIC_NUT_THICKNESS[dia]+tolerance; 
		nut_len_default =METRIC_NUT_AC_WIDTHS[dia];


		cap_pos = length/2-cap_len;
		cap_pos_default=  length/2-cap_len_default;

		nut_pos = -length/2;

		translate(pos)
		{
			cylinder(r=dia/2, h =length,center=true);

			if (variant == CAP) 
			{
				//hack, because openscad has no variables
				if (cap_len == NAN)
				{
					translate([0,0,cap_pos_default])cylinder(r=capRad,h=cap_len_default);
				}
				else
				{
					translate([0,0,cap_pos])cylinder(r=capRad,h=cap_len);
				}
			}
			else if(variant == NUT) 
			{
				if(nut_len==NAN)
				{
					translate([0,0,nut_pos]) cylinder(r=capRad,h=nut_len_default, $fn=6);
				}
				else
				{
					translate([0,0,nut_pos]) cylinder(r=capRad,h=nut_len, $fn=6);
				}
			}
			else
			{
				if (cap_len == NAN)
				{
					translate([0,0,cap_pos_default])cylinder(r=capRad,h=cap_len_default);
				}
				else
				{
					translate([0,0,cap_pos])cylinder(r=capRad,h=cap_len);
				}
				if(nut_len==NAN)
				{
					translate([0,0,nut_pos]) cylinder(r=capRad,h=nut_len_default, $fn=6);
				}
				else
				{
					translate([0,0,nut_pos]) cylinder(r=capRad,h=nut_len, $fn=6);
				}
			}	
		}
}

module bearing_retainer_hole(pos=[0,0,0], length=10, bearing_dia=15, bearing_r_extra=0.15, cap_dia=14.5, cap_lng=0.7)
	{
		bearing_r=bearing_dia/2+bearing_r_extra;
		lng_diff = length -(cap_lng*2);
		translate(pos)
		rotate([0,90,0])
		{
			//bearing hole
			translate([0,0,0]) cylinder(r=bearing_r, h=lng_diff, center=true);
			translate([0,0, length/2-cap_lng-xtra/2])cylinder(r2=cap_dia/2, r1 =bearing_r , h=cap_lng+xtra);
			translate([0,0,-length/2+cap_lng+xtra/2]) mirror([0,0,1])cylinder(r2=cap_dia/2, r1 =bearing_r , h=cap_lng+xtra);
		}
	}
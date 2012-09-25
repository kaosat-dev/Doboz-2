

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
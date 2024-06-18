
//
// blockbox.scad

// 12 blocks by 3
//
// block height  33mm
//       side    15mm

// unit is mm

$fn=12;


block_height = 33;
block_side = 15;

wall_thickness = 2.6;
wall_height = block_height * 0.28;

gap = 0.70;
box_in_length = 12 * (block_side + gap);
box_ex_length = box_in_length + 2 * wall_thickness;

box_in_width = 3 * (block_side + gap) + gap;
box_ex_width = box_in_width + 2 * wall_thickness;

echo("box_in_width", box_in_width);
echo("box_in_length", box_in_length);

border_radius = wall_thickness / 2 * 1.1;

wt2 = wall_thickness / 2;
el2 = box_ex_length * 0.5 - wt2;
ew2 = box_ex_width * 0.5 - wt2;


hull() { // bottom
  translate([  el2,  ew2, 0 ]) sphere(r=border_radius);
  translate([  el2, -ew2, 0 ]) sphere(r=border_radius);
  translate([ -el2,  ew2, 0 ]) sphere(r=border_radius);
  translate([ -el2, -ew2, 0 ]) sphere(r=border_radius);
};

rad = wall_height * 0.63 / 2;

module remo0() {
  dh = border_radius / 2.8 + wall_height / 2;
  l = box_ex_length * 1.1;
  translate([ 0, l / 2, dh ]) rotate([ 90, 30, 0 ]) cylinder(r=rad, h=l, $fn=3);
  //translate([ 0, l / 2, dh ]) rotate([ 90, 0, 0 ]) cylinder(r=rad, h=l, $fn=12);
  //translate([ 0, l / 2, dh * 0.8 ]) rotate([ 90, 45, 0 ]) cylinder(r=rad, h=l, $fn=4);
};
module remo1() {
  rotate([ 0, 0, 90 ]) remo0();
}

handle_radius = 11;

module handle() {

  wh = wall_height + 3;
  hh = block_height * 0.91 - handle_radius * 2;

  hull() {
    translate([ 0, 0, wh ]) rotate([ 90, 0, 0 ])
      cylinder(r=handle_radius, h=wall_thickness * 0.97, $fn=32, center=true);
    translate([ 0, 0, wh + hh ]) rotate([ 90, 0, 0 ])
      cylinder(r=handle_radius, h=wall_thickness * 0.97, $fn=32, center=true);
  }
};

difference() {
  union() {
    hull() {
      translate([ el2,  ew2, 0 ]) sphere(r=wt2);
      translate([ el2, -ew2, 0 ]) sphere(r=wt2);
      translate([ el2,  ew2, wall_height ]) sphere(r=wt2);
      translate([ el2, -ew2, wall_height ]) sphere(r=wt2);
    };
    hull() {
      translate([ -el2,  ew2, 0 ]) sphere(r=wt2);
      translate([ -el2, -ew2, 0 ]) sphere(r=wt2);
      translate([ -el2,  ew2, wall_height ]) sphere(r=wt2);
      translate([ -el2, -ew2, wall_height ]) sphere(r=wt2);
    };
    hull() {
      translate([  el2,  ew2, 0 ]) sphere(r=wt2);
      translate([ -el2,  ew2, 0 ]) sphere(r=wt2);
      translate([  el2,  ew2, wall_height ]) sphere(r=wt2);
      translate([ -el2,  ew2, wall_height ]) sphere(r=wt2);
    };
    hull() {
      translate([  el2,  -ew2, 0 ]) sphere(r=wt2);
      translate([ -el2,  -ew2, 0 ]) sphere(r=wt2);
      translate([  el2,  -ew2, wall_height ]) sphere(r=wt2);
      translate([ -el2,  -ew2, wall_height ]) sphere(r=wt2);
    };
    translate([ 0,  ew2, 0 ]) handle();
    translate([ 0, -ew2, 0 ]) handle();
  };

  bside = block_side + gap;
  bside2 = bside / 2;
    //
  for (x = [ -1 : -1 : -6 ]) {
    translate([ bside2 + x * bside, 0, 0 ]) remo0();
  }
  for (x = [ 1 : 6 ]) {
    translate([ -bside2 + x * bside, 0, 0 ]) remo0();
  }

  y = box_in_width / 3;
  remo1();
  translate([ 0,  y, 0 ]) remo1();
  translate([ 0, -y, 0 ]) remo1();

  hr2 = handle_radius / 2;
  //translate([  0, 0, block_height * 0.19 ]) remo0();
  //translate([ -hr2, 0, block_height * 0.30 ]) remo0();
  //translate([  hr2, 0, block_height * 0.30 ]) remo0();
  translate([  0, 0, block_height * 0.30 ]) remo0();
  translate([  0, 0, block_height * 0.59 ]) remo0();
};



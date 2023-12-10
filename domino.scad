$fn = 24;

size = [20, 42, 4.2];
cr = 1.2;

function in(x) = x * 25.4;
module hol() { sphere(d=3.4); }

bx = in(1);
by = in(1);

function gx(x) = bx * x + dx;
function gy(y) = by * y + dy;
function grid(x, y) = [gx(x), gy(y)];

module do(cx, cy, sx = 1, sy = 1) {
	for (x = [0 : cx - 1]) {
		for (y = [0 : cy - 1]) {
			translate([bx * x * sx, by * y * sy]) children();
		}
	}
}

module hul(offset) {
	hull() {
		children();
		translate(offset) children();
	}
}
	
module border(delta) {
	difference() {
		children();
		offset(delta = -delta) children();
	}
}

module line(start, end, thickness = 1) {
	translate(start) hul([end.x - start.x, end.y - start.y]) circle(thickness);
}

module round_rect(w, h, r) {
	hull() {
		translate([r, r]) circle(d = r * 2);
		translate([r, h - r]) circle(d = r * 2);
		translate([w - r, r]) circle(d = r * 2);
		translate([w - r, h - r]) circle(d = r * 2);
	}
}

module holes(cnt) {

	if(cnt == 1) {
		translate([size.x / 2, size.y * 2 / 8, size.z]) 
		hol();
	}

	if(cnt == 2) {
		translate([size.x / 4, size.y * 3 / 8, size.z])
		hol();
		translate([size.x * 3 / 4, size.y * 1 / 8, size.z])
		hol();
	}
	
	if(cnt == 3) {
		translate([size.x * 1 / 4, size.y * 3 / 8, size.z])
		hol();
		translate([size.x * 2 / 4, size.y * 2 / 8, size.z]) 
		hol();
		translate([size.x * 3 / 4, size.y * 1 / 8, size.z])
		hol();
	}
	
	if(cnt == 4) {
		translate([size.x * 1 / 4, size.y * 3 / 8, size.z])
		hol();
		translate([size.x * 1 / 4, size.y * 1 / 8, size.z]) 
		hol();
		translate([size.x * 3 / 4, size.y * 3 / 8, size.z])
		hol();
		translate([size.x * 3 / 4, size.y * 1 / 8, size.z])
		hol();
	}
	
	if(cnt == 5) {
		translate([size.x * 1 / 4, size.y * 3 / 8, size.z])
		hol();
		translate([size.x * 1 / 4, size.y * 1 / 8, size.z]) 
		hol();
		translate([size.x * 3 / 4, size.y * 3 / 8, size.z])
		hol();
		translate([size.x * 3 / 4, size.y * 1 / 8, size.z])
		hol();
		translate([size.x / 2, size.y * 2 / 8, size.z]) 
		hol();
	}
	
	if(cnt == 6) {
		translate([size.x * 1 / 4, size.y * 3 / 8, size.z])
		hol();
		translate([size.x * 1 / 4, size.y * 2 / 8, size.z]) 
		hol();
		translate([size.x * 1 / 4, size.y * 1 / 8, size.z])
		hol();
		translate([size.x * 3 / 4, size.y * 3 / 8, size.z])
		hol();
		translate([size.x * 3 / 4, size.y * 2 / 8, size.z])
		hol();
		translate([size.x * 3 / 4, size.y * 1 / 8, size.z])
		hol();
	}
}

module piece(top, bot) {
	
	color("gray")
	difference() {
		linear_extrude(size.z)
		round_rect(size.x, size.y, cr);

		dx = 1.8;
		sd = 1.2;
		translate([dx, size.y / 2, size.z])
		hul([size.x - 2 * dx, 0])
		sphere(d = sd);

		holes(bot);
		translate([0, size.y / 2]) holes(top);
	}
}

for (x = [0 : 7 - 1]) {
	for (y = [x : 7 - 1]) {
		translate([x * (size.x + 8), y * (size.y + 8)]) piece(x, y);
	}
}

window_class window = new window_class(1200, 700);
double x = 0;
double y = 0;
double d_x = 0;
double d_y = 0;
double thrust_x = 0;
double thrust_y = 0;
double drag = 1;
int objects = 80;
int move_flag = 0;
double mass_ratio = .5;
boolean locked = false;
boolean full_stop = true;
int stage = -1;
int fire = 0;
int fade_rate = 100;
int user_thrust = 0;
int brake_thrust = 0;
int user_thrust_fire = 0;
int user_thrust_x = 0;
int user_thrust_fire_x = 0;
int user_thrust_y = 0;
int user_thrust_fire_y = 0;
int start_orbit = 0;
double blast = 0;
double my_mass = 1;
int range = 10000;
double init_speed = 1000;
double c1 = 100;
double c2 = 100;
int close_point;
int real_close_point;
double close_dis;
boolean heads_up = false;
int rate = 0;
double g = 6.673 * pow(10,1);
double o_d_x, o_d_y;
double o_t_p_x, o_t_p_y;
int drawCircle = 0;
double circle_dis = 0;
int lunar_flag, lunar_cycle;
int earth_flag, earth_cycle;
int max_big = 28;
double earth_speed;
boolean guidance = false;
boolean normal_thrust = false;
boolean orbit_thrust = false;
boolean thrust_guidance = false;
int planet_set = 3;
double spc_close;
double dis_x = 0;
double dis_y = 0;
// double init_fuel = 1000000000000000000D;
double init_fuel = 1000000;
double fuel = init_fuel;
//double G = 6.67300 * pow(10,-11);
double G = 1;
int frame_rate = 300;
boolean surface = false;
int time_scale = 0;
int last_key = 0;
double detonate_power = 100;

double[] t_points_x = new double[objects];
double[] t_points_y = new double[objects];
double[] t_change_x = new double[objects];
double[] t_change_y = new double[objects];

double[] points_x = new double[objects];
double[] points_y = new double[objects];
double[] mass = new double[objects];
double[] change_x = new double[objects];
double[] change_y = new double[objects];
double[] atm = new double[objects];
double[] radius = new double[objects];
int[] moon = new int[objects];
int[] asteroid = new int[objects];
int[] stages = new int[100];

PFont font;

void setup() {
  
    if (max_big > objects) max_big = objects;
/*  
//  Setup:
    for(int i=2;i<10;i++) {
    println("points_x[" + i + "] = " + random(-10000,10000) + ";");
    println("points_y[" + i + "] = " + random(-10000,10000) + ";");
    println("mass[" + i + "] = " + random(1, 15) + ";");
  }
  exit();*/
  frameRate(frame_rate);
  font = loadFont("Serif-12.vlw");
  textFont(font, 12);
  window.rescale(.001);
  size(1200, 700);
  background(0);

  points_x[3] = 149598261;
  points_y[3] = 0;
  mass[3] = 5.9742 * pow(10, 5);
//  mass[3] = 5.9742 * pow(10, 24);
  atm[3] = .5;
  radius[3] = 6378.1;
  
  points_x[0] = 0;
  points_y[0] = 0;
  mass[0] = 332918.215 * mass[3];
  atm[0] = .1;
  radius[0] = 695500;
  
  points_x[1] = 57909100;
  points_y[1] = 0;
  mass[1] = 0.0552709986 * mass[3];
  atm[1] = .01;
  radius[1] = 2439.7;
  
  points_x[2] = 108208930;
  points_y[2] = 0;
  mass[2] = 0.815004519 * mass[3];
  atm[2] = 1;
  radius[2] = 6051.8;

  points_x[4] = 227939100;
  points_y[4] = 0;
  mass[4] = 0.107447022 * mass[3];
  atm[4] = .2;
  radius[4] = 3397;
  
  points_x[5] = 778547200;
  points_y[5] = 0;
  mass[5] = 317.816611 * mass[3];
  atm[5] = 2;
  radius[5] = 71492;
  
  points_x[6] = 1433449370;
  points_y[6] = 0;
  mass[6] = 95.1608584 * mass[3];
  atm[6] = 2;
  radius[6] = 60268;
  
  points_x[7] = 2748938461L;
  points_y[7] = 0;
  mass[7] = 14.5373439 * mass[3];
  atm[7] = 2;
  radius[7] = 25559;
  
  points_x[8] = 4503443661L;
  points_y[8] = 0;
  mass[8] = 17.1470657 * mass[3];
  atm[8] = 2;
  radius[8] = 24764;
  
  points_x[9] = 5906376272L;
  points_y[9] = 0;
  mass[9] = 0.00217602357 * mass[3];
  atm[9] = 0;
  radius[9] = 1180;
  
  int close_point = 3;
  int far_point = 5;
  for(int i=18;i<objects;i++) {
     
    //points_x[i] = (points_x[close_point] + points_x[far_point])/2 + random(-((float)points_x[close_point] + (float)points_x[far_point])/5, ((float)points_x[close_point] + (float)points_x[far_point])/5);
//    points_x[i] = random((float)points_x[close_point], (float)points_x[far_point] * 1.2);
    points_x[i] = random(0*(float)points_x[3], 5.5*(float)points_x[3]);
    points_y[i] = 0;
    mass[i] = random(0, 1) / pow(10, 4);
    atm[i] = .01;
    radius[i] = mass[i] * 5000;
  }

  for(int i=0;i<objects;i++) {
    //mass[i] = mass[i]*pow(10, 4);
  }
  for(int i=0;i<objects;i++) {
    points_x[i] = points_x[i];
    points_y[i] = points_y[i];
    radius[i] = radius[i];
  }

  

/*  for(int i=18;i<objects;i++) {
    points_x[i] = random(-10000000, 10000000);
    points_y[i] = random(-10000000, 10000000);
    mass[i] = random(0,.1);
    change_x[i] = random(-10, 10);
    change_y[i] = random(-10, 10);        
    radius[i] = mass[i] * 50;
  }*/

/*  for(int i=1;i<objects;i++) {
    double dis = points_x[i];
    double x_p = random((float)-dis, (float)dis);
    double y_p = sqroot(sqr(dis) - sqr(x_p)) * sign(x_p);
    points_x[i] = x_p;
    points_y[i] = y_p;
  }*/

  float earth_theta = 0;
  for(int i=1;i<objects;i++) {
    double total_distance = sqroot(sqr(points_x[i] - points_x[0]) + sqr(points_y[i] - points_y[0]));
    float theta = random(-2*PI, 2*PI);
    if (i == 3) earth_theta = theta;
    if (i == 4) theta = earth_theta;
    double pos = points_x[i];
    points_x[i] = pos*cos(theta);
    points_y[i] = pos*sin(theta);
    change_x[i] = sqroot(((mass[0]+mass[i])/total_distance)) * -sin(theta);
    change_y[i] = sqroot(((mass[0]+mass[i])/total_distance)) * cos(theta);
  }
  

/*  for (int i=11;i<objects;i++) {
    change_y[i] = change_y[i] * random(.8, 1.2);
  }*/

//Moon
  points_x[10] = 60.2685753 * radius[3];
  mass[10] = 0.0123196411 * mass[3];
  radius[10] = 0.272400872 * radius[3];
  moon[10] = 3;

  //Phobos
  points_x[11] = 1.4702184 * radius[3];
  mass[11] = 1.79438251 * pow(10, -9) * mass[3];
  radius[11] = 0.00174033019 * radius[3];
  moon[11] = 4;

  //Demios  
  points_x[12] = 3.67821138 * radius[3];
  mass[12] = 2.47731914 * pow(10, -10) * mass[3];
  radius[12] = 0.000972076324 * radius[3];
  moon[12] = 4;

  //Io
  points_x[13] = 66.1168687 * radius[3];
  radius[13] = 0.285586617 * radius[3];
  mass[13] = 0.0148973921 * mass[3];
  moon[13] = 5;
  
  //Europa
  points_x[14] = 105.209075 * radius[3];
  radius[14] = 0.244743732 * radius[3];
  mass[14] = 0.00803454856 * mass[3];
  moon[14] = 5;

  //Ganymede
  points_x[15] = 167.826155 * radius[3];
  radius[15] = 0.412505292 * radius[3];
  mass[15] = 0.0247731914 * mass[3];
  moon[15] = 5;
  
  //Callisto
  points_x[16] = 295.183362 * radius[3];
  radius[16] = 0.377933867 * radius[3];
  mass[16] = 0.0180777343 * mass[3];
  moon[16] = 5;

  //Titan
  points_x[17] = 191.593108 * radius[3];
  radius[17] = 0.403725247 * radius[3];
  mass[17] = 0.0225971678 * mass[3];
  moon[17] = 6;
  
  //Miranda
  points_x[18] = 20.2866057 * radius[3];
  radius[18] = 0.0369702576 * radius[3];
  mass[18] = 1.1 * pow(10, -5) * mass[3];
  moon[18] = 7;
  
  //Ariel
  points_x[19] = 29.949358 * radius[3];
  radius[19] = 0.0907637071 * radius[3];
  mass[19] = 2.26 * pow(10, -4) * mass[3];
  moon[19] = 7;
  
  //Umbriel
  points_x[20] = 41.70521 * radius[3];
  radius[20] = 0.0916730688 * radius[3];
  mass[20] = 1.96 * pow(10, -4) * mass[3];
  moon[20] = 7;
  
  //Titania
  points_x[21] = 68.3448049 * radius[3];
  radius[21] = 0.12361048 * radius[3];
  mass[21] = 5.901 * pow(10, -4) * mass[3];
  moon[21] = 7;
  
  //Oberon
  points_x[22] = 91.4880607 * radius[3];
  radius[22] = 0.119377244 * radius[3];
  mass[22] = 5.044 * pow(10, -4) * mass[3];
  moon[22] = 7;
  
  //Triton
  points_x[23] = 55.6214233 * radius[3];
  radius[23] = 0.212194854 * radius[3];
  mass[23] = 0.003581 * mass[3];
  moon[23] = 8;
  
  //Charon
  points_x[24] = 2.74940813 * radius[3];
  radius[24] = 0.0946206551 * radius[3];
  mass[24] = 2.71 * pow(10, -4) * mass[3];
  moon[24] = 9;

  
  //Alpha Centauri
  points_x[25] = 6.48194747 * pow(10, 9) * radius[3];
  points_y[25] = 0;
  radius[25] = 1.227 * radius[0];
  mass[25] = 1.100 * mass[0];
  atm[25] = .1;
    
  //Beta Centauri
  points_x[26] = 10 * radius[0]; 
  points_y[26] = 0;
  radius[26] = 0.865 * radius[0];
  mass[26] = 0.907 * mass[0];
  atm[26] = .1;
  moon[26] = 25;

  
  for(int i=28;i<45;i++) {
    //Asteroid
    points_x[i] = random(1, 39)*radius[5];
    radius[i] = random(0,200);
    mass[i] = (4/3) * PI * pow((float)radius[i],3) * (radius[3] / mass[3]);
    moon[i] = 5;
  }

  for(int i=45;i<55;i++) {
    //Asteroid
    points_x[i] = random(1, 50)*radius[6];
    radius[i] = random(0,120);
    mass[i] = (4/3) * PI * pow((float)radius[i],3) * (radius[3] / mass[3]);
    moon[i] = 6;
  }
    
  for(int i=55;i<65;i++) {
    //Asteroid
    points_x[i] = random(1, 50)*radius[7];
    radius[i] = random(0,40);
    mass[i] = (4/3) * PI * pow((float)radius[i],3) * (radius[3] / mass[3]);
    moon[i] = 7;
  }

  for(int i=65;i<75;i++) {
    //Asteroid
    points_x[i] = random(1, 50)*radius[8];
    radius[i] = random(0,30);
    mass[i] = (4/3) * PI * pow((float)radius[i],3) * (radius[3] / mass[3]);
    moon[i] = 8;
  }
  
  for(int i=75;i<objects;i++) {
    points_x[i] = random(-1000*(float)radius[0], 1000*(float)radius[0]);
    points_y[i] = random(-1000*(float)radius[0], 1000*(float)radius[0]);
    radius[i] = random(0, 1);
    mass[i] = (4/3) * PI * pow((float)radius[i],3) * (radius[3] / mass[3]);
    asteroid[i] = 0;
    change_x[i] = random(-10, 10);
    change_y[i] = random(-10, 10);
  }
  //Andromeda
  points_x[27] = 3.76753926 * pow(10, 15) * radius[3];
  points_y[27] = 0;
  radius[27] = 1.92826812 * pow(10, 6) * radius[3];
  mass[27] = 6 * pow(10, 9) * mass[0];
  atm[27] = .1;


  
  for(int i=0;i<objects;i++) {
     radius[i] = radius[i];
  }
  
  

/*  for(int i=0;i<objects;i++) {
    if (moon[i] > 0) {
      mass[i] = mass[i]*pow(10,7);
    }
  }*/
  for(int i=0;i<objects;i++) {
    if (moon[i] > 0) {
      if (asteroid[i] <= 0) {
        points_x[i] = points_x[moon[i]] + points_x[i];
        points_y[i] = points_y[moon[i]];
        atm[i] = 1;
        change_y[i] = sqroot((mass[moon[i]] + mass[i]) / (points_x[i] - points_x[moon[i]])) + change_y[moon[i]];
        change_x[i] = change_x[moon[i]];
      }
    }
  }
  
  //Shiva
  change_x[28] = change_x[3] - 2;
  change_y[28] = change_y[3];
  radius[28] = radius[3] / 100;
  mass[28] = mass[3] / 10000;
  max_big = 80;
  points_x[28] = points_x[3] - 100000D;
  points_y[28] = points_y[3];


  
  earth_speed = 66611/sqroot(sqr(change_x[3]) + sqr(change_y[3]));  //107200
//  blast = 263/earth_speed;
  //960 is at 20
  blast = 28/earth_speed;
  
  x = points_x[3];
  y = points_y[3] - radius[3];
  d_x = -change_x[3];
  d_y = -change_y[3];

//  change_y[1] = 3;
  
  //distance: 500, masses: 1000, 10, velocity: 10;
  //distance: 250, masses: 1000, 10, velocity: 10;
  
/*  double dd = 0;
  for(int i=1;i<objects-10;i++) {
//    points_x[i] = random(-1000000, 1000000);
//    points_y[i] = random(-1000000, 1000000);
    points_x[i] = random(-range, range);
    points_y[i] = random(-range, range);
    mass[i] = random(0, 50);
    atm[i] = random(0,10);
  }
  println(change_x[0] + ", " + change_y[0]);
  for(int i=objects-10;i<objects-5;i++) {
//    points_x[i] = random(-50000000, 50000000);
//    points_y[i] = random(-50000000, 50000000);
    points_x[i] = random(-range*c1, range*c1);
    points_y[i] = random(-range*c1, range*c1);
    mass[i] = random(70000, 100000);
    atm[i] = random(0,10);
  }
  
  for(int i=objects-5;i<objects;i++) {
//    points_x[i] = random(-2000000000, 2000000000);
//    points_y[i] = random(-2000000000, 2000000000);
    points_x[i] = random(-range*c2, range*c2);
    points_y[i] = random(-range*c2, range*c2);
    mass[i] = random(7000000, 10000000);
    atm[i] = random(0,10);
  }
  for(int i=0;i<objects;i++) {
    dd = sqrt(pow(points_x[i], 2) + pow(points_y[i], 2));
    if (i < objects - 10) {
      if (dd > 0) {
        change_x[i] = -init_speed * points_x[i]/dd * (dd / range);
        change_y[i] = -init_speed * points_y[i]/dd * (dd / range);    
      }    
    }
  }*/
  
/*  points_x[0] = 0;
  points_y[0] = 0;
  mass[0] = 100;
  
  points_x[1] = 100 * cos(5);
  points_y[1] = 100 * sin(5);
  mass[1] = 1;
  println(points_x[1] + " " + points_y[1]);
  
  for(int i=1;i<objects;i++) {
    double total_distance = sqroot(sqr(points_x[i] - points_x[0]) + sqr(points_y[i] - points_y[0]));
    change_x[i] = sqroot(((mass[0]+mass[i])/total_distance)) * -sin(5);
    change_y[i] = sqroot(((mass[0]+mass[i])/total_distance)) * cos(5);
   
    println(change_x[i] + " " + change_y[i]);
//    println(sqroot(sqr(change_x[i]) + sqr(change_y[i])));
  }*/
  
  
  window.realign(x,y);
}

void draw() {
  rate++;
  //change_x[28] = change_x[28] * 1.001;
  float m = millis();
  stroke(255, 255, 255, 100);
  window.fadeWindow();
  double force_x = 0;
  double force_y = 0;

  thrust_y = 0;
  thrust_x = 0;

  double velocity = sqroot(sqr(d_x+change_x[close_point]) + sqr(d_y+change_y[close_point]));
  double vel = velocity*earth_speed;
  
  close_dis = 10000000000L;
  spc_close = close_dis;
  for(int i=objects-1;i>-1;i--) {
    stroke(255, 255, 255, 100);
    fill(255, 100);
    double force_x_object = 0;
    double force_y_object = 0;
    double distance_objects = 0;
    if (mass[i] > 0) {
      if (mass[i] <= 1) {
        stroke(0, 120, 255);
        fill(0, 100, 200);
      } else {
        stroke(255, 255, 255);
        fill(150, 150, 150);
      }
//      window.renderCircle(points_x[i], points_y[i], sqroot(mass[i])*mass_ratio, i);
      window.renderObject(i);
      double distance = sqroot(sqr(x-points_x[i]) + sqr(y-points_y[i]));
      force_x += G*(x-points_x[i])/distance * mass[i] / (sqr(distance));
      force_y += G*(y-points_y[i])/distance * mass[i] / (sqr(distance));
      force_x_object = 0;
      force_y_object = 0;
      distance_objects = 0;
      for(int j=0;j<max_big;j++) {
        if (mass[j] > 0) {
          if (i != j) {
            distance_objects = sqroot(sqr(points_x[i] - points_x[j]) + sqr(points_y[i] - points_y[j]));
            force_x_object += G*(points_x[i] - points_x[j])/(distance_objects) * (mass[j]*mass[i]) / (sqr(distance_objects));
            force_y_object += G*(points_y[i] - points_y[j])/(distance_objects) * (mass[j]*mass[i]) / (sqr(distance_objects));
            if (distance_objects < radius[i]) {
              if (mass[i] > mass[j]) {
                change_x[i] = (change_x[i] * mass[i] + change_x[j] * mass[j]) / (mass[i] + mass[j]);
                change_y[i] = (change_y[i] * mass[i] + change_y[j] * mass[j]) / (mass[i] + mass[j]);
                mass[i] = mass[i] + mass[j];
                mass[j] = -1;
              } else {
                change_x[i] = (change_x[i] * mass[i] + change_x[j] * mass[j]) / (mass[i] + mass[j]);
                change_y[i] = (change_y[i] * mass[i] + change_y[j] * mass[j]) / (mass[i] + mass[j]);
                mass[j] = mass[i] + mass[j];
                mass[i] = -1;
              }
            }
          }
        }
      }
    }
    
    double point_dis = sqroot(sqr(x-points_x[i]) + sqr(y-points_y[i]));
    close_dis = spc_close;
    if (point_dis < close_dis) {
      close_point = i;
      real_close_point = close_point;
      close_dis = point_dis;
      spc_close = close_dis;
    }
    if (guidance) {
      close_point = planet_set;
      close_dis = sqroot(sqr(x-points_x[close_point]) + sqr(y-points_y[close_point]));
      dis_x = (points_x[close_point]-x) / close_dis;
      dis_y = (points_y[close_point]-y) / close_dis;
      window.renderLine(x, y, x + dis_x * 1000, y + dis_y * 1000, "yellow");
    }
    
    
    if (point_dis <= radius[i]) {
      if (i == 3) {
         if (init_fuel == 0) {
           init_fuel = 300;
         }
         fuel = init_fuel;
      }
      d_x = -change_x[i];
      d_y = -change_y[i];
      double dif_x = x - points_x[i];
      double dif_y = y - points_y[i];
      float theta = atan((float)dif_x / (float)dif_y);
      if (dif_y < 0) {
        x = points_x[i] - sin(theta) * radius[i];
        y = points_y[i] - cos(theta) * radius[i];
      } else {
        x = points_x[i] + sin(theta) * radius[i];
        y = points_y[i] + cos(theta) * radius[i];
      }
      force_x = 0;
      force_y = 0;
      surface = true;
    } else {
      surface = false;
    }
    
    if (point_dis < dragRadius(i)) {
      drag = 1;
    } else {
      drag = 1;
    }
    

    change_x[i] += force_x_object/mass[i];
    change_y[i] += force_y_object/mass[i];
    points_x[i] -= change_x[i];
    points_y[i] -= change_y[i];
  }
  thrust_x = 0;
  thrust_y = 0;
  if (brake_thrust == 1) {
    brake(d_x, d_y, 0);
  }
  if (full_stop) fstop(d_x, d_y);
  double thrust_x_comp = 0;
  double thrust_y_comp = 0;
  if (user_thrust_x + user_thrust_y > 0) {
    if (user_thrust_fire_x < 4000000) {
      user_thrust_fire_x++;
      if (user_thrust_x == 1) {        
        thrust_x_comp = blast;
      } else if (user_thrust_x == 3) {
        thrust_x_comp = -blast;
      }
    }
    if (user_thrust_fire_y < 4000000) {
      user_thrust_fire_y++;
      if (user_thrust_y == 2) {
        thrust_y_comp = -blast;
      } else if (user_thrust_y == 4) {
        thrust_y_comp = blast;
      }
    }
  }
  thrust_x = thrust_x + thrust_x_comp;
  thrust_y = thrust_y + thrust_y_comp;
  
  if (normal_thrust) {
    double point_dis = sqroot(sqr(x-points_x[real_close_point]) + sqr(y-points_y[real_close_point]));
    double dis_x = x-points_x[real_close_point];
    double dis_y = y-points_y[real_close_point];
    thrust_x = thrust_x + blast * (dis_y / point_dis);
    thrust_y = thrust_y - blast * (dis_x / point_dis);  
  }
  if (orbit_thrust) {
    double point_dis = sqroot(sqr(x-points_x[real_close_point]) + sqr(y-points_y[real_close_point]));
    double dis_x = x-points_x[real_close_point];
    double dis_y = y-points_y[real_close_point];
    thrust_x = thrust_x - blast * (dis_x / point_dis);
    thrust_y = thrust_y - blast * (dis_y / point_dis);      
  }
  
  if (guidance) {
    if (thrust_guidance) {
      double thrust_dis = sqroot(sqr(d_x + change_x[close_point]) + sqr(d_y + change_y[close_point]));
      double dis_dx = (d_x + change_x[close_point]) / thrust_dis;
      double dis_dy = (d_y + change_y[close_point]) / thrust_dis;
      thrust_x = thrust_x - blast * (dis_x) + (blast * dis_dx/2);
      thrust_y = thrust_y - blast * (dis_y) + (blast * dis_dy/2);
    }
  }
  

  double miles_sec = vel / 3600;
  double d_close_dis = (close_dis - radius[close_point])/1.609344;
  double arrival = 0;
  if (vel > 0) arrival = d_close_dis / vel;
  double fps = 1000 * ((float)rate / (float)m);
  double eta = 0;
  if (fps * velocity > 0) eta = close_dis / (fps * velocity);

  double display_eta = arrival / 24;
  String units = "d";
  if (display_eta > 365) {
    display_eta = display_eta / 365;
    units = "y";
  }
  
  double orbital_speed = earth_speed * sqroot((G * mass[close_point]) / close_dis);
  long odif = rnd(orbital_speed - vel);
  
  show("Fuel: " + rnd(fuel) + "\nETA: " + rnd(eta) + " (" + (float)rnd(eta / 360) / 10 + ")\nEarth: " + earth_cycle + "\nLunar: " + lunar_cycle + "\nThrust: " + rnd(blast*earth_speed) + "\nVel: " + rnd(vel) + " (" + rnd(miles_sec) + ")\nFrPS: " + rnd(fps) + "\nClose dis: " + rnd(d_close_dis) + "\nArrival: " + rnd(arrival) + " (" + (float)rnd(display_eta*10)/10 + units + ")\nx: " + rnd(x) + "\ny: " + rnd(y) + "\nt_x: " + rnd(thrust_x*earth_speed) + "\nt_y: " + rnd(thrust_y*earth_speed) + "\nd_x: " + rnd(d_x * earth_speed) + "\nd_y: " + rnd(d_y * earth_speed) + "\nTS: " + time_scale + "\nLK: " + last_key + "\nD: " + rnd(detonate_power/1000000) + "\nODif: " + odif);
  if (objects > 10) {
    if (points_y[10] < points_y[3]) {
      if (lunar_flag == 0) {
        lunar_flag = 1;
        lunar_cycle++;
      }
    } else {
      lunar_flag = 0;
    }
  }
  if (points_y[3] < points_y[0]) {
    if (earth_flag == 0) {
      earth_flag = 1;
      earth_cycle++;
    }
  } else {
    earth_flag = 0;
  }
  if (fuel > 0) {
    fuel = fuel - abs((float)thrust_x) - abs((float)thrust_y);
  } else {
    fuel = 0;
    thrust_x = 0;
    thrust_y = 0;
  }
  if (surface) {
    force_x = 0;
    force_y = 0;
    d_x = -change_x[close_point];
    d_y = -change_y[close_point];
  }
  d_x -= (force_x + thrust_x);
  d_y -= (force_y + thrust_y);
  d_x = d_x * drag;
  d_y = d_y * drag;  
  x += d_x;
  y += d_y;
  if (locked) {
    window.realign(x,y);
  }
  
  if (heads_up) {
    
    double t_x = x;
    double t_y = y;
    double t_d_x = d_x;
    double t_d_y = d_y;
    if (locked) {
        t_d_x = d_x + change_x[close_point];
        t_d_y = d_y + change_y[close_point];
    }
    for(int i=0;i<objects;i++) {
      t_points_x[i] = points_x[i];
      t_points_y[i] = points_y[i];
      if (!locked) {
        t_change_x[i] = change_x[i];
        t_change_y[i] = change_y[i];
      } else {
        t_change_x[i] = change_x[i] - change_x[close_point];
        t_change_y[i] = change_y[i] - change_y[close_point];
      }
    }
    double t_distance_objects;
    
    for(int j=0;j<2000;j+=1) {
      double t_force_x = 0;
      double t_force_y = 0;
      for(int i=0;i<18;i++) {
        t_change_x[i] = t_change_x[i] - t_change_x[close_point];
        t_change_y[i] = t_change_y[i] - t_change_y[close_point];
        double t_force_x_object = 0;
        double t_force_y_object = 0;
        double distance = sqroot(sqr(t_x-t_points_x[i]) + sqr(t_y-t_points_y[i]));
        if ((distance < spc_close * 5) || (i == 0) || (moon[close_point] == i)) {
          for(int k=0;k<18;k++) {
            if (mass[k] > 0) {
              if (i != k) {
                t_distance_objects = sqroot(sqr(t_points_x[i] - t_points_x[k]) + sqr(t_points_y[i] - t_points_y[k]));
                t_force_x_object += G*(t_points_x[i] - t_points_x[k])/(t_distance_objects) * (mass[k]*mass[i]) / (sqr(t_distance_objects));
                t_force_y_object += G*(t_points_y[i] - t_points_y[k])/(t_distance_objects) * (mass[k]*mass[i]) / (sqr(t_distance_objects));
              }
            }
          }
  
          t_change_x[i] += t_force_x_object/mass[i];
          t_change_y[i] += t_force_y_object/mass[i];

          t_points_x[i] -= t_change_x[i] + t_change_x[close_point];
          t_points_y[i] -= t_change_y[i] + t_change_y[close_point];

          distance = sqroot(sqr(t_x-t_points_x[i]) + sqr(t_y-t_points_y[i]));
          t_force_x += G*(t_x-t_points_x[i])/distance * mass[i] / (sqr(distance));
          t_force_y += G*(t_y-t_points_y[i])/distance * mass[i] / (sqr(distance));
        }
      }

      if (close_point >= 18) {
        int i = close_point;
        t_change_x[i] = t_change_x[i] - t_change_x[close_point];
        t_change_y[i] = t_change_y[i] - t_change_y[close_point];
        double t_force_x_object = 0;
        double t_force_y_object = 0;
        double distance = sqroot(sqr(t_x-t_points_x[i]) + sqr(t_y-t_points_y[i]));
        if ((distance < spc_close * 5) || (i == 0) || (moon[close_point] == i)) {
          for(int k=0;k<18;k++) {
            if (mass[k] > 0) {
              if (i != k) {
                t_distance_objects = sqroot(sqr(t_points_x[i] - t_points_x[k]) + sqr(t_points_y[i] - t_points_y[k]));
                t_force_x_object += (t_points_x[i] - t_points_x[k])/(t_distance_objects) * (mass[k]*mass[i]) / (sqr(t_distance_objects));
                t_force_y_object += (t_points_y[i] - t_points_y[k])/(t_distance_objects) * (mass[k]*mass[i]) / (sqr(t_distance_objects));
              }
            }
          }
  
          t_change_x[i] += t_force_x_object/mass[i];
          t_change_y[i] += t_force_y_object/mass[i];
          t_points_x[i] -= t_change_x[i] + t_change_x[close_point];
          t_points_y[i] -= t_change_y[i] + t_change_y[close_point];
  
          distance = sqroot(sqr(t_x-t_points_x[i]) + sqr(t_y-t_points_y[i]));
          t_force_x += G*(t_x-t_points_x[i])/distance * mass[i] / (sqr(distance));
          t_force_y += G*(t_y-t_points_y[i])/distance * mass[i] / (sqr(distance));
        }
      }
      if (locked) {
        t_d_x -= (t_force_x) - t_change_x[close_point];
        t_d_y -= (t_force_y) - t_change_y[close_point];
      } else {
        t_d_x -= (t_force_x);
        t_d_y -= (t_force_y);
      }
      window.renderLine(t_x, t_y, t_x + t_d_x, t_y + t_d_y, "blue");    
      t_x += t_d_x;
      t_y += t_d_y;
    }
  }
  
  double s = sqroot(sqr(thrust_x) + sqr(thrust_y));
  double dif = 30 / s;
  dif = 100;
  stroke(255, 255, 255, 100);
  fill(255, 100);
  window.renderCircle(x, y, 5, -1);
  stroke(255, 255, 0, 50);
  window.renderLine(x, y, x - thrust_x*dif, y - thrust_y*dif, "yellow");
  if (!locked) {
    window.renderLine(x, y, x + 100*d_x, y + 100*d_y, "blue");
  } else {
    window.renderLine(x, y, x + 1000 * (d_x - o_d_x), y + 1000 * (d_y - o_d_y), "blue");
  }
  o_d_x = d_x;
  o_d_y = d_y;
  if (drawCircle == 1) {
    fill(0, 0, 0, 0);    
    stroke(255, 0, 0, 100);
    circle_dis = sqroot(sqr(points_x[close_point]-x) + sqr(points_y[close_point]-y));
    window.renderCircle(points_x[close_point], points_y[close_point], circle_dis*2, 0);
  } else if (drawCircle == 2) {
    fill(0, 0, 0, 0);    
    stroke(255, 0, 0, 100);
    window.renderCircle(points_x[0], points_y[0], sqroot(sqr(points_x[3] - points_x[0]) + sqr(points_y[3] - points_y[0]))*2, 0);
  }
  
  stroke(255, 255, 0);
  fill(255, 255, 0);
  

  
}

double[] target(double target_x, double target_y, double x, double y, double d_x, double d_y, double speed) {
  double a_x = -(target_x - x)/d_x;
  double a_y = -(target_y - y)/d_y;
  double lim = sqroot(sqr(a_x)+sqr(a_y)) * 100;
  a_x = a_x / lim;
  a_y = a_y / lim;
  double[] ret = new double[2];
  ret[0] = a_x;
  ret[1] = a_y;
  return ret;
  
}

double dragRadius(int i) {
  double ret = radius[i] + atm[i]/10 * radius[i];
  return ret;
}

void detonate() {
  double power = detonate_power;
  double x_dis = (x - points_x[real_close_point]);
  double y_dis = (y - points_y[real_close_point]);
  double n = sqroot(sqr(x_dis) + sqr(y_dis));
  double x_com = x_dis / n;
  double y_com = y_dis / n;
  stroke(255, 0, 0);
  fill(255, 0, 0);
  window.renderCircle(x, y, 10000, real_close_point);
  change_x[real_close_point] += x_com * power / (n * mass[real_close_point]);
  change_y[real_close_point] += y_com * power / (n * mass[real_close_point]);
}

double[] brake(double d_x, double d_y, double speed) {
  double vel = sqroot(sqr(d_x+change_x[close_point])+sqr(d_y+change_y[close_point]));
  double dis = sqroot(sqr(x - points_x[close_point]) + sqr(y - points_y[close_point]));
  double orbital = sqroot(((1+mass[close_point])/dis));
  if (vel > 0) {
    double dir_x = (d_x+change_x[close_point]) / vel;    
    double dir_y = (d_y+change_y[close_point]) / vel;
    thrust_x = dir_x * blast;
    thrust_y = dir_y * blast;
    double mark = sqroot(sqr(thrust_x) + sqr(thrust_y));
    if (mark > blast) {
      thrust_x = thrust_x / mark * blast;
      thrust_y = thrust_y / mark * blast;
    }
  } else {
    thrust_x = 0;
    thrust_y = 0;
  }
  double[] ret = new double[2];
  ret[0] = thrust_x;
  ret[1] = thrust_y;
  return ret;
}

void fstop(double d_x, double d_y) {
  double vel = sqroot(sqr(d_x+change_x[close_point])+sqr(d_y+change_y[close_point]));
  double dis = sqroot(sqr(x - points_x[close_point]) + sqr(y - points_y[close_point]));
  if (vel > 0) {
    double dir_x = (d_x+change_x[close_point]) / vel;    
    double dir_y = (d_y+change_y[close_point]) / vel;
    double computed_blast = sqr(vel)/dis;
    thrust_x = dir_x * computed_blast;
    thrust_y = dir_y * computed_blast;
  } else {
    thrust_x = 0;
    thrust_y = 0;
  }
}

double[] new_orbit(int pt, double x, double y, double d_x, double d_y) {
  double[] thrust = new double[2];
  double max_thrust = blast;
  double distance = sqroot(sqr(x - points_x[pt]) + sqr(y - points_y[pt]));
//  change_y[i] = sqroot((mass[0]+mass[i])/(points_x[i] - points_x[0]));
  double needed_speed = sqroot((mass[pt]+1)/distance);
  double ortho_x = (x - points_x[pt]);
  double ortho_y = (y - points_y[pt]);
  
  return thrust;
  
}

double[] orbit(double center_x, double center_y, double x, double y, double d_x, double d_y, double dis) {
    double[] thrust = new double[2];
    //double max_thrust = .15;
    double max_thrust = blast;
/*double vX = pX - cX;
double vY = pY - cY;
double magV = sqrt(vX*vX + vY*vY);
double aX = cX + vX / magV * R;
double aY = cY + vY / magV * R;*/

    double n_x = x + d_x;
    double n_y = y + d_y;
    double vX = n_x - center_x;
    double vY = n_y - center_y;    
    double magV = sqroot(sqr(vX) + sqr(vY));
    double aX = center_x + vX / magV * dis;
    double aY = center_y + vY / magV * dis;
    double offset = sqroot(sqr(n_x - aX) + sqr(n_y - aY));
    thrust_x = offset * (n_x-aX);
    thrust_y = offset * (n_y-aY);
    double power = sqroot(sqr(thrust_x) + sqr(thrust_y));
    if (power > max_thrust) {
      thrust_x = max_thrust * thrust_x / power;
      thrust_y = max_thrust * thrust_y / power;
    }
    double ret[] = new double[2];
    ret[0] = thrust_x;
    ret[1] = thrust_y;
    return ret;
}

void show(String display_text) {
   stroke(255, 255, 0);
   fill(255, 255, 0);
   text(display_text, 10, 20);
}

class window_class {
  int real_height, real_width;
  double scaled_height, scaled_width, center_x, center_y, center_o_x, center_o_y;
  int fade_rate = 100;
  
  window_class(int w, int h) {
      real_height = h;
      real_width = w;
      center_x = 0;
      center_y = 0;
      scaled_width = real_width;
      scaled_height = real_height;
  }
  
  void realign(double new_center_x, double new_center_y) {
      center_o_x = center_x;
      center_o_y = center_y;
      center_x = new_center_x;
      center_y = new_center_y;
  }
  
  void rescale(double ratio) {
     scaled_width = scaled_width * ratio;
     scaled_height = scaled_height * ratio;
     window.clear();
  }
  
  void renderCircle(double x, double y, double w, int index) {
      double display_x = scaled_width / real_width * (x - center_x) + real_width/2;
      double display_y = scaled_height / real_height * (y - center_y) + real_height/2;
      ellipse((float)display_x, (float)display_y, (float)w * (float)scaled_height / (float)real_height, (float)w * (float)scaled_height / (float)real_height);
  }
  
  void renderObject(int index) {
      double x = points_x[index];
      double y = points_y[index];
      double w = radius[index] * 2;
      double display_x = scaled_width / real_width * (x - center_x) + real_width/2;
      double display_y = scaled_height / real_height * (y - center_y) + real_height/2;
      ellipse((float)display_x, (float)display_y, (float)w * (float)scaled_height / (float)real_height, (float)w * (float)scaled_height / (float)real_height);
      if ((scaled_width < .03) || (scaled_width > 5)) {
        if (fade_rate == 100) {
          if (index == 0) showLabel("Sun", display_x, display_y);
          if (index == 1) showLabel("Mercury", display_x, display_y);
          if (index == 2) showLabel("Venus", display_x, display_y);
          if (index == 3) showLabel("Earth", display_x, display_y);
          if (index == 4) showLabel("Mars", display_x, display_y);
          if (index == 5) showLabel("Jupiter", display_x, display_y);
          if (index == 6) showLabel("Saturn", display_x, display_y);
          if (index == 7) showLabel("Uranus", display_x, display_y);
          if (index == 8) showLabel("Neptune", display_x, display_y);
          if (index == 9) showLabel("Pluto", display_x, display_y);
          if (index == 25) showLabel("Alpha Centauri", display_x, display_y);
          if (index == 27) showLabel("Andromeda", display_x, display_y);
        }
      }
  }
  
  void showLabel(String txt, double x, double y) {
    int text_x = (int) x;
    int text_y = (int) y;
    stroke(255);
    fill(255);
    text(txt, text_x-13, text_y+10);
  }


  void renderLine(double x1, double y1, double x2, double y2, String clr) {
      double display_x1 = scaled_width / real_width * (x1 - center_x) + real_width/2;
      double display_y1 = scaled_height / real_height * (y1 - center_y) + real_height/2;      
      double display_x2 = scaled_width / real_width * (x2 - center_x) + real_width/2;
      double display_y2 = scaled_height / real_height * (y2 - center_y) + real_height/2;
      if (clr == "yellow") stroke(255, 255, 0);
      if (clr == "blue") stroke(0, 255, 255, 50);
      
      line((float)display_x1, (float)display_y1, (float)display_x2, (float)display_y2);
  }
  
   void moveUp() {
     window.realign(center_x, center_y - 25*real_height/scaled_height);
   }
   void moveDown() {
     window.realign(center_x, center_y + 25*real_height/scaled_height);
   }
   void moveLeft() {
     window.realign(center_x - 25*real_width/scaled_width, center_y);
   }
   void moveRight() {
     window.realign(center_x + 25*real_width/scaled_width, center_y);
   }
   void clear() {
     fade(100);
   }
   void fadeWindow() {
     fade(fade_rate);
   }
   void changeFade() {
     fade_rate = fade_rate + 10;
     if (fade_rate > 100) fade_rate = 0;
   }
}

void fade(int opacity) {
     stroke(0);
     fill(0,opacity);
     rectMode(CORNER);       
     rect(0,0,width,height);
} 

 void keyPressed() {
   last_key = (keyCode);
   if (key == CODED) {
     // These are specific codes for arrow keys
     // Here's a list: http://www.cambiaresearch.com/articles/15/javascript-char-codes-key-codes
    if (keyCode == 38) {
      // UP arrow
      window.moveUp();
    }
    if (keyCode == 40) {
      // DOWN arrow
      window.moveDown();
    }
    if (keyCode == 37) {
      // LEFT arrow
      window.moveLeft();
    }
    if (keyCode == 39) {
      // RIGHT arrow
      window.moveRight();
    }
   } else {

     //\ full stop
     if ((key == 92) || (keyCode == 92)) full_stop = !full_stop;
     
     // F - change fade rate
     if ((key == 70) || (keyCode == 70)) window.changeFade();
     
     // - - zoom out
     if ((key == 45) || (keyCode == 45)) window.rescale(.7);
     
     // + - zoom in
     if ((key == 61) || (keyCode == 61)) window.rescale(1.3);
     
     // C - recenter on ship
     if ((key == 67) || (keyCode == 67)) window.realign(x, y);
     
     // L - lock screen on ship
     if ((key == 76) || (keyCode == 76)) locked = !locked;
     
     // Q - detonate bomb on surface of object
     if ((key == 81) || (keyCode == 81)) detonate();
     
     // O - decrease bomb payload
     if ((key == 79) || (keyCode == 79)) detonate_power = detonate_power / 2;
     
     // P - increase bomb payload
     if ((key == 80) || (keyCode == 80)) detonate_power = detonate_power * 2;
     
     detonate_power = Math.round(detonate_power);
     // A - thrust to the right, move ship to the left
     if ((key == 65) || (keyCode) == 65) {
       if (user_thrust_x == 1) {
         user_thrust_x = 0;
       } else {
         user_thrust_x = 1;
         user_thrust_fire_x = 0;
       }
     }
     
     // S - thrust up, move ship down
     if ((key == 83) || (keyCode) == 83) {
       if (user_thrust_y == 2) {
         user_thrust_y = 0;
       } else {
         user_thrust_y = 2;
         user_thrust_fire_y = 0;
       }
     }
     
     // D - thrust to the left, move ship right
     if ((key == 68) || (keyCode) == 68) {
       if (user_thrust_x == 3) {
         user_thrust_x = 0;
       } else {
         user_thrust_x = 3;
         user_thrust_fire_x = 0;
       }
     }
     
     // W - thrust down, move ship up
     if ((key == 87) || (keyCode) == 87) {
       if (user_thrust_y == 4) {
         user_thrust_y = 0;
       } else {
         user_thrust_y = 4;
         user_thrust_fire_y = 0;
       }
     }
     
     // B -- apply breaking thrust
     if ((key == 66) || (keyCode) == 66) {
       brake_thrust = brake_thrust + 1;
       if (brake_thrust > 1) brake_thrust = 0;
     }
     
     // X - turn off all thrust and guidance
     if ((key == 88) || (keyCode) == 88) {
       user_thrust = 0;
       user_thrust_fire = 0;
       user_thrust_x = 0;
       user_thrust_fire_x = 0;
       user_thrust_y = 0;
       user_thrust_fire_y = 0;
       brake_thrust = 0;
       thrust_guidance = false;
       normal_thrust = false;
       orbit_thrust = false;
       full_stop = false;
     }
     
     //N - normal vector thrust
     if ((key == 78) || (keyCode) == 78) normal_thrust = !normal_thrust;
     
     //space - launch thrust
     if ((key == 32) || (keyCode) == 32) orbit_thrust = !orbit_thrust;
     
     // T - set thruster blast to appropriate level for takeoff
     if ((key == 84) || (keyCode) == 84) {
       double dis = sqroot(sqr(x - points_x[close_point]) + sqr(y - points_y[close_point]));
       blast = sqroot(.0000009 * exp(1) * ((1+mass[close_point])/dis));
     }
     
     // O - this key is already reserved?
     if ((key == 79) || (keyCode) == 79) {
       start_orbit = 1;
     }

     // ] - increase thruster blast by 10%
     if ((key == 93) || (keyCode) == 93) blast = blast * 1.1;
     
     // [ - decreasing thrust blast by 10%
     if ((key == 91) || (keyCode) == 91) blast = blast * 1/1.1;
     
     // ; - decreasing thrust blast by 90%
     if ((key == 59) || (keyCode) == 59) blast = blast * 1/10;
     
     // ' - increase thruster blast 10-fold
     if ((key == 222) || (keyCode) == 222) blast = blast * 10;

     // H - toggle heads-up display projecting path
     if ((key == 72) || (keyCode) == 72) {
       heads_up = !heads_up;
     }
     
     // R - display orbit arc
     if ((key == 82) || (keyCode) == 82) {
       drawCircle = drawCircle + 1;
       circle_dis = sqroot(sqr(x - points_x[close_point]) + sqr(y - points_y[close_point]));
       if (drawCircle == 3) drawCircle = 0;
     }
     
     // 1-9 and 0 - set the planet for guidance
     if (keyCode - 48 < 10) {
       if (keyCode - 48 >= 0) {
          planet_set = keyCode - 48;
          guidance = true;
       }
     }
     
     // Z - set the framerate    
     if (keyCode == 90) {
       if (frame_rate == 300) {
         frame_rate = 4;
       } else if (frame_rate == 4) {
         frame_rate = 12;
       } else if (frame_rate == 12) {
         frame_rate = 300;
       }
       frameRate(frame_rate);
     }
     
     // , - slow down time
     if (keyCode == 44) {
       for(int i=0;i<objects;i++) {
         change_x[i] = change_x[i] / sqrt(2);
         change_y[i] = change_y[i] / sqrt(2);
         mass[i] = mass[i] / 2;         
       }
       d_x = d_x / sqrt(2);
       d_y = d_y / sqrt(2);
       time_scale -= 1;
     }
     
     // . - speed up time
     if (keyCode == 46) {
       for(int i=0;i<objects;i++) {
         change_x[i] = change_x[i] * sqrt(2);
         change_y[i] = change_y[i] * sqrt(2);
         mass[i] = mass[i] * 2;
       }
       d_x = d_x * sqrt(2);
       d_y = d_y * sqrt(2);
       time_scale += 1;
     }
     
     // M - turn on automatic guidance
     if (keyCode == 77) {       
       if (planet_set < 10) {
         planet_set = 10;
       } else if (planet_set == 10) {
         planet_set = 25;
       } else if (planet_set == 25) {
         planet_set = 27;
       } else if (planet_set == 27) {
         planet_set = 28;
       } else if (planet_set == 28) {
         planet_set = 10;
       }
       guidance = true;
     }
     
     // 
     if (keyCode == 192) {
        guidance = false;
     }
     
     // G - turn on thrusters in direction of guidance
     if (keyCode == 71) {
       thrust_guidance = !thrust_guidance;
     }
     
     // space - blast off
     if (keyCode == 32) {
       if (fuel == 0) {
         if (init_fuel > 0) {
           fuel = 5000000;
           blast = blast / 10;
           init_fuel = 0;
         }
       }
     }
   }
}

double sqr(double n) {
  return n * n;
}

double sqroot(double n) {
  return sqrt((float) n);
}

double absol(double num) {
  return abs((float)num);
}

int sign(double num) {
  if (num > 0) return 1;
  if (num < 0) return -1;
  return 0;
}

long rnd(double n) {
  return round((float) n);
}
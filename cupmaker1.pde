import processing.dxf.*;

ArrayList<axis> axises;
ArrayList<wall> walls;

float cupHeight = 100;
float radius = 30;
float triangle = 0;
int axisNumber = 10;
float hollow = 5;
int camber = 10;
float incline = 0;
int layers = 10;
float colorAred = 255;
float colorAgreen = 255;
float colorAblue = 255;
float sigma = 0;
float beta = 0;

float transition = 80;

float hollow_ratio = 0.05;
float incline_angle = 0;
float triangle_ratio = 0;

color colorA;

boolean showStroke = true;

boolean Output = false;
int output_step = 0;

boolean HELP = false;
boolean help_flag = false;
String help_word = "CUPHEIGHT:杯子高度\n";

void setup(){
  size(1800,900,P3D);
  surface.setLocation(50,50);
  
  axises = new ArrayList<axis>();
  walls = new ArrayList<wall>();
  
  UI();
}

void draw(){
  data_process();  //参数映射预处理
  
  background(200);
  
  lights();
  
  cam.beginHUD();
  cp5.draw();
  fill(255);
  textFont(createFont("微软雅黑", 16));
  textAlign(LEFT);
  text("Set Color:",20,440);
  showHELP();
  cam.endHUD();
  
  if(mouseX<360 && mouseY<660){
    cam.setActive(false);}
  else{
    cam.setActive(true);}
    
   if(Output){
    output_step = 1;
    Output = false;
  }
  
  
  display();
  //saveFrame("frames/####.tif");
}

void data_process(){
  triangle_ratio = map(triangle,0,1,0,1);
  hollow_ratio = map(hollow,-40,60,-0.4,0.6);
  incline_angle = map(incline,-10,10,-6*PI,6*PI);
  incline_angle = incline_angle / (layers - 1);
  colorA = color(colorAred,colorAgreen,colorAblue);
}

void update(){
  //清空
  if(axises.isEmpty()==false){axises.clear();}
  if(walls.isEmpty()==false){walls.clear();}
  //新建axises
  for(int i=0;i<axisNumber;i++){
    axises.add(new axis(i,axisNumber));
  }
  //新建walls
  for(int la=0;la<layers-1;la++){
    for(int wa=0;wa<axisNumber;wa++){
      float tem_lo1 = wa*TAU/axisNumber + la*incline_angle;
      float tem_lo2 = wa*TAU/axisNumber + (la+1)*incline_angle;
      walls.add(new wall(tem_lo1,tem_lo2,la,axises.get(0).radnew[la],axises.get(0).radnew[la+1]));
    }
  }
}

void display(){
  if(axises.isEmpty()==false){
    if(output_step==1){
      beginRaw(DXF,"output.dxf");
      output_step=2;
    }
    //画axis
    for(int i=0;i<axisNumber;i++){
      axises.get(i).show();
    }
    //画wall
    for(int i=0;i<walls.size();i++){
      walls.get(i).show();
    }
    //画底面
    if(showStroke){
      stroke(255);
      strokeWeight(3);}
    else{noStroke();}
    fill(colorA);
    float tem_x,tem_y,tem_a,rad_change;
    float tem_r = axises.get(0).radnew[0];
    beginShape();
    for(int i=0;i<axisNumber;i++){
      tem_r = axises.get(0).radnew[0];
      tem_a = i*TAU/axisNumber;
      tem_x = tem_r*cos(tem_a);
      tem_y = tem_r*sin(tem_a);
      vertex(tem_x,tem_y,0);
      for(int j=0;j<camber;j++){
        tem_r = axises.get(0).radnew[0];
        rad_change = abs(camber/2-j-0.5) / (camber/2+0.5);
        rad_change = sqrt(1-rad_change*rad_change);
        tem_r = tem_r*(1-hollow_ratio*rad_change);
        tem_a += TAU/axisNumber/(camber+1);
        tem_x = tem_r*cos(tem_a);
        tem_y = tem_r*sin(tem_a);
        vertex(tem_x,tem_y,0);
      }
    }
    endShape();
    //画上表面
    float inside_r;
    if(hollow>0){
      inside_r = axises.get(0).radnew[layers-1] * (1-hollow_ratio-0.1);
    }else{
      inside_r = axises.get(0).radnew[layers-1] *(1-0.1);
    }
    beginShape(TRIANGLE_STRIP);
    for(int i=0;i<axisNumber;i++){
      tem_r = axises.get(0).radnew[layers-1];
      tem_a = i*TAU/axisNumber+incline_angle*(layers-1);
      tem_x = tem_r*cos(tem_a);
      tem_y = tem_r*sin(tem_a);
      vertex(tem_x,tem_y,cupHeight);
      tem_x = inside_r*cos(tem_a);
      tem_y = inside_r*sin(tem_a);
      vertex(tem_x,tem_y,cupHeight);
      for(int j=0;j<camber;j++){
        tem_r = axises.get(0).radnew[layers-1];
        rad_change = abs(camber/2-j-0.5) / (camber/2+0.5);
        rad_change = sqrt(1-rad_change*rad_change);
        tem_r = tem_r*(1-hollow_ratio*rad_change);
        tem_a += TAU/axisNumber/(camber+1);
        tem_x = tem_r*cos(tem_a);
        tem_y = tem_r*sin(tem_a);
        vertex(tem_x,tem_y,cupHeight);
        tem_x = inside_r*cos(tem_a);
        tem_y = inside_r*sin(tem_a);
        vertex(tem_x,tem_y,cupHeight);
      }
    }
    tem_x = axises.get(0).radnew[layers-1]*cos(incline_angle*(layers-1));
    tem_y = axises.get(0).radnew[layers-1]*sin(incline_angle*(layers-1));
    vertex(tem_x,tem_y,cupHeight);
    tem_x = inside_r*cos(incline_angle*(layers-1));
    tem_y = inside_r*sin(incline_angle*(layers-1));
    vertex(tem_x,tem_y,cupHeight);
    endShape();
    //画内表面
    fill(dye(1));
    float inside_r2;
    for(int i=0;i<layers-1;i++){
      beginShape(TRIANGLE_STRIP);
      if(hollow>=0){
        inside_r = axises.get(0).radnew[i] * (1-hollow_ratio-0.05);
        inside_r2 = axises.get(0).radnew[i+1] * (1-hollow_ratio-0.05);
      }else{
        inside_r = axises.get(0).radnew[i] * (1-0.05);
        inside_r2 = axises.get(0).radnew[i+1] * (1-0.05);
      }
      tem_a = i*incline_angle;
      for(int j=0;j<axisNumber*(camber+1);j++){
        tem_x = inside_r*cos(tem_a);
        tem_y = inside_r*sin(tem_a);
        vertex(tem_x,tem_y,cupHeight*i/(layers-1));
        tem_x = inside_r2*cos(tem_a);
        tem_y = inside_r2*sin(tem_a);
        vertex(tem_x,tem_y,cupHeight*(i+1)/(layers-1));
        tem_a += TAU/axisNumber/(camber+1);
      }
      tem_x = inside_r*cos(tem_a);
      tem_y = inside_r*sin(tem_a);
      vertex(tem_x,tem_y,cupHeight*i/(layers-1));
      tem_x = inside_r2*cos(tem_a);
      tem_y = inside_r2*sin(tem_a);
      vertex(tem_x,tem_y,cupHeight*(i+1)/(layers-1));
      endShape();
    }
    //if(hollow>0){
    //  inside_r2 = axises.get(0).radnew[0] * (1-hollow_ratio-0.1);
    //}else{
    //  inside_r2 = axises.get(0).radnew[0] *(1-0.1);
    //}
    //fill(dye(1));
    //beginShape(TRIANGLE_STRIP);
    //for(int i=0;i<axisNumber*(camber+1);i++){
    //  tem_a = i*TAU/axisNumber/(camber+1);
    //  tem_x = inside_r*cos(tem_a);
    //  tem_y = inside_r*sin(tem_a);
    //  vertex(tem_x,tem_y,cupHeight);
    //  tem_x = inside_r2*cos(tem_a);
    //  tem_y = inside_r2*sin(tem_a);
    //  vertex(tem_x,tem_y,0);
    //}
    //vertex(inside_r,0,cupHeight);
    //vertex(inside_r2,0,0);
    //endShape();
    
    if(output_step==2){endRaw();output_step=0;}
  }
}

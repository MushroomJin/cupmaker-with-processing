class wall{
  float location_angle1;
  float location_angle2;
  int downlayer;
  float[] rad1;
  float[] rad2;
  
  wall(float input_location1, float input_location2, int input_layer, float input_rad1, float input_rad2){
    location_angle1 = input_location1;
    location_angle2 = input_location2;
    downlayer = input_layer;
    
    rad1 = new float[camber+1];
    rad2 = new float[camber+1];
    rad1[0] = input_rad1;
    rad2[0] = input_rad2;
    
    float tem_center = camber / 2;
    float rad_change;
    for(int i=0;i<camber;i++){
      //rad_change = abs(tem_center -i-0.5) / (tem_center-0.5);
      //if(rad_change>0.8){rad_change=map(rad_change,1,0.8,-PI,0);}
      //else{rad_change=map(rad_change,0.8,0,0,PI);}
      //rad_change = (1+sin(rad_change))*0.5;
      rad_change = abs(tem_center-i-0.5) / (tem_center+0.5);
      rad_change = sqrt(1-rad_change*rad_change);
      rad1[i+1] = input_rad1*(1-hollow_ratio*rad_change);
      rad2[i+1] = input_rad2*(1-hollow_ratio*rad_change);
    }
  }
  
  void show(){
    if(showStroke){
      stroke(255);
      strokeWeight(1);}
    else{noStroke();}
    fill(dye(1));
    float tem_x,tem_y,tem_a1,tem_a2;
    tem_a1 = location_angle1;
    tem_a2 = location_angle2;
    beginShape(TRIANGLE_STRIP);
    tem_x = rad1[0]*cos(tem_a1);
    tem_y = rad1[0]*sin(tem_a1);
    vertex(tem_x,tem_y,cupHeight*downlayer/(layers-1));
    tem_x = rad2[0]*cos(tem_a2);
    tem_y = rad2[0]*sin(tem_a2);
    vertex(tem_x,tem_y,cupHeight*(downlayer+1)/(layers-1));
    for(int i=0;i<camber;i++){
      float tem_ratio = abs(camber/2-i-0.5)/(camber/2+0.5);
      fill(dye(tem_ratio));
      tem_a1 += TAU/axisNumber/(camber+1);
      tem_a2 += TAU/axisNumber/(camber+1);
      tem_x = rad1[i+1]*cos(tem_a1);
      tem_y = rad1[i+1]*sin(tem_a1);
      vertex(tem_x,tem_y,cupHeight*downlayer/(layers-1));
      tem_x = rad2[i+1]*cos(tem_a2);
      tem_y = rad2[i+1]*sin(tem_a2);
      vertex(tem_x,tem_y,cupHeight*(downlayer+1)/(layers-1));
    }
    fill(dye(1));
    tem_a1 += TAU/axisNumber/(camber+1);
    tem_a2 += TAU/axisNumber/(camber+1);
    tem_x = rad1[0]*cos(tem_a1);
    tem_y = rad1[0]*sin(tem_a1);
    vertex(tem_x,tem_y,cupHeight*downlayer/(layers-1));
    tem_x = rad2[0]*cos(tem_a2);
    tem_y = rad2[0]*sin(tem_a2);
    vertex(tem_x,tem_y,cupHeight*(downlayer+1)/(layers-1));
    endShape();
  }
  
  
  
  
}

class axis{
  float location_angle;
  float[] radnew;
  
  axis(int a,int b){
    location_angle = a*2*PI/b;
    radnew = new float[layers];
    //float tem_center = layers / 2;
    
    float[] tem_rad;
    float[] tem_rad2;
    
    tem_rad = new float[layers];
    for(int k=0;k<layers;k++){
      float tem_ratio;
      if(triangle>=0){
        tem_ratio = layers - sqrt(layers*layers-k*k);}
      else{tem_ratio = layers - sqrt(layers*layers-(layers-k)*(layers-k));}
      tem_rad[k] = radius * (tem_ratio/layers+0.5)/0.55;
    }
    
    tem_rad2 = new float[layers];
    for(int la=0;la<layers;la++){
      float tem_h = cupHeight*la/(layers-1);
      tem_rad2[la] = radius * (1+cos(sigma*tem_h+beta));
    }

    for(int i=0;i<layers;i++){
      //radnew[i] = radius + radius * triangle_ratio * (tem_center-i) / tem_center;
      //radnew[i] = radius * (1-triangle_ratio) + tem_rad[i] * triangle_ratio;
      radnew[i] = radius * (1-triangle_ratio) + tem_rad2[i] * triangle_ratio;
    }
  }
  
  void show(){
    float tem_loc = location_angle;
    if(showStroke){
      stroke(255);
      strokeWeight(3);}
    else{noStroke();}
    noFill();
    beginShape();
    for(int i=0;i<layers;i++){
      vertex(radnew[i]*cos(tem_loc),radnew[i]*sin(tem_loc),i*cupHeight/(layers-1));
      tem_loc += incline_angle;
    }
    endShape();
  }
}

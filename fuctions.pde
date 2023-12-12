color dye(float deep_ratio){
  float r,g,b;
  if(hollow<0){
    r = colorAred + transition*(1-deep_ratio);
    g = colorAgreen + transition*(1-deep_ratio);
    b = colorAblue + transition*(1-deep_ratio);}
  else{if(hollow>0){
         r = colorAred + transition*deep_ratio;
         g = colorAgreen + transition*deep_ratio;
         b = colorAblue + transition*deep_ratio;}
       else{r = colorAred;
            g = colorAgreen;
            b = colorAblue;}
      }
  return color(r,g,b);
}


void showHELP(){
  if(HELP){
    HELP = false;
    if(help_flag){help_flag=false;}
    else{help_flag=true;}
  }
  if(help_flag){
      noStroke();
      fill(#786482);
      float tem_x = width-300;
      float tem_wid = 280;
      rect(tem_x,60,tem_wid,height-450);
      fill(255);
      //textLeading(5);
      textAlign(CENTER);
      textFont(createFont("微软雅黑",50));
      textSize(15);
      text(help_word,tem_x+10,70,tem_wid-20,height-450);
  }
}

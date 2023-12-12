import peasy.*;
import controlP5.*;

ControlP5 cp5;
PeasyCam cam;

void UI(){
  int sliderWidth = 300;
  int sliderHeight = 30;
  
  
  cam = new PeasyCam(this,800);
  
  cp5 = new ControlP5(this,createFont("微软雅黑", 14));

  //变量列表：
  //a--按键
  //是否显示描边  √
  //导出
  //b--整体轮廓
  //杯子高度  √
  //杯子宽度  √
  //杯子收口程度  √
  //c--杯面细节
  //斜线数目 √
  //凹陷程度 √
  //圆弧程度 √
  //倾斜角度 √
  
  cp5.addButton("HELP")//帮助菜单
    .setPosition(width-20-sliderWidth/3, 20)
    .setSize(sliderWidth/3, sliderHeight)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
  
  cp5.addButton("Output")//导出
    .setPosition(20, 580)
    .setSize(sliderWidth/3, sliderHeight)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addToggle("showStroke")//显示描线
    .setPosition(20, 620)
    .setSize(sliderWidth/3, sliderHeight)
    .setValue(true)
    .setMode(ControlP5.SWITCH)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
  
  cp5.addSlider("cupHeight")//杯子高度
    .setPosition(20, 20)
    .setSize(sliderWidth, sliderHeight)
    .setRange(5, 600)
    .setValue(100)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("radius")//杯子平均半径
    .setPosition(20, 60)
    .setSize(sliderWidth, sliderHeight)
    .setRange(1, 100)
    .setValue(30)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("triangle")//杯子收口程度
    .setPosition(20, 300)
    .setSize(sliderWidth, sliderHeight)
    .setRange(0, 1)   //映射到百分比信息
    .setValue(0)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("axisNumber")//斜线数目
    .setPosition(20, 100)
    .setSize(sliderWidth, sliderHeight)
    .setRange(4, 40)
    .setValue(10)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("hollow")//凹陷程度
    .setPosition(20, 140)
    .setSize(sliderWidth, sliderHeight)
    .setRange(-40, 60)  //映射到百分比
    .setValue(5)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("camber")//圆弧程度
    .setPosition(20, 180)
    .setSize(sliderWidth, sliderHeight)
    .setRange(1, 500)
    .setValue(10)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("incline")//倾斜程度
    .setPosition(20, 220)
    .setSize(sliderWidth, sliderHeight)
    .setRange(-10, 10) //映射到弧度制角度
    .setValue(0)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("layers")//高度分层
    .setPosition(20, 260)
    .setSize(sliderWidth, sliderHeight)
    .setRange(3,500) //
    .setValue(10)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("sigma")
    .setPosition(20, 340)
    .setSize(sliderWidth, sliderHeight)
    .setRange(0,0.1) 
    .setValue(0)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("beta")
    .setPosition(20, 380)
    .setSize(sliderWidth, sliderHeight)
    .setRange(-PI,PI) 
    .setValue(0)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("colorAred")
    .setPosition(20, 460)
    .setSize(sliderWidth, sliderHeight)
    .setRange(5+transition,255-transition) //
    .setValue(255)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("colorAgreen")
    .setPosition(20, 500)
    .setSize(sliderWidth, sliderHeight)
    .setRange(5+transition,255-transition) //
    .setValue(255)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.addSlider("colorAblue")
    .setPosition(20, 540)
    .setSize(sliderWidth, sliderHeight)
    .setRange(5+transition,255-transition) //
    .setValue(255)
    .setColorBackground(#786482)
    .setColorActive(#D2C8E6)
    .setColorForeground(#A096B4)
    ;
    
  cp5.setAutoDraw(false);
  
  help_word = help_word.concat("RADIUS:杯子平均半径\n");
  help_word = help_word.concat("AXISNUMBER:杯面细节细分数\n");
  help_word = help_word.concat("HOLLOW:杯面凹凸程度\n");
  help_word = help_word.concat("CAMBER:杯面凹凸细节细分数（建议最后调节）\n");
  help_word = help_word.concat("INCLINE:杯面细节倾斜程度\n");
  help_word = help_word.concat("LAYERS:高度细分数\n");
  help_word = help_word.concat("TRIANGLE:杯子各层半径呈现正弦式波动程度\n");
  help_word = help_word.concat("SIGMA:杯子半径波动频率\n");
  help_word = help_word.concat("BETA:杯子半径波动相位\n");
  help_word = help_word.concat("OUTPUT:将当前杯子导出为dxf格式三维图像（最多可导出10次)\n");
  help_word = help_word.concat("SHOWSTROKE:是否显示曲面边缘\n");
}


void showStroke(boolean tem_flag){
  if(tem_flag){
    showStroke = true;}
  else{
    showStroke = false;}
}


void controlEvent(ControlEvent theEvent){
  if(theEvent.isFrom(cp5.getController("cupHeight"))  ||
     theEvent.isFrom(cp5.getController("radius"))  ||
     theEvent.isFrom(cp5.getController("triangle"))  ||
     theEvent.isFrom(cp5.getController("axisNumber"))  ||
     theEvent.isFrom(cp5.getController("hollow"))  ||
     theEvent.isFrom(cp5.getController("camber"))  ||
     theEvent.isFrom(cp5.getController("layers"))  ||
     theEvent.isFrom(cp5.getController("sigma"))  ||
     theEvent.isFrom(cp5.getController("beta"))  ||
     theEvent.isFrom(cp5.getController("colorRed"))  ||
     theEvent.isFrom(cp5.getController("colorGreen"))  ||
     theEvent.isFrom(cp5.getController("colorBlue"))  ||
     theEvent.isFrom(cp5.getController("incline"))){
     update();
   }
}

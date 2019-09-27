//----------------------------------------
//-------INIT
//----------------------------------------
import processing.pdf.*;
//setup all the vars we will use - up to 9 in this template currently
HDrawablePool pool0, pool, pool1, pool2, pool3, pool4, pool5, pool6, pool7, pool8;
HColorPool colors, colors1, colors2, colors3, colors4, colors5, colors6, colors7, colors8;


void setup(){
	size(1300,730);
	H.init(this).background(#eeeeee);
	smooth();

//This is an array of how many objects to assign each item in the build array
int[] dNum = {100,100,100,100,100,100};  // Alternate syntax
int[] colPool = {#666666,#999999,#CCCCCC,#d33331, #000000, #FFFFFF};  // Alternate syntax

  colors = new HColorPool(#d33331);
  colors1 = new HColorPool(#666666);


//do a for loop to build color pools

for (int i = 0; i < 5; i = i+1) {
  
//----------------------------------------
//-------BUILD COLOR POOLS
//----------------------------------------
   

  pool = new HDrawablePool(dNum[i]);
  print(i);

  colors = new HColorPool(colPool[i]);
 //why is the above not working?

  pool.autoAddToStage()
  .add(new HShape("svg"+i+".svg")) //Set shape(s) used to fill the map
 
    .layout(
      new HShapeLayout()
      .target(
        new HImage("shapeMap"+i+".png")  //Set shape map
      ))
    .onCreate(
      new HCallback() {
        public void run(Object obj) {
          HShape d = (HShape) obj;
          d
            .enableStyle(false)
         .strokeJoin(ROUND)
            .strokeCap(ROUND)
            .strokeWeight(0)
            .stroke(#333333)  
              .anchorAt(H.CENTER)
            .size( (int)random(22,54) )
               // .size( 50 + ( (int)random(3) * 50) ) // 50, 100, 150, 200
                .rotate( -2 + ( (int)random(3) * 4) ) // 50, 100, 150, 200          
          ;
          d.randomColors(colors.fillOnly()); // this line needs to grab from I, but its not
        }}) 
    .requestAll()
  ;
 
}


//----- Make the magic happen

  saveVector();
  noLoop();
}

void draw() {
  H.drawStage();
}

void saveVector() {
  PGraphics tmp = null;
  tmp = beginRecord(PDF, "render.pdf");

  if (tmp == null) {
    H.drawStage();
  } else {
    H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
  }

  endRecord();
}
 
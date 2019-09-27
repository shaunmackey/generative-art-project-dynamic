//----------------------------------------
//-------INIT
//----------------------------------------
import processing.pdf.*;
//setup all the vars we will use - up to 9 in this template currently
HDrawablePool pool0, pool, pool1, pool2, pool3, pool4, pool5, pool6, pool7, pool8;
HColorPool colors, colors1, colors2, colors3, colors4, colors5, colors6, colors7, colors8;


void setup() {
  size(1300, 730);
  H.init(this).background(#eeeeee);
  smooth();

  int[] dNum = {10, 100, 300};  //how many of each asset to build
  int[] colPool0 = {#FFFFFF, #000000, #d33331};  // array where its pulling all colors (1st pool gets first color, 2nd pool gets 2nd color, etc)
  int[] colPool1 = {#00ffdf, #c90000, #ffe700};  //  I would like the second group to pull randomly from this array
  int[] colPool2 = {#ce9f9f, #bbc7d4, #aec5a2};  //  I would like the third group to pull randomly from this array



  //do a for loop to build color pools
  for (int i = 0; i < 3; i = i+1) {

    //----------------------------------------
    //-------BUILD COLOR POOLS
    //----------------------------------------


    pool = new HDrawablePool(dNum[i]); //this specifies how many assets to build in each pool
   // print(dNum[i]);

   //TODO FIX THE FOLLOWING LINE
   colors = new HColorPool(colPool0[i]); //TOFIX: this colors all assets in a pool from a hex where I is the value in colPool0, but should pull random colors from colPool0 for the first pool, colPool1 for the second pool and colPool2 for the third pool. 

    pool.autoAddToStage()
      .add(new HShape("svg"+i+".svg")) //Set shape(s) used to fill the map

      .layout(
      new HShapeLayout()
      .target(
      new HImage("shapeMap"+i+".png")  //Set shape map which shapes are mapped to
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
          .size( (int)random(22, 54) )
          // .size( 50 + ( (int)random(3) * 50) ) // 50, 100, 150, 200
          .rotate( -2 + ( (int)random(3) * 4) ) // 50, 100, 150, 200          
          ;
        d.randomColors(colors.fillOnly()); //TOFIX: this colors all assets in a pool from a hex where I is the value in colPool0, but should pull random colors from colPool0 for the first pool, colPool1 for the second pool and colPool2 for the third pool. 
      }
    }
    ) 
    .requestAll()
      ;
  }


  //----- BELOW IS WORKING. SAVE VECTOR, DRAW STAGE AND EXPORT PDF

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
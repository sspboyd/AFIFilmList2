import processing.opengl.*;

float PHI = 0.618033989;

Film[] films;

PFont filmName;
PFont yearLabel;
PFont titleLabel;

String[] data;

// int chartWidth = 1680;
int chartWidth = 1280; // 9b100 screen size 
// int chartWidth = 1344;
// int chartWidth = 3000;
// int chartWidth = 1024;
// int chartWidth = 640;
int chartHeight  = (int)(chartWidth * pow(PHI, 1));
float margin = chartWidth * pow(PHI, 7);
float plotX1;
float plotX2;
float plotY1;
float plotY2;

void setup() {
  background(255);
  size(chartWidth, chartHeight);
  smooth();
  plotX2 = width-margin;
  plotY1 = margin+margin;
  plotX1 = margin;
  plotY2 = height - margin;

  String fileName = "afiFilmList.txt";
  films=getFilms(fileName);
  for (Film f : films) {
    f.targX = map(f.yr, 1910, 2015, plotX1, plotX2);
    f.targY = map(f.ranking, 1, 100, plotY1, plotY2);
    // f.x = random(plotX1, plotX2);
    // f.y = random(plotY1, plotY2);
    f.x = width/2+random(5);
    f.y = height/2+random(5);
    f.targW = 10;
  }

  filmName = createFont("Helvetica", 24);
  yearLabel = createFont("Helvetica", 18);
  titleLabel = createFont("Helvetica", 48);

  randomSeed(47);
}

void draw() {
  background(255);
  drawYearLabels();
  textFont(titleLabel);
  fill(0); 
  noStroke();
  text("AFI Top 100 Films", plotX1, plotY1-10);
  for (Film f : films) {
    f.update();
    f.render();
  }

  //drawByRow();
}


Film[] getFilms(String fn) {
  Film[] films;
  int rowCount = 0;
  String[] data = loadStrings(fn);
  films = new Film[data.length-1];

  println("number of lines of data : " + (data.length - 1));
  for (int i = 0; i < data.length - 1; i++) {
    String[] pieces = split(data[i], TAB);
    if (int(pieces[2]) > 0) {    
      Film f = new Film();
      f.x = 0;
      f.y = 0;
      f.name = pieces[0];
      f.yr = int(pieces[1]);
      f.ranking = int(pieces[2]);
      films[rowCount++] = f;
    }
  }
  films = (Film[])subset(films, 0, rowCount);
  return films;
}




void drawYearLabels() {
  //pushMatrix();
  //translate(0, height);
  //rotate(-PI/2);
  fill(200);
  textFont(yearLabel);
  for (int i = 1910; i<2015; i+=10) {
    float lx = map(i, 1910, 2015, plotX1, plotX2);
    stroke(220);
    strokeWeight(.5);
    line(lx, plotY1, lx, plotY2);
    text(i, lx, plotY2+18);
  }
  //popMatrix();
}


void drawByRow() {
  for (int i = 0; i < data.length - 1; i++) {
    String[] pieces = split(data[i], TAB);
    int yr = int(pieces[1]);
    // println(yr);
    float rx = map(yr, 1910, 2012, 0, width);
    fill(0);
    noStroke();
    rect(rx, height-100, 2, 100);

    // if mouse is close by then show film name
    if ( abs(mouseX - rx) < 5 ) {
      pushMatrix();
      translate(rx, height);
      rotate(-PI/2);

      fill(170);
      textFont(yearLabel);
      text(pieces[1], 90, 105);
      fill(0);
      textFont(filmName);
      text(pieces[0], 90, 0 );

      popMatrix();
    }
  }
}















// UI and Save Functions___________________________________________

void keyPressed() {
  if (key == 'S') screenCap(".tif");
}

void screenCap(String type) {
  // save functionality in here
  String outputDir = "out/";
  String sketchName = "template-";
  String dateStamp = year() + nf(month(), 2) + nf(day(), 2) + "-" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  String fileType = type;
  String fileName = outputDir + sketchName + fileType;
  save(fileName);
  println("Screenshot saved to " + fileName);
}

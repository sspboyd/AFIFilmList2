float PHI = 0.618033989;

int[] years = new int[2];
int currRankYear=0;
Film[] films;


PFont filmName;
PFont yearLabel;
PFont titleLabel;

String title ="AFI Top 100 Films";
String subHeading;

String[] data;

// int chartWidth = 1680;
// int chartWidth = 1280; // 9b100 screen size 
int chartWidth = 1344;
// int chartWidth = 3000;
// int chartWidth = 1024;
// int chartWidth = 640;
// int chartWidth = screenWidth;

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

  years[0] = 1998;
  years[1] = 2007;


  String fileName = "afiFilmList.txt";
  films=getFilms(fileName);

  subHeading = years[currRankYear]+" Ranking";


  for (Film f : films) {
    f.targX = map(f.yr, 1910, 2015, plotX1, plotX2);
    f.targY = map(f.rankings[0], 1, 100, plotY1, plotY2);
    // f.x = random(plotX1, plotX2);
    // f.y = random(plotY1, plotY2);
    f.x = width/2+random(50);
    f.y = height/2+random(50);
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
  drawRankingLabels();
  textFont(titleLabel);
  fill(0); 
  noStroke();
  float tw = textWidth(title); 
  text(title, plotX1, plotY1-10);
  textFont(filmName);
  text(subHeading, plotX1 + tw + 30, plotY1 - 10);
  for (Film f : films) {
    f.update();
    f.render();
  }

  //drawByRow();
}


Film[] getFilms(String fn) {
  Film[] films; // poor practice here to be creating a var with the same name as a global var.
  int rowCount = 0;
  String[] data = loadStrings(fn);
  films = new Film[data.length-1];

  println("number of lines of data : " + (data.length - 1));
  for (int i = 0; i < data.length - 1; i++) {
    String[] pieces = split(data[i], TAB);
    
    if (int(pieces[3]) > 0 || int(pieces[2]) > 0) {    
      Film f = new Film();
      f.x = 0;
      f.y = 0;
      f.name = pieces[0];
      f.yr = int(pieces[1]);
      f.rankings[0] = int(pieces[2]);
      f.rankings[1] = int(pieces[3]);
      // f.ranking_98 = int(pieces[2]);
      // f.ranking_07 = int(pieces[3]);
      films[rowCount++] = f;
    }
  }
  films = (Film[])subset(films, 0, rowCount);
  return films;
}



// UI and Save Functions___________________________________________

void prev() {
  if (currRankYear == 0) {
    currRankYear = years.length-1;
  }
  else{
  currRankYear = currRankYear - 1;
  }
  // updateDataDisplay();
}

void next() {
  if (currRankYear == years.length-1) {
    currRankYear = 0; 
  }
  else{
  currRankYear = currRankYear + 1;
  }
  // updateDataDisplay();
}



void keyPressed() {
  if (key == 'S') screenCap(".tif");




  if (key == CODED) {
    if (keyCode == LEFT) {
      // prev();
    }
    if (keyCode == RIGHT) {
      // next();
    }
  }    


  if (key == '7') {
    currRankYear = 1;
    subHeading = "2007 Ranking";
    for (Film f : films) {
      if (f.rankings[1] == 0) {
        f.targY = height+150;
      }
      else {
        f.targY = map(f.rankings[0], 1, 100, plotY1, plotY2);
      }
    }
  }

  if (key == '8') {
    currRankYear = 0;
    subHeading = "1998 Ranking";
    for (Film f : films) {
      if (f.rankings[1] == 0) {
        f.targY = height+150;
      }
      else {
        f.targY = map(f.rankings[1], 1, 100, plotY1, plotY2);
      }
    }
  }
}


void screenCap(String type) {
  // save functionality in here
  String outputDir = "out/";
  String sketchName = "afiTop100Films-";
  String dateStamp = year() + nf(month(), 2) + nf(day(), 2) + "-" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  String fileType = type;
  String fileName = outputDir + sketchName + fileType;
  save(fileName);
  println("Screenshot saved to " + fileName);
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

void drawRankingLabels() {
  fill(200);
  textFont(yearLabel);
  for (int i = 1; i<100; i+=50) {
    float ly = map(i, 100, 1, plotY2, plotY1);
    stroke(220);
    strokeWeight(.5);
    // line(plotX1, ly, plotX2, ly);
    text("#"+i, plotX1-textWidth("1000"), ly);
  }
}








// Slush

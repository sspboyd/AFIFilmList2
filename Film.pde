class Film {

  String name;
  int yr;
  int[] rankings = new int[2]; // only two years worth of data

  int ranking_07;
  int ranking_98;
  float targX, x, targY, y, targW, w;

  void update() {
    x += (targX - x) * .05;
    y += (targY - y) * .03;
    w += (targW - w) * .105;
  }

  void render() {

    pushMatrix();
    translate(x, y);

    // rotate(-PI/2);
    fill(0, 0, 0, 155);
    stroke(255, 255, 255, 200);
    ellipse(0, 0, w, w);
    targW = 8;

    fill(0, 0, 0, 5);

    if ( dist(mouseX, mouseY, x, y) < 15 ) {
      pushMatrix();
      translate(0, 0, 1);
      targW = 25;
      fill(255, 255, 255, 19);
      //stroke(0);
      rect(15, -30, 250, 60);
      fill(70);
      noStroke();
      textFont(yearLabel);
      text(yr + ", #" + rankings[currRankYear], 15, 18); // bug: needs a ref to the current metric eg. current_Ranking, or just ranking 
      fill(0);
      textFont(filmName);
      text(name, 15, 0 );
      popMatrix();
    } else {
      
      textFont(filmName);
      text(name, 15, 0 );
    }
    popMatrix();
  }
}


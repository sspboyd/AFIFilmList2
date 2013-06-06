class Film {

  String name;
  int yr;
int[] rankings = new int[2]; // only two years worth of data

  int ranking_07;
  int ranking_98;
  float targX, x, targY, y, targW, w;

  void update() {
    x += (targX - x) * .05;
    y += (targY - y) * .05;
    w += (targW - w) * .275;
  }

  void render() {

    pushMatrix();
    translate(x, y);

    // rotate(-PI/2);
    fill(0);
    noStroke();
    ellipse(0, 0, w, w);
    targW = 10;

    fill(0, 20);

    if ( dist(mouseX, mouseY, x, y) < 15 ) {
      targW = 25;
      fill(70);
      textFont(yearLabel);
      text(yr + ", #" + rankings[currRankYear], 15, 18); // bug: needs a ref to the current metric eg. current_Ranking, or just ranking 
      fill(0);
    }

    textFont(filmName);
    text(name, 15, 0 );

    popMatrix();
  }
}


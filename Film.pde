class Film {

  String name;
  int yr;
  int ranking;
  float targX, x, targY, y, targW, w;

  void update() {
    x += (targX - x) * .075;
    y += (targY - y) * .075;
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
    if ( dist(mouseX, mouseY, x, y) < 15 ) {
    targW = 25;
      fill(170);
      textFont(yearLabel);
      text(yr + ", #" + ranking, 15, 18);
      fill(0);
      textFont(filmName);
      text(name, 15, 0 );
    }
    popMatrix();
  }
}


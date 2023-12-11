 class Bubble
 {
  float x;
  float y;
  float size;
  float radius;
  float speedY;
  float speedMultiplierX;
  color bubbleColor;
  
  Bubble(float _y) {
   size = (float)linearInterpolate(10.0, 40.0, Math.random());
   bubbleColor = getRandomColor();
   x = (float)(Math.random() * width);
   y = _y + size;
   radius = size / 2.0;
   speedY = 0.005 * size * size;
   speedMultiplierX = 1.0;
  }
  
  Bubble(float _x, float _y) {
    this(_y);
    x = _x;
  }
  
  void show() {
    fill(bubbleColor);
    ellipse(x, y, size, size);
  }
  float getOverlap() {
    
    return max(lineHeight - (y - radius), 0.0);
  }
  
  
  boolean isFiltered() {
    // bitshifting hackery from processing docs to get color values
    float red = bubbleColor >> 16 & 0xFF;
    float blue = bubbleColor & 0xFF;
    float green = bubbleColor >> 8 & 0xFF;
    return (!(red > blue && red > green)) && getOverlap() > 0.0;
  }

  void wrapY() {
    if (y <= -size) {
      y = height + size;
    }
  }

  void tick() {
    if (isFiltered()){
      y += getOverlap();
      speedY = 0.0;
      speedMultiplierX = 0.0;
    }
    y -= speedY;
    x += (float)linearInterpolate(-1, 1, Math.random()) * speedMultiplierX;
    wrapY();
    show();
    
  }
}

 class Bubble
 {
  float x;
  float y;
  float size;
  float radius;
  float speedY;
  boolean isRed;
  color bubbleColor;
  
  Bubble(float _y) {
   size = (float)linearInterpolate(10.0, 40.0, Math.random());
   bubbleColor = getRandomColor();
   x = (float)(Math.random() * width);
   y = _y + size;
   radius = size / 2.0;
   speedY = 0.005 * size * size;
   isRed = _isRed();
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
    return max(lineHeight - (y - radius) - collisionSlop, 0.0);
  }
  boolean _isRed() {
    // bitshifting hackery from processing docs to get color values
    float red = bubbleColor >> 16 & 0xFF;
    float blue = bubbleColor & 0xFF;
    float green = bubbleColor >> 8 & 0xFF;
    return (red > blue && red > green);
  }
  
  boolean isFiltered() {
    if (isRed) {
      return false;
    }
    return (getOverlap() > 0.0);
  }

  void wrapY() {
    if (y < -size) {
      y = height + size;
    }
  }

  void tick() {
    if (isFiltered()){
      // getting the overlap to "resolve" the collision between the line and the bubble
      y += getOverlap();
      show();
      return;
    }
    
    y -= speedY;
    x += (float)linearInterpolate(-1, 1, Math.random());
    wrapY();
    show();
    
  }
}

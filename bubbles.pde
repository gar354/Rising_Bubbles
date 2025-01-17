// feel free to change this
float lineHeight = 200;
// collision slop value, helps with keeping collisions resolved and stable
float collisionSlop = 0.1;

// --

ArrayList<Bubble> contactList;
ArrayList<Bubble> bubbles;

// proper casing for functions: https://www.oracle.com/java/technologies/javase/codeconventions-namingconventions.html
// utility functions
color getRandomColor() {
  float currentR = lerp(0.0, 255.0, (float)Math.random());
  float currentG = lerp(0.0, 255.0, (float)Math.random());
  float currentB = lerp(0.0, 255.0, (float)Math.random());
  return color(currentR, currentG, currentB);
}
double linearInterpolate(double x1, double x2, double weight) {
  return (1 - weight) * x1 + weight * x2;
}

float distSquared(float x1, float y1, float x2, float y2) {
  float xDiff = x1 - x2;
  float yDiff = y1 - y2;
  return (xDiff * xDiff) + (yDiff * yDiff);
}
// ---

void setup() {
  size(1000, 1000);
  // initialize arraylists
  contactList = new ArrayList<Bubble>();
  bubbles = new ArrayList<Bubble>();
}

boolean areBubblesIntersecting(Bubble bubble1, Bubble bubble2) {
  // use distance squared for optimized collision checking
  float minDistance = bubble1.radius + bubble2.radius;
  float distanceSquared = distSquared(bubble1.x, bubble1.y, bubble2.x, bubble2.y);
  return distanceSquared < minDistance * minDistance;
}

boolean isBubbleIntersectingWall(Bubble bubble) {
  return (
    (bubble.x + bubble.radius >= width) ||
    (bubble.x - bubble.radius <= 0.0)
    );
}

void draw() {
  background(255);
  textSize(25);
  fill(0);
  line(0, lineHeight, width, lineHeight);
  text("Bubble Amount: " + bubbles.size(), 0, 25);
  for (int i = 0; i < bubbles.size(); i++) {
    
    Bubble bubble = bubbles.get(i);
    bubble.tick();
    // collisions with walls
    if (isBubbleIntersectingWall(bubble)) {
      contactList.add(bubble);
    }
    // bubble to bubble collisions
    for (int j = i + 1; j < bubbles.size(); j++) {
      Bubble bubble1 = bubbles.get(j);
      if (bubble != bubble1) {
        if (areBubblesIntersecting(bubble, bubble1)) {
          contactList.add(bubble);
          contactList.add(bubble1);
        }
      }
    }
  }
  // loop through the contact list and remove all of the bubbles
  for (Bubble bubble : contactList) {
    // a bubble may already have been removed from the list, check to see if it's not null
    if (bubble != null) {
      bubbles.remove(bubble);
    }
  }
  contactList.clear();
}

void mousePressed() {
  for (int i = 0; i < 10; i++) {
    float randX = (float)(Math.random() * width);
    float randY = (float)(Math.random() * height);
    bubbles.add(new Bubble(randX, randY));
  }
}

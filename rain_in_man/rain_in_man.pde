ArrayList<TextDrop> drops;
PImage umbrella;
float umbrellaX, umbrellaY;

void setup() {
  size(800, 600);
  drops = new ArrayList<TextDrop>();
  umbrella = loadImage("1.png"); // 우산을 든 사람 이미지 로드
  umbrellaX = width / 2;
  umbrellaY = height / 2;
  
  // 초기 텍스트 방울 생성
  for (int i = 0; i < 200; i++) {
    drops.add(new TextDrop());
  }
}

void draw() {
  background(255);
  
  // 우산 위치 업데이트
  umbrellaX = mouseX;
  umbrellaY = mouseY;
  
  // 텍스트 방울 업데이트 및 표시
  for (TextDrop drop : drops) {
    drop.update();
    drop.display();
  }
  
  // 우산 이미지 표시
  image(umbrella, umbrellaX - umbrella.width / 2, umbrellaY - umbrella.height / 2);
}

class TextDrop {
  float x, y;
  float speed;
  String text;
  boolean stopped;
  
  TextDrop() {
    reset();
    y = random(height);
  }
  
  void reset() {
    x = random(width);
    y = -10;
    speed = random(2, 5);
    text = "비";
    stopped = false;
  }
  
  void update() {
    if (!stopped) {
      y += speed;
      
      // 우산과 충돌 확인
      if (y > umbrellaY - umbrella.height / 2 && y < umbrellaY + umbrella.height / 2) {
        if (x > umbrellaX - umbrella.width / 2 && x < umbrellaX + umbrella.width / 2) {
          y = umbrellaY - umbrella.height / 2;
          stopped = true;
        }
      }
      
      // 화면 밖으로 나가면 재설정
      if (y > height) {
        reset();
      }
    }
  }
  
  void display() {
    fill(0);
    textAlign(CENTER, CENTER);
    text(text, x, y);
  }
}

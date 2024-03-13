class user{
  float money;
  user(float m) {
    money = m;
  }
  
  void buy(company c) {
    if(money >= c.price) {
      money -= c.price;
      c.holdings += 1;
    }
  }
  
  void sell(company c) {
    if(c.holdings > 0) {
      c.holdings -= 1;
      money += c.price;
    }
  }
  
  void update() {
    text("Capital: " + str( money), 10, 20 );
  }
}

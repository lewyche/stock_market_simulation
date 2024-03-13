class company {  
  
  String name;
  String ticker;
  float price;
  float volatility;
  float trend; //percentage chance the stock will go up or down
  boolean last_direction; //whether the market went up or down last time
  
  int holdings;
  
  int max_price;
  int min_price;
  
  company(String n, String t, float v, int max, int min) {
    name = n;
    ticker = t;
    volatility = v;
    max_price = max;
    min_price = min;
    
    price = random(min_price, max_price);
    trend = random(40, 60);
    
    holdings = 0;
  }
  
  void calc_next_price() {
    float next_price;
    boolean direction = calc_direction();
    
    if(direction) {
      //stock goes up
      next_price = random(price, price + volatility);
      if(next_price >= max_price) {
        next_price = max_price;
        //price will be more likely to go down after it reaches the max
        set_negative_trend();
        
      }
    } else {
      //stock goes down
      next_price = random(price - volatility, price);
      if(next_price <= min_price) {
        next_price = min_price;
        //price will be more likely to go up after it reaches the min
        set_positive_trend();
      }
    }
    price = next_price;
  }
  
  //calc direction of stock
  boolean calc_direction() {
    int direction = int(random(100));
    
    if(direction >= trend) {
      //go up
      last_direction = true;
      return true;
    } else {
      //go down
      last_direction = false;
      return false;
    }
  }
  
  String get_direction() {
    if(last_direction) {
      return "UP";
    }
    
    return "DOWN";
  }
  
  void print_price() {
    println(name + " " + ticker + " " + str(price) + " " + str(last_direction));
  }
  
  //rounds to two decimals
  float get_price() {
    return round(price * 100.0) / 100.0;
  }
  
  String get_data() {
    return ticker + " " + str(get_price()) + " " + get_direction() + "  ";
  }
  
  //increase chance of price increasing
  void set_positive_trend() {
    if(trend >= 50) {
      trend -= random(10, 30);
    } else {
      trend -= random(5, 15);
    }
    
    if(trend <= 0) {
      trend = 5;
    }
  }
  
  //decrease change of price increasing
  void set_negative_trend() {
    if(trend >= 50) {
      trend += random(10, 30);
    } else {
      trend += random(5, 15);
    }
    
    if(trend >= 100) {
      trend = 95;
    }
  }
}

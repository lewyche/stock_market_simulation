class graph {
  ArrayList<Float>y_pos;
  
  float max, min;
  int c_max, c_min;
  
  int dist_between_points;
  int points;
  
  float curr_price = -1;
  
  graph() {
    y_pos = new ArrayList<Float>();
    max = 600;
    min = 0;
    dist_between_points = 30;
    points = 24;
  }
  
  void clear_graph() {
    y_pos.clear();
  }
  
  void draw_lines(company c) {
    PVector prev_point = new PVector(0, 300);
    for(int i = 0; i < y_pos.size(); ++i) {
      float new_x = (i) * dist_between_points;
      float new_y = y_pos.get(i);
      
      if(i != 0) {
        //if market goes up, turn line red
        if(y_pos.get(i) <= y_pos.get(i - 1)) {
          stroke(255,0,0);
        } else { //else turn line green
          stroke(0,255,0);

        }
      }
      
      line(prev_point.x, prev_point.y, new_x, new_y);
      
      prev_point = new PVector(new_x, new_y);
    }

  }
  
  void add_point(float price) {
    push_point(translate_price_to_point(price));
  }
  
  float translate_price_to_point(float price) {
    float p1 = int(c_max - price);
    float p2 = int(price - c_min);
    
    float ratio;
    if(p1 > p2) {
      ratio = p2/p1;
    } else if(p1 < p2) {
      ratio = p1/p2;
    } else {
      ratio = 0.5;
    }
    
    println("Price:" + str(price));
    
    return (max * ratio);
  }
  
  //add point to y_pos, which may need to shifted
  void push_point(float point) {
    if(y_pos.size() >= points) {
      for(int i = 0; i < y_pos.size() - 1; ++i) {
        y_pos.set(i, y_pos.get(i + 1));
      }
      y_pos.set(y_pos.size() - 1, point);
    } else {
      y_pos.add(point);
    }
  }
  
  void draw_graph(company c) {
    c_max = c.max_price;
    c_min = c.min_price;

    fill(255,255,255);
    text(c.name + "\n" + c.ticker + "\n" + str(c.price) + " " + "", 530, 30);
    text("Holdings: " + str(c.holdings), 530, 100);
    strokeWeight(2);

    
    //when price has changed
    if(curr_price != c.price) {
      add_point(c.price);
    }
    
    curr_price = c.price;
     
    draw_lines(c);
    
  }
  
  
}

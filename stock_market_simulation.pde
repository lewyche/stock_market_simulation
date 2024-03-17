int market_delay_quarter_seconds = 4;  //decreasing this number may cause the market to become inaccurate

company_manager companies;
graph g;
user u;

company curr_comp;

void setup() {
  size(700, 700);
  companies = new company_manager(market_delay_quarter_seconds);
  g = new graph();
  u = new user(5000);
  
  curr_comp = companies.get(2);
  g.clear_graph();
}

void draw() {
  background(0,0,0);
  companies.update_companies();

  g.draw_graph(curr_comp);
  u.update();
}

void keyPressed() {
  //switching companies
  if(key >= '0' && key <= '9') {
    //print(int(key));
    curr_comp = companies.get(int(key)-48); //because key returns 49 when pressed 1, 50 when pressed 2 and so on
    g.clear_graph();
  }
  
  //buying and selling
  if(key == 'k') {
    u.buy(curr_comp); 
  }
  
  if(key == 'l') {
    u.sell(curr_comp);
  }
}

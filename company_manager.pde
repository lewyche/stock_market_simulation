//wrapper for ArrayList
class company_manager {
  
  ArrayList<company> companies;
  
  int market_delay_quarter_seconds;
  boolean timer_started = false;
  int start_time = -1;
  
  company_manager(int m) {
    companies = new ArrayList<company>();
    companies.add(new company("Royal Bank of Delaware", "RBD", 10, 400, 50));
    companies.add(new company("StopGames Corp", "STOP", 25, 100, 5));
    companies.add(new company("UltraGraffix", "ULT", 5, 400, 200));
    companies.add(new company("IHeartGambling", "IGAM", 250, 1000, 1));
    companies.add(new company("BigBombs Milcorp", "BBM", 10, 400, 250));
    companies.add(new company("Simply Oil", "OIL", 5, 250, 100));
    companies.add(new company("OmniSoft Inc.", "OWN", 10, 400, 50));
    companies.add(new company("Stratton Oakmont Inc.", "OAK", 10, 400, 50));
    companies.add(new company("Democratic People's Republic\nof North Korea Semiconductor\nManufacturing Company Ltd.", "DRPK", 10, 400, 50));
    companies.add(new company("RedRock", "BUY", 50, 1000, 500));
    market_delay_quarter_seconds = m;
  }
  
  company get(int i) {
    return companies.get(i);
  }
  
  void calc_all() {
    for(int i = 0; i < companies.size(); ++i) {
      companies.get(i).calc_next_price();
    }
  }
  
  //debug
  void print_all() {
    for(int i = 0; i < companies.size(); ++i) {
      companies.get(i).print_price();
    }
    println("-----------------------------------------------");
  }
  
  //change color of the text depending on if it went up or down
  void fill_based_on_last_direction(company c) {
    if(c.last_direction) {
      fill(0,255,0);
    } else {
      fill(255,0,0);
    }
  }
  
  //displaying company prices at the bottom of the screen
  void display_all() {
    int y = 650;
    text("PRESS NUMBERS 0-9 TO CHANGE COMPANIES, K TO BUY, L TO SELL", 10, y-20);
    for(int i = 0; i < companies.size() - 5; ++i) {
      fill_based_on_last_direction(companies.get(i));
      text("NUM:" + str(i) + " " + companies.get(i).get_data(), i * 140 + 10, y);
    }
    y = 670;
    for(int i = 5; i < companies.size(); ++i) {
      fill_based_on_last_direction(companies.get(i));
      text("NUM:" + str(i) + " " + companies.get(i).get_data(), (i-5) * 140 + 10, y);
    }
  }
  
  void update_companies() {
    
    if(!timer_started) {
      
      timer_started = true;
      start_time = millis();
      calc_all();
      
    } else {
      if((millis() - start_time)/250 == market_delay_quarter_seconds) {  //wait for market_delay_quarter_seconds
        timer_started = false;
        start_time = -1;
      }
      display_all();
    }
  }
}

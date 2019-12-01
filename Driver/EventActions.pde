// Button and input field event actions. Each function corresponds to a button action. The controlEvent function
// corresponds to a user selected value from a drop down list. 

import controlP5.*;

// Changes to the home screen. 
void home(){
  clearInputFields();
  w.resetElements();
  menu_choice = 0;
  w.init_main_menu();
}

// Sends a move instruction to move the PS. Can only use in manual mode, button not visible otherwise. 
void move(){
 String instruction = get_instruction("servo angle input fields", "PS_moveSystem");
 println(instruction);
 w.println_message_box("Sending: " + instruction);
 send_instruction(instruction, ps.get_serial_port());
}

// Sets the ports for the LIS and PS. Both systems cannot connect to the same port. 
void ports(){ 
 int lis_index = lis.get_port_index();
 if(lis_index == ps.get_port_index()){
     if(!(lis_index == 0)){
       String error_text = "Can't connect both systems to one port";
       println(error_text);
       w.println_message_box("Error: " + error_text);
       return;
     }
  }else{
       String lis_port = "LIS Port: " + lis.get_port();
       String ps_port = "PS Port: " + ps.get_port();
       w.println_message_box(lis_port);
       w.println_message_box(ps_port);
  }
  
  String lis_port_status = lis.connect_serial_port(this);
  String ps_port_status = ps.connect_serial_port(this);
  w.println_message_box(lis_port_status);
  w.println_message_box(ps_port_status);
  println(lis_port_status);
  println(ps_port_status);
}

// Sets the pins for the LIS and PS. All pins must be unique. 
void pins(){
 String instruction1 = get_instruction("ps pin input fields", "ps_setPins");
 String instruction2 = get_instruction("lis pin input fields", "lis_setPins");
 
 w.println_message_box("PINS INSTRUCTION NOT FINISHED");
}

// Changes to the options screen.
void options(){ 
  clearInputFields();
  mainTemplate(1);
  w.showElements("pins");
  w.showElements("ports");
  w.showElements("ps pins");
  w.showElements("lis pins");
  w.close_port_drop_downs();  
}

// Toggles auto mode.
void auto(){
  String auto_text = "Auto mode activated";
  println(auto_text);
  w.println_message_box(auto_text);
  lis.set_auto_flag(true);
  w.hideElements("move");
  w.hideElements("manual move");
}

// Toggles manual mode. 
void manual(){  
  String manual_text = "Manual mode activated"; 
  println(manual_text);
  w.println_message_box(manual_text);
  lis.set_auto_flag(false);
  w.showElements("move");
  w.showElements("manual move");
}

// Helper function, home screen template. 
void mainTemplate(int screen){
  w.resetElements();
  w.showElements("home");
  menu_choice = screen;
}

/***** Dropdown List Control Function *****/

// Function allows the ability access each event. In this case we select a port from the 
// dropdownlist and connect to it
void controlEvent(ControlEvent theEvent) {

  // Sets user selected port to be connected
  if(theEvent.getName().equals("port 1")){
    int index = int(theEvent.getController().getValue());
     // set port_connected when you make connection to that serial port
     if(!lis.get_port_connected()){
        lis.set_port(w.getItemDropDownList(w.available_ports1, index), index);
     }
  }
  
   if(theEvent.getName().equals("port 2")){
    int index = int(theEvent.getController().getValue());
     // set port_connected when you make connection to that serial port
     if(!ps.get_port_connected()){
        ps.set_port(w.getItemDropDownList(w.available_ports2, index), index);
     }
  }
}

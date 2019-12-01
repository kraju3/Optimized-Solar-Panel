// This is the user interface for the Solar Panel System. The user can control the Positioning System (PS) either
// manually, by entering servo angle measures, or automatically, by using the Adjustment System (AS). The AS 
// determines how to reposition the Solar Panel System so the solar panel is facing the highest light intensity. 
// Essentially, the AS is constantly repositioning the Light Intensity System (LIS) so the central light sensor 
// always has the highest light intensity.
//
// The GUI communciates with the PS and the LIS via serial communications. The GUI will react when it receives 
// serial input. The serial input will be sent to the instruction interpreter where it will decide what to do. 
// The GUI receives an update of the light intensity values from the LIS at a continous rate. If the GUI is set
// to auto, the AS will send servo adjustment instructions to the PS based upon the light intensities sent from 
// the LIS.  



import java.util.*; 
import processing.serial.*;

String empty_entry = "--------------------";
int ERROR_VAL = -9999;

ArrayList <PFont> fonts;
GUI_Settings gui;
Light_Intensity_System lis;
Position_System ps;
Adjustment_System as; 
Widgets w;
int menu_choice = 0;

// Sets up the font, each system and the GUI. 
void setup(){
  fonts = new ArrayList<PFont>();
  fonts.add(createFont("Liberation Sans bold", 20));  // font for buttons and title
  fonts.add(createFont("Liberation Sans bold", 15));  // font for headings
  fonts.add(createFont("Liberation Sans bold", 13));  // font for text
  fonts.add(createFont("Liberation Sans bold", 10));  // font for button text
  
  lis = new Light_Intensity_System();
  ps = new Position_System();
  as = new Adjustment_System(lis, ps);
  gui = new GUI_Settings(ps, lis);
  w = new Widgets(this);  
  w.init_main_menu();
}

// Displays the screens onto the GUI.
void draw(){
  if(menu_choice == 0){
    gui.main_screen();
  }else if(menu_choice == 1){
    gui.options_screen();
  }
}

// When activated, automatically adjusts the PS to an optimal position for the LIS. The user may 
// toggle between manual and auto mode. Manual mode allows the user to enter servo each servo
// angle measure. When in auto mode, the AS will calculate adjustment angles which will be sent 
// as an instruction to the PS
void auto_mode(){
   /*String current_high_sensor = lis.calculate_highest_intensity_sensor();
   if(current_high_sensor.equals(lis.get_previous_high_sensor() ) == false){
     int adjustment_angles[] = as.calculate_adjustment_angles(current_high_sensor);      
     String new_instruction = make_instruction("PS_moveSystem", adjustment_angles);
     ps.set_servo_angles(adjustment_angles);
     println(new_instruction);
     send_instruction(new_instruction, ps.get_serial_port()); 
     lis.set_previous_high_sensor(current_high_sensor);
   }*/
     int adjustment_angles[] = as.calculate_adjustment_angles();      
     String new_instruction = make_instruction("PS_moveSystem", adjustment_angles);
     ps.set_servo_angles(adjustment_angles);
     println(new_instruction);
     send_instruction(new_instruction, ps.get_serial_port()); 
     delay(2000);
}

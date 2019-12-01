                                                                                                              // GUI version of the Position System (PS). Keeps track of the pins and angle measures. Contains a 
// serial port to communicate with the Arduino PS. 
//
// Each array that pertain to the PS will have a specific ordering
// [0]arm, [1]base



class Position_System{
   public  int num_servos = 2;
   private int servo_pins[] = {7,8};   // [0]a, [1]b                                         
   private int servo_angles[] = {0,0}; 
  
   private Serial serial_port;
   public int port_index = 0;
   private String port = "not set";
   private boolean port_connected = false;
   
   Position_System(){
     int vals[] = {30, 60};
     set_servo_angles(vals); 
   }
   
   // Returns the serial port to communicate with the Arduino PS.
   Serial get_serial_port(){ return serial_port; } 
   // Tries to connect the serial port to port. If it fails it will print an error message. 
   String connect_serial_port(PApplet parent){
   String status;
    try{ // Try to connect to port portConnection 
      this.serial_port = new Serial(parent, port, 9600); 
      status = "[PS] Connected to port: " + port;
    } 
    catch( Exception e){ // If failed, display error message
      status = "[PS] Error connecting to port: " + port; 
    }
    return status;
  }
   
   // Sets the servo angle measures.
   void set_servo_angles(int adjustment_angles[]){ for(int i=0; i<num_servos; i++){ servo_angles[i] = adjustment_angles[i]; } }   
   // Returns the servo angle measures.
   int[] get_servo_angles(){ return servo_angles; }

   // Sets the servo pins.
   void set_servo_pins(int pins[]){for(int i=0; i<num_servos; i++){ servo_pins[i] = pins[i]; } }
   // Returns the servo pins.
   int[] get_servo_pins(){ return servo_pins; }
   
   // Sets the port connected flag. Which signifies if a port has successfully been connected to or not. 
   void set_port_connected(boolean bool){ port_connected = bool; }
   // Returns the port connected flag.
   boolean get_port_connected(){ return port_connected; }
   
   // Sets the port address and port index, which corresponds to the drop down port selection list.
   void set_port(String _port, int index){ port = _port; port_index = index;}
   // Returns the name of the port 
   String get_port(){ return port; }
   // Returns the index of the port in the drop down port selection list.
   int get_port_index(){ return port_index; }    
   
   void print_angles(){
     println("PS Angle Measures");
     println("Arm: " + servo_angles[0]);
     println("Base: " + servo_angles[1]);
   }
}

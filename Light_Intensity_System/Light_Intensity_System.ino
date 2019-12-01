#include <TimedAction.h>

// The Light Intensity System (LIS) is the detection method for the Solar Panel System to 
// determine where the highest intensity of light is. The LIS is constantly updating the 
// processing GUI via serial communication. This gives a live stream of data. The LIS 
// communicates with the GUI by sending instructions. Each instruction has an instructionID 
// followed by data members. The instructionID and each data member is seperated by a single
// white space " ". Since the LIS's only purpose is to send live data, it will not have any 
// incoming instructions nor will it have an instruction interpreter. 
//
// Note: The front of the LIS is indicated by an F written on the breadboard. 

#include "LIS.h"

Light_Intensity_System lis;

const int MSG_DELAY = 50;

// This is where the LIS is constantly sending live data. This is a timed action, which means
// it will execute update_function every update_time microseconds. update_function sends an
// instruction via serial communication that contains the most recent light intensity readings. 
const int update_time = 1000;
void update_function(){ Serial.println(lis.get_lightIntensities_instruction()); }
TimedAction update_action = TimedAction(update_time, update_function);

// Setting the pins of the LIS and the baud rate for serial communication.
void setup() {
  Serial.begin(9600);
  int pins[] = {A0,A1,A2,A3,A4};
  lis.set_pins(pins);
}

// Loop is constantly checking if it is time to execute the update_action. 
void loop() { update_action.check(); }

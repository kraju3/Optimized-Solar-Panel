// This system, the Adjustment System (AS) controls the adjustments made to the Positioning System. This 
// system is used when the program is set to auto mode. The AS returns the adjustment angles to be sent
// as an instruction. 
// 
// Note: The lower the light intensity value the higher the light intensity.



class Adjustment_System{
  private Light_Intensity_System lis;
  private Position_System ps;
  
  private int verticalServo = 90;
  private int horizontalServo = 90;
  
  private int horizontalMax = 160;
  private int horizontalMin = 30;
  
  private int verticalMax = 140;
  private int verticalMin = 70;
  
  
  
  Adjustment_System(){ }
  
  Adjustment_System(Light_Intensity_System _lis, Position_System _ps){
    lis = _lis;
    ps = _ps;
  }
  

  // Moves to a specified position based on the name of the sensor with the highest light intensity.
  // The name is calculated using the 'calculate_highest_intensity_sensor' function from the GUI LIS. 
  int[] calculate_adjustment_angles(String highest_sensor){
     int adjustment_angles[] = {0,0};
     if(highest_sensor == "central"){ 
       adjustment_angles[0] = 90;
       adjustment_angles[1] = 90;
     } 
     else if(highest_sensor == "front"){ 
       adjustment_angles[0] = 45;
       adjustment_angles[1] = 90;
     }
     else if(highest_sensor == "back"){ 
       adjustment_angles[0] = 135;
       adjustment_angles[1] = 90;
     }
     else if(highest_sensor == "left"){ 
       adjustment_angles[0] = 45;
       adjustment_angles[1] = 0;
     }
     else if(highest_sensor == "right"){ 
       adjustment_angles[0] = 45;
       adjustment_angles[1] = 180;
     }
     return adjustment_angles;
   }
//moves to a specified angle incrementally...be aware of slow progress due to the slow changes in the intensities. Also the algorithm is kinda fluky sometimes
int[] calculate_adjustment_angles(){
      int adjustment_angles[] = {0,0};//[0] ia arm , [1] is base
      int intensities[] = lis.get_intensities(); // return the intensities currently recorded
      int percentChange = 30;
     //get servo measurements, index 0 is arm, base =2, arm used for vertical and base used for horizontal movement
     int angles[] = ps.get_servo_angles();
  
     
     int right = intensities[4],left = intensities[3],bottom = intensities[2],front = intensities[1];
     int vertical = abs(front - bottom)/2; //vertical avg
     int horizontal = abs(left - right)/2;//horizontal avg
     
     int vdiff = abs(front - bottom);
     int hdiff = abs(left - right);
     
  if (vertical > horizontal || vdiff>percentChange){
      if (front < bottom)
        {
          verticalServo = verticalServo+5;
          if (verticalServo > verticalMax)
           {
              verticalServo = verticalMax;
           }
        }
      else if (front > bottom)
      {
        verticalServo= verticalServo-5;
        if (verticalServo < verticalMin)
          {
             verticalServo = verticalMin;
          }
      } 
      else if (front==bottom){
        //do nothing
        return angles;
      
      }
    
    // [0]arm, [1]base
   adjustment_angles[0] = verticalServo;
   adjustment_angles[1] = horizontalServo;
   return adjustment_angles;
  }

  if (horizontal>vertical || hdiff>percentChange) //check if there is a huge difference in the intensities
  {
     if (left < right)
      {
        horizontalServo = horizontalServo-5;
        if (horizontalServo < horizontalMin )
          {
            horizontalServo = horizontalMin;
          }
      }
     else if (right < left)
      {
        horizontalServo = horizontalServo+5;
        if (horizontalServo > horizontalMax)
         {
           horizontalServo = horizontalMax;
         }
      }
     else if (left == right)
      {
          return angles;
      }
      adjustment_angles[0]= verticalServo;
      adjustment_angles[1] = horizontalServo;
      return adjustment_angles;
  }
  
  return angles;
 }//end of function


}

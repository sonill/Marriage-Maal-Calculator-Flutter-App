library globals;

const int blueColor = 0xff0447EED;
const int greenColor = 0xff27AE60;
const double mainContainerPadding = 15.0;

int getColor(String color){

  if(color == 'green' ){
    return greenColor;
  }
  else {
    return blueColor;
  }

}
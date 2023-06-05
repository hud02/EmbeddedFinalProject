sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

unsigned int j;
unsigned int i;
char temp_read[16];
unsigned int result;
float voltage;
unsigned int temp;
unsigned char position;
void ATD_init(void);
unsigned int ATD_read(void);
void myDelay(unsigned int);
void intial();
unsigned int on;



void main() {
TRISC= 0X00; //RED LIGHTS ARE OUTPUT
TRISA= 0X04; //GREEN LIGHTS ARE OUTPUT
PORTA=0X02; //GREEN LIGHTS ARE OFF
TRISE= 0X01; //PUSH BUTTON IS INPUT
PORTE=0X01; //PUSH BUTTON NOT PRESSED (PULL-UP RESISTOR)
intial();  //CALLING INITIAL FUNCTION
while(1){
PORTC=0X02; //RED LIGHTS ARE OFF (BECAUSE THE RELAY IS ACTIVE LOW)
PORTA=0X02; //GREEN LIGHTS ARE OFF (BECAUSE THE RELAY IS ACTIVE LOW)
lcd_init();  //INITIALIZE LCD
lcd_cmd(_lcd_clear); //CLEAR DISPLAY
lcd_cmd(_LCD_CURSOR_OFF); // CURSOR OFF
lcd_out(1,1,"HELLO"); //WRITING TEXT IN FIRST ROW
myDelay(100000); //DELAY FUNCTION TO WASTE TIME
lcd_cmd(_lcd_clear);
lcd_cmd(_LCD_CURSOR_OFF);
if(PORTE=0X01){ //IF THE PUSH BUTTON IS PRESSED
PORTA=0X00; //GREEN LIGHTS ARE ON
lcd_cmd(_lcd_clear);
lcd_cmd(_LCD_CURSOR_OFF);
lcd_out(1,1,"DOOR BELL"); // WRITE ON THE LCD "DOOR BELL"
myDelay(1000);
PORTA=0X02; //GREEN LIGHTS ARE OFF
}
ATD_init(); //CALLING FUNCTION ATD_init
ATD_read(); //CALLING FUNCTION ATD_read
myDelay(1000);
result = ATD_read(); //STORING THE READING VALUE FROM THE TEMP SENSOR ON THE INTEGER RESULT
voltage = result * 4.88; //VOLTAGE=READING OF THE ATD PIN * STEPSIZE
temp = voltage / 10.0;   //CONVERTING THE VOLTAGE TO TEMPERATURE
IntToStr(temp,temp_read); //CONVERTING INT TEMP TO STRING TEMP_READ??
ltrim(temp_read); //TRIMING UNUSED EXTRA DIGITS
lcd_out(1,1,"temperature =");
lcd_out(1,15,temp_read);
myDelay(1000);
on= PORTA|0x04; //ON=VALUE OF PORTA A IF THE FLAME SENSOR IS ON
if(temp>10 | on){ //IF THE TEMP IS MORE THAN 30 AND THE FLAME SENSOR IS ON THEN THERE IS A FIRE AT THE HOUSE
PORTC=0X00; //RED LIGHTS ARE ON
lcd_cmd(_lcd_clear);
lcd_cmd(_LCD_CURSOR_OFF);
lcd_out(1,1,"FIRE!"); //FIRE WORD IS WRITTEN ON THE LCD
PORTB=0x02; //DC MOTOR IS ON TO OPEN THE DOOR
myDelay(1000);
PORTB=0x00; //DC MOTORE IS OFF
PORTC=0X02; //RED LIGHTS ARE OFF
}


}
}


void myDelay(unsigned int x){ //MYDELAY FUNCTION TO WASTE TIME
for(i = 0; i <=x*10 ; i++);
        for (j = 0; j<=x*10 ; j++);
}

void ATD_init(void){
ADCON0 = 0X41;  //USING THE REGISTER ADCON0 WE POWERED UP THE A/D CONVERTER MODULE AND   powerup AND FOSC/16
ADCON1 = 0XCE;  //ALL PINS ARE DIGITAL EXCEPT A0 IS ANALOG AND THE RESULT IS STORED RIGHT JUSTIFIED
TRISA = 0X01; //A0 IS INPUT
}
unsigned int ATD_read(void){
ADCON0 = ADCON0 | 0X04; //A/D CONVERSION NOT IN PROGRESS
while(ADCON0&0X04); //WHILE THE A/D CONVERSION  IS GOING
return (ADRESH<<8) | ADRESL; //SHIFT 2-BITS BY 8 LOCATIONS
}

void intial(){
TRISB=0x00; //DC MOTOR IS INPUT
PORTB=0x00; //DC MOTOR IS OFF
}
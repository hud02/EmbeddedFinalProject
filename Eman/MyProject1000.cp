#line 1 "C:/Users/20190293/Desktop/Eman/MyProject1000.c"
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
TRISC= 0X00;
TRISA= 0X04;
PORTA=0X02;
TRISE= 0X01;
PORTE=0X01;
intial();
while(1){
PORTC=0X02;
PORTA=0X02;
lcd_init();
lcd_cmd(_lcd_clear);
lcd_cmd(_LCD_CURSOR_OFF);
lcd_out(1,1,"HELLO");
myDelay(100000);
lcd_cmd(_lcd_clear);
lcd_cmd(_LCD_CURSOR_OFF);
if(PORTE=0X01){
PORTA=0X00;
lcd_cmd(_lcd_clear);
lcd_cmd(_LCD_CURSOR_OFF);
lcd_out(1,1,"DOOR BELL");
myDelay(1000);
PORTA=0X02;
}
ATD_init();
ATD_read();
myDelay(1000);
result = ATD_read();
voltage = result * 4.88;
temp = voltage / 10.0;
IntToStr(temp,temp_read);
ltrim(temp_read);
lcd_out(1,1,"temperature =");
lcd_out(1,15,temp_read);
myDelay(1000);
on= PORTA|0x04;
if(temp>10 | on){
PORTC=0X00;
lcd_cmd(_lcd_clear);
lcd_cmd(_LCD_CURSOR_OFF);
lcd_out(1,1,"FIRE!");
PORTB=0x02;
myDelay(1000);
PORTB=0x00;
PORTC=0X02;
}


}
}


void myDelay(unsigned int x){
for(i = 0; i <=x*10 ; i++);
 for (j = 0; j<=x*10 ; j++);
}

void ATD_init(void){
ADCON0 = 0X41;
ADCON1 = 0XCE;
TRISA = 0X01;
}
unsigned int ATD_read(void){
ADCON0 = ADCON0 | 0X04;
while(ADCON0&0X04);
return (ADRESH<<8) | ADRESL;
}

void intial(){
TRISB=0x00;
PORTB=0x00;
}


_main:

;MyProject1000.c,30 :: 		void main() {
;MyProject1000.c,31 :: 		TRISC= 0X00; //RED LIGHTS ARE OUTPUT
	CLRF       TRISC+0
;MyProject1000.c,32 :: 		TRISA= 0X04; //GREEN LIGHTS ARE OUTPUT
	MOVLW      4
	MOVWF      TRISA+0
;MyProject1000.c,33 :: 		PORTA=0X02; //GREEN LIGHTS ARE OFF
	MOVLW      2
	MOVWF      PORTA+0
;MyProject1000.c,34 :: 		TRISE= 0X01; //PUSH BUTTON IS INPUT
	MOVLW      1
	MOVWF      TRISE+0
;MyProject1000.c,35 :: 		PORTE=0X01; //PUSH BUTTON NOT PRESSED (PULL-UP RESISTOR)
	MOVLW      1
	MOVWF      PORTE+0
;MyProject1000.c,36 :: 		intial();  //CALLING INITIAL FUNCTION
	CALL       _intial+0
;MyProject1000.c,37 :: 		while(1){
L_main0:
;MyProject1000.c,38 :: 		PORTC=0X02; //RED LIGHTS ARE OFF (BECAUSE THE RELAY IS ACTIVE LOW)
	MOVLW      2
	MOVWF      PORTC+0
;MyProject1000.c,39 :: 		PORTA=0X02; //GREEN LIGHTS ARE OFF (BECAUSE THE RELAY IS ACTIVE LOW)
	MOVLW      2
	MOVWF      PORTA+0
;MyProject1000.c,40 :: 		lcd_init();  //INITIALIZE LCD
	CALL       _Lcd_Init+0
;MyProject1000.c,41 :: 		lcd_cmd(_lcd_clear); //CLEAR DISPLAY
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject1000.c,42 :: 		lcd_cmd(_LCD_CURSOR_OFF); // CURSOR OFF
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject1000.c,43 :: 		lcd_out(1,1,"HELLO"); //WRITING TEXT IN FIRST ROW
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject1000+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject1000.c,44 :: 		myDelay(100000); //DELAY FUNCTION TO WASTE TIME
	MOVLW      160
	MOVWF      FARG_myDelay+0
	MOVLW      134
	MOVWF      FARG_myDelay+1
	CALL       _myDelay+0
;MyProject1000.c,45 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject1000.c,46 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject1000.c,47 :: 		if(PORTE=0X01){ //IF THE PUSH BUTTON IS PRESSED
	MOVLW      1
	MOVWF      PORTE+0
	MOVF       PORTE+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
;MyProject1000.c,48 :: 		PORTA=0X00; //GREEN LIGHTS ARE ON
	CLRF       PORTA+0
;MyProject1000.c,49 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject1000.c,50 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject1000.c,51 :: 		lcd_out(1,1,"DOOR BELL"); // WRITE ON THE LCD "DOOR BELL"
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject1000+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject1000.c,52 :: 		myDelay(1000);
	MOVLW      232
	MOVWF      FARG_myDelay+0
	MOVLW      3
	MOVWF      FARG_myDelay+1
	CALL       _myDelay+0
;MyProject1000.c,53 :: 		PORTA=0X02; //GREEN LIGHTS ARE OFF
	MOVLW      2
	MOVWF      PORTA+0
;MyProject1000.c,54 :: 		}
L_main2:
;MyProject1000.c,55 :: 		ATD_init(); //CALLING FUNCTION ATD_init
	CALL       _ATD_init+0
;MyProject1000.c,56 :: 		ATD_read(); //CALLING FUNCTION ATD_read
	CALL       _ATD_read+0
;MyProject1000.c,57 :: 		myDelay(1000);
	MOVLW      232
	MOVWF      FARG_myDelay+0
	MOVLW      3
	MOVWF      FARG_myDelay+1
	CALL       _myDelay+0
;MyProject1000.c,58 :: 		result = ATD_read(); //STORING THE READING VALUE FROM THE TEMP SENSOR ON THE INTEGER RESULT
	CALL       _ATD_read+0
	MOVF       R0+0, 0
	MOVWF      _result+0
	MOVF       R0+1, 0
	MOVWF      _result+1
;MyProject1000.c,59 :: 		voltage = result * 4.88; //VOLTAGE=READING OF THE ATD PIN * STEPSIZE
	CALL       _word2double+0
	MOVLW      246
	MOVWF      R4+0
	MOVLW      40
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _voltage+0
	MOVF       R0+1, 0
	MOVWF      _voltage+1
	MOVF       R0+2, 0
	MOVWF      _voltage+2
	MOVF       R0+3, 0
	MOVWF      _voltage+3
;MyProject1000.c,60 :: 		temp = voltage / 10.0;   //CONVERTING THE VOLTAGE TO TEMPERATURE
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      _temp+0
	MOVF       R0+1, 0
	MOVWF      _temp+1
;MyProject1000.c,61 :: 		IntToStr(temp,temp_read); //CONVERTING INT TEMP TO STRING TEMP_READ??
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _temp_read+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject1000.c,62 :: 		ltrim(temp_read); //TRIMING UNUSED EXTRA DIGITS
	MOVLW      _temp_read+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProject1000.c,63 :: 		lcd_out(1,1,"temperature =");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject1000+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject1000.c,64 :: 		lcd_out(1,15,temp_read);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _temp_read+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject1000.c,65 :: 		myDelay(1000);
	MOVLW      232
	MOVWF      FARG_myDelay+0
	MOVLW      3
	MOVWF      FARG_myDelay+1
	CALL       _myDelay+0
;MyProject1000.c,66 :: 		on= PORTA|0x04; //ON=VALUE OF PORTA A IF THE FLAME SENSOR IS ON
	MOVLW      4
	IORWF      PORTA+0, 0
	MOVWF      _on+0
	CLRF       _on+1
	MOVLW      0
	IORWF      _on+1, 1
	MOVLW      0
	MOVWF      _on+1
;MyProject1000.c,67 :: 		if(temp>10 | on){ //IF THE TEMP IS MORE THAN 30 AND THE FLAME SENSOR IS ON THEN THERE IS A FIRE AT THE HOUSE
	MOVF       _temp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main13
	MOVF       _temp+0, 0
	SUBLW      10
L__main13:
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       _on+0, 0
	IORWF      R0+0, 1
	MOVF       _on+1, 0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;MyProject1000.c,68 :: 		PORTC=0X00; //RED LIGHTS ARE ON
	CLRF       PORTC+0
;MyProject1000.c,69 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject1000.c,70 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject1000.c,71 :: 		lcd_out(1,1,"FIRE!"); //FIRE WORD IS WRITTEN ON THE LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject1000+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject1000.c,72 :: 		PORTB=0x02; //DC MOTOR IS ON TO OPEN THE DOOR
	MOVLW      2
	MOVWF      PORTB+0
;MyProject1000.c,73 :: 		myDelay(1000);
	MOVLW      232
	MOVWF      FARG_myDelay+0
	MOVLW      3
	MOVWF      FARG_myDelay+1
	CALL       _myDelay+0
;MyProject1000.c,74 :: 		PORTB=0x00; //DC MOTORE IS OFF
	CLRF       PORTB+0
;MyProject1000.c,75 :: 		PORTC=0X02; //RED LIGHTS ARE OFF
	MOVLW      2
	MOVWF      PORTC+0
;MyProject1000.c,76 :: 		}
L_main3:
;MyProject1000.c,79 :: 		}
	GOTO       L_main0
;MyProject1000.c,80 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_myDelay:

;MyProject1000.c,83 :: 		void myDelay(unsigned int x){ //MYDELAY FUNCTION TO WASTE TIME
;MyProject1000.c,84 :: 		for(i = 0; i <=x*10 ; i++);
	CLRF       _i+0
	CLRF       _i+1
L_myDelay4:
	MOVF       FARG_myDelay_x+0, 0
	MOVWF      R0+0
	MOVF       FARG_myDelay_x+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _i+1, 0
	SUBWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__myDelay15
	MOVF       _i+0, 0
	SUBWF      R0+0, 0
L__myDelay15:
	BTFSS      STATUS+0, 0
	GOTO       L_myDelay5
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
	GOTO       L_myDelay4
L_myDelay5:
;MyProject1000.c,85 :: 		for (j = 0; j<=x*10 ; j++);
	CLRF       _j+0
	CLRF       _j+1
L_myDelay7:
	MOVF       FARG_myDelay_x+0, 0
	MOVWF      R0+0
	MOVF       FARG_myDelay_x+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _j+1, 0
	SUBWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__myDelay16
	MOVF       _j+0, 0
	SUBWF      R0+0, 0
L__myDelay16:
	BTFSS      STATUS+0, 0
	GOTO       L_myDelay8
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
	GOTO       L_myDelay7
L_myDelay8:
;MyProject1000.c,86 :: 		}
L_end_myDelay:
	RETURN
; end of _myDelay

_ATD_init:

;MyProject1000.c,88 :: 		void ATD_init(void){
;MyProject1000.c,89 :: 		ADCON0 = 0X41;  //USING THE REGISTER ADCON0 WE POWERED UP THE A/D CONVERTER MODULE AND   powerup AND FOSC/16
	MOVLW      65
	MOVWF      ADCON0+0
;MyProject1000.c,90 :: 		ADCON1 = 0XCE;  //ALL PINS ARE DIGITAL EXCEPT A0 IS ANALOG AND THE RESULT IS STORED RIGHT JUSTIFIED
	MOVLW      206
	MOVWF      ADCON1+0
;MyProject1000.c,91 :: 		TRISA = 0X01; //A0 IS INPUT
	MOVLW      1
	MOVWF      TRISA+0
;MyProject1000.c,92 :: 		}
L_end_ATD_init:
	RETURN
; end of _ATD_init

_ATD_read:

;MyProject1000.c,93 :: 		unsigned int ATD_read(void){
;MyProject1000.c,94 :: 		ADCON0 = ADCON0 | 0X04; //A/D CONVERSION NOT IN PROGRESS
	BSF        ADCON0+0, 2
;MyProject1000.c,95 :: 		while(ADCON0&0X04); //WHILE THE A/D CONVERSION  IS GOING
L_ATD_read10:
	BTFSS      ADCON0+0, 2
	GOTO       L_ATD_read11
	GOTO       L_ATD_read10
L_ATD_read11:
;MyProject1000.c,96 :: 		return (ADRESH<<8) | ADRESL; //SHIFT 2-BITS BY 8 LOCATIONS
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;MyProject1000.c,97 :: 		}
L_end_ATD_read:
	RETURN
; end of _ATD_read

_intial:

;MyProject1000.c,99 :: 		void intial(){
;MyProject1000.c,100 :: 		TRISB=0x00; //DC MOTOR IS INPUT
	CLRF       TRISB+0
;MyProject1000.c,101 :: 		PORTB=0x00; //DC MOTOR IS OFF
	CLRF       PORTB+0
;MyProject1000.c,102 :: 		}
L_end_intial:
	RETURN
; end of _intial

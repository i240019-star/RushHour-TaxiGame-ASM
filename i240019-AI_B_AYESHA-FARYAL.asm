INCLUDE Irvine32.inc
EXTERN Beep@8:PROC           
.stack 4000h
.data
;=================================SHAPES============================================================
in_game dword 0
filename BYTE "rush_hour.txt",0
buffer  BYTE 100 DUP(0)
score_array dword 11 Dup(0)
fileHandle DWORD ?
line BYTE 13,10,0
score_temp dword 0
car_body1 byte "/__\",0
car_body2 byte "0  0",0
person_body1 byte "_O_|",0
person_body2 byte "/ \|",0
destination_body1 byte "/--\",0
destination_body2 byte "|__|",0
collectible_body1 byte "/..\",0
collectible_body2 byte "|$$]",0
pickup_count dword 0
drop_count dword 0
;================================leader board variables=============================================
leaderBoardTitle byte "******LEADER BOARD******",0
p1 byte "Player 1  : ",0
p2 byte "Player 2  : ",0
p3 byte "Player 3  : ",0
p4 byte "Player 4  : ",0
p5 byte "Player 5  : ",0
p6 byte "Player 6  : ",0
p7 byte "Player 7  : ",0
p8 byte "Player 8  : ",0
p9 byte  "Player 9  : ",0
p10 byte "Player 10 : ",0
store byte " S T O R E",0
school byte " S C H O O L",0
bank byte " B A N K",0
x byte 0
y byte 0
ending byte "<^^^END GAME^^^>",0
;==================================read instruction page============================================
instructionTitle BYTE "****READ INSTRUCTION****", 0
instruction1 BYTE "         USE ARROW KEYS TO MOVE PLAYER CAR           ", 0
instruction2 BYTE "            PRESS ENTER TO COLLECT ITEMS             ", 0
instruction3 BYTE "         PRESS SPACEBAR TO PICKUP PASSENGER          ", 0
instruction4 BYTE "     PRESS HOME TO DROP PASSENGER AT DESTINATION     ", 0
instruction5 BYTE "               Press ESC TO LEAVE GAME               ", 0
game_back    BYTE "            PRESS K TO LEAVE INSTRUCTIONS            ",0
item_display byte "Items Collected: ",0
collected dword 0
;===============================change difficulty mode page=========================================
speed dword 200000000
fast_speed dword 200000000
medium_speed dword 400000000
slow_speed dword   800000000
easy_msg  BYTE          "      EASY  MODE      ", 0
medium_msg BYTE         "     MEDIUM  MODE     ", 0
hard_msg BYTE           "      HARD  MODE      ", 0
career_mode_msg BYTE    "     CAREER  MODE     ", 0
timer_mode_msg BYTE     "      TIMER MODE      ", 0
endless_mode_msg BYTE   "     ENDLESS MODE     ", 0
;=========================================pick and drop=============================================
target_score dword 30
picked dword 0
dropped dword 0
total_dropped dword 0
score dword 0
score_label byte "SCORE : ",0
time_label byte "TIME: ",0
spacing byte "          ",0
target_display byte "Score target to win this game is :",0
gameTitle BYTE "===HOUR RUSH GAME===", 0
menuTitle BYTE "****MENU****", 0
option1 BYTE "1.START NEW GAME", 0
option2 BYTE "2.CONTINUE THE GAME", 0
option3 BYTE "3.CHANGE DIFFICULTY", 0
option4 BYTE "4.VIEW LEADER BOARD", 0
option5 BYTE "5.READ INSTRUCTIONS", 0
difficulty_title byte "****DIFFICULTY LEVEL****",0
mode_title byte       "   ****GAME MODE****   ",0
end_game byte "   GO TO MAIN MENU    ",0
backheight DWORD 31
backwidth DWORD 130
;===========================================button==================================================
button_color dword 208 ;lightMagenta
button_height dword 2
button_width dword 23
buttonX dword 8
buttonY dword 48
button1X dword 8
button1Y dword 48
button2X dword 11
button2Y dword 48
button3X dword 14
button3Y dword 48
button4X dword 17
button4Y dword 48
button5X dword 20
button5Y dword 48
boundary_color dword 219 
button_highlight_color dword 208
buttonhighlightX dword 8
buttonhighlightY dword 48

nbuttonX dword 10
nbuttonY dword 32
nbutton1X dword 10
nbutton1Y dword 32
nbutton2X dword 13
nbutton2Y dword 32
nbutton3X dword 16
nbutton3Y dword 32
nbuttonhighlightX dword 10
nbuttonhighlightY dword 32
;=======================mode menu or change difficulty menu  variables==============================
drop_target dword 10
start_time dword 0
current_time dword 0
timer dword 100
mode_button_color dword Lightcyan+(yellow*16)
mode_button_highlight_color dword black+(lightcyan*16)
timer_mode dword 0
career_mode dword 0
endless_mode dword 0
easy_mode dword 1
medium_mode dword 0
hard_mode dword 0
;taxi selection page
taxi_title byte       " ****TAXI SELECTION**** ",0
taxi_red byte         " PRESS 1 FOR RED TAXI  ",0
taxi_yellow byte      "PRESS 2 FOR YELLOW TAXI",0
taxi_choice byte      "    YOUR CHOICE (1/2) : ",0
taxi_color dword 0
name_prompt BYTE "ENTER YOUR NAME:", 0
nameBuffer BYTE 50 DUP(0)  
;======================================game start board=============================================
row dword 0
col dword 0
text byte 0
previous_row dword 0
previous_col dword 0
recwidth DWORD 0
recheight DWORD 0
object byte ?
;board
bordercolor DWORD 0
boardwidth DWORD 130
boardheight DWORD 31
temp dword 0
grid byte 5000 dup (' ')
;==========================================car======================================================
carX dword 0
carY dword 0
car1X dword 0
car1Y dword 0
car2X dword 0
car2Y dword 0
car3X dword 0
car3Y dword 0
car4X dword 0
car4Y dword 0
car5X dword 0
car5Y dword 0
car_color dword 0

;=========================================person===================================================
boxes dword 0
ranNum dword 0
person1X dword 0
person1Y dword 0
picked_personX dword 0
picked_personY dword 0
picked_collectibleX dword 0
picked_collectibleY dword 0

.CODE

;********************************RESTART GAME CONDITIONS********************************************

restart_game PROC
;game start variable for new game
mov score , 0
mov timer_mode,0
mov career_mode,0
mov endless_mode,0
mov car_color,0
mov picked , 0
mov dropped , 0
mov start_time , 0
mov current_time ,0
mov row , 0
mov col , 0
mov previous_row , 0
mov previous_col , 0
mov recwidth , 0
mov recheight , 0
;car
mov carX , 0
mov carY , 0
mov car1X , 0
mov car1Y , 0
mov car2X , 0
mov car2Y , 0
mov car3X , 0
mov car3Y , 0
mov car4X , 0
mov car4Y , 0
mov car5X , 0
mov car5Y , 0
;person
mov ranNum , 0
mov person1X , 0
mov person1Y , 0
mov picked_personX , 0
mov picked_personY , 0
mov picked_collectibleX , 0
mov picked_collectibleY , 0
mov collected , 0
mov edi,offset grid
mov ecx,5000
restart_grid:
mov BYTE PTR [edi],' '
inc edi
loop restart_grid

ret
restart_game ENDP

;===============RECTANGLE DRAWING==================

rectangle proc
mov eax,bordercolor
call SetTextColor
mov ecx,recwidth
upper_wall:
mov dh,BYTE PTR row
mov dl,BYTE PTR col
call Gotoxy
mov al,object
call WriteChar
cmp in_game,0
je l1
mov bl,al
;saving  data to grid
    mov eax, row
    mov edx, 130
    imul edx
    add eax, col
    mov grid[eax],bl

l1:
add col,1
loop upper_wall

mov ecx,recheight
right_wall:
mov dh,BYTE PTR row
mov dl,BYTE PTR col
add row,1
call Gotoxy
mov al,object
call WriteChar
mov bl,al
cmp in_game,0
je l2
;save data
    mov eax, row
    mov edx, 130
    imul edx
    add eax, col
    mov grid[eax],bl
l2:
loop right_wall

mov ecx,recwidth
lower_wall:
mov dh,BYTE PTR row
mov dl,BYTE PTR col
sub col,1
call Gotoxy
mov al,object
call WriteChar
mov bl,al
cmp in_game,0
je l3
;saving data to grid
    mov eax, row
    mov edx, 130
    imul edx
    add eax, col
    mov grid[eax],bl
l3:
loop lower_wall

mov ecx,recheight
left_wall:
mov dh, BYTE PTR row
mov dl, BYTE PTR col
sub row,1
call Gotoxy
mov al,object
call WriteChar
mov bl,al
cmp in_game,0
je l4
;saving  data to grid
    mov eax, row
    mov edx, 130
    imul edx
    add eax, col
    mov grid[eax],bl
l4:
loop left_wall
ret
rectangle ENDP

;=========BUTTON HIGHLIGHT DRAW====================

button_boundary PROC
mov eax,button_color
mov bordercolor,eax
mov eax,button_width
mov recwidth,eax
mov eax,button_height
mov recheight,eax
mov eax,buttonX
mov row,eax
mov eax,buttonY
mov col,eax
mov object,'+'
call rectangle
ret
button_boundary ENDP

;=========BUTTON HIGHLIGHT REMOVE==================
remove_button_boundary PROC
mov eax,button_color
mov bordercolor,eax
mov eax,button_width
mov recwidth,eax
mov eax,button_height
mov recheight,eax
mov eax,buttonX
mov row,eax
mov eax,buttonY
mov col,eax
mov object,' '
call rectangle
ret
remove_button_boundary ENDP

;============================================GAME MODE MENU=========================================
game_mode_menu proc
call ClrScr
mov eax,black+(Magenta*16)
call SetTextColor
call ClrScr
mov bordercolor,eax
mov eax,backwidth
mov recwidth,eax
mov eax,backheight
mov recheight,eax
mov row,0
mov col,0
mov object,'*'
call rectangle
;gameTitle
mov bordercolor,lightgray+(magenta*16)
mov recwidth,27
mov recheight,2
mov row,1
mov col,46
mov object,'~'
call rectangle
mov dh,2
mov dl,50
call Gotoxy
mov edx,offset gameTitle
call WriteString

;menuTitle
mov eax,229
mov bordercolor,eax
mov recwidth,25
mov recheight,2
mov row,4
mov col,47
mov object,'='
call rectangle
mov dh,5
mov dl,48
call Gotoxy
mov edx,offset mode_title
call WriteString

mov bordercolor,eax
mov recwidth,60
mov recheight,12
mov row,8
mov col,30
mov object,'*'
call rectangle

;options
mov eax,mode_button_color
mov button_color,eax
mov eax,nbutton1X
mov buttonX,eax
call button_boundary
mov eax,red+white*16
call SetTextColor
mov dh,11
mov dl,49
call Gotoxy
mov edx,offset career_mode_msg
call WriteString

mov eax,mode_button_color
mov button_color,eax
mov eax,nbutton2X
mov buttonX,eax
call button_boundary
mov eax,blue+white*16
call SetTextColor
mov dh,14
mov dl,49
call Gotoxy
mov edx,offset timer_mode_msg
call WriteString

mov eax,mode_button_color
mov button_color,eax
mov eax,nbutton3X
mov buttonX,eax
call button_boundary
mov eax,green+white*16
call SetTextColor
mov dh,17
mov dl,49
call Gotoxy
mov edx,offset endless_mode_msg
call WriteString


mov eax,mode_button_highlight_color
mov button_color,eax
mov eax,nbuttonhighlightX
mov buttonX,eax
call button_boundary

infinite:


call ReadKey     
   
    cmp ah, 72
    je MoveUp_button

    cmp ah, 80
    je MoveDown_button

    cmp al, 0Dh
    je check_mode

     cmp al,'k'
    je back
    cmp al,'K'
    je back

    n:
    mov eax,mode_button_highlight_color
    mov button_color,eax
    mov eax,nbuttonhighlightX
    mov buttonX,eax
    call button_boundary

    mov ecx,500000000
l1:
loop l1
jmp infinite

MoveUp_button:
mov eax,nbuttonhighlightX
mov buttonX,eax
call remove_button_boundary
mov eax,mode_button_color
mov button_color,eax
mov eax,nbuttonhighlightX
mov buttonX,eax
call button_boundary
sub nbuttonhighlightX,3
cmp nbuttonhighlightX,10
jle button_reset1_U
jmp n
button_reset1_U:
mov nbuttonhighlightX,10
jmp n


MoveDown_button:
mov eax,nbuttonhighlightX
mov buttonX,eax
call remove_button_boundary
mov eax,mode_button_color
mov button_color,eax
mov eax,nbuttonhighlightX
mov buttonX,eax
call button_boundary
add nbuttonhighlightX,3
cmp nbuttonhighlightX,16
jge button_reset1_D
jmp n
button_reset1_D:
mov nbuttonhighlightX,16
jmp n

check_mode:
push 200          ; duration (ms)
push 400          ; frequency (Hz)
call Beep@8       ; call built-in function
mov eax,buttonX
mov ebx,nbutton1X
cmp eax,ebx
je career
mov ebx,nbutton2X
cmp eax,ebx
je time
mov ebx,nbutton3X
cmp eax,ebx
je endless
jmp n

time:
mov timer_mode,1
jmp done

career:
mov career_mode,1
jmp done

endless:
mov endless_mode,1
jmp done
done:
call Clrscr
call game_start
jmp con
back:
call main_menu
con:
ret
game_mode_menu endp


;***********************************DIFFICULTY MENU***********************************

difficulty_menu proc
call ClrScr
mov eax,black+(Magenta*16)
call SetTextColor
call ClrScr
mov medium_mode,0
mov easy_mode,0
mov hard_mode,0
mov bordercolor,eax
mov eax,backwidth
mov recwidth,eax
mov eax,backheight
mov recheight,eax
mov row,0
mov col,0
mov object,'*'
call rectangle
;gameTitle
mov bordercolor,lightgray+(magenta*16)
mov recwidth,27
mov recheight,2
mov row,1
mov col,46
mov object,'~'
call rectangle
mov dh,2
mov dl,50
call Gotoxy
mov edx,offset gameTitle
call WriteString

;menuTitle
mov eax,229
mov bordercolor,eax
mov recwidth,25
mov recheight,2
mov row,4
mov col,47
mov object,'='
call rectangle
mov dh,5
mov dl,48
call Gotoxy
mov edx,offset difficulty_title
call WriteString

mov bordercolor,eax
mov recwidth,60
mov recheight,12
mov row,8
mov col,30
mov object,'*'
call rectangle

;options
mov eax,mode_button_color
mov button_color,eax
mov eax,nbutton1X
mov buttonX,eax
call button_boundary
mov eax,red+white*16
call SetTextColor
mov dh,11
mov dl,49
call Gotoxy
mov edx,offset easy_msg
call WriteString

mov eax,mode_button_color
mov button_color,eax
mov eax,nbutton2X
mov buttonX,eax
call button_boundary
mov eax,blue+white*16
call SetTextColor
mov dh,14
mov dl,49
call Gotoxy
mov edx,offset medium_msg
call WriteString

mov eax,mode_button_color
mov button_color,eax
mov eax,nbutton3X
mov buttonX,eax
call button_boundary
mov eax,green+white*16
call SetTextColor
mov dh,17
mov dl,49
call Gotoxy
mov edx,offset hard_msg
call WriteString


mov eax,mode_button_highlight_color
mov button_color,eax
mov eax,nbuttonhighlightX
mov buttonX,eax
call button_boundary

infinite:


call ReadKey     
   
    cmp ah, 72
    je MoveUp_button

    cmp ah, 80
    je MoveDown_button

    cmp al, 0Dh
    je check_mode

    cmp al,'k'
    je done
    cmp al,'K'
    je done
    n:
    mov eax,mode_button_highlight_color
    mov button_color,eax
    mov eax,nbuttonhighlightX
    mov buttonX,eax
    call button_boundary

    mov ecx,500000000
l1:
loop l1
jmp infinite

MoveUp_button:
mov eax,nbuttonhighlightX
mov buttonX,eax
call remove_button_boundary
mov eax,mode_button_color
mov button_color,eax
mov eax,nbuttonhighlightX
mov buttonX,eax
call button_boundary
sub nbuttonhighlightX,3
cmp nbuttonhighlightX,10
jle button_reset1_U
jmp n
button_reset1_U:
mov nbuttonhighlightX,10
jmp n


MoveDown_button:
mov eax,nbuttonhighlightX
mov buttonX,eax
call remove_button_boundary
mov eax,mode_button_color
mov button_color,eax
mov eax,nbuttonhighlightX
mov buttonX,eax
call button_boundary
add nbuttonhighlightX,3
cmp nbuttonhighlightX,16
jge button_reset1_D
jmp n
button_reset1_D:
mov nbuttonhighlightX,16
jmp n

check_mode:
push 200          ; duration (ms)
push 400          ; frequency (Hz)
call Beep@8       ; call built-in function
mov eax,buttonX
mov ebx,nbutton1X
cmp eax,ebx
je easy
mov ebx,nbutton2X
cmp eax,ebx
je medium
mov ebx,nbutton3X
cmp eax,ebx
je hard
jmp n

easy:
mov easy_mode,1
mov eax,slow_speed
mov speed,eax
jmp done

medium:
mov medium_mode,1
mov eax,medium_speed
mov speed,eax
jmp done

hard:
mov hard_mode,1
mov eax,fast_speed
mov speed,eax
jmp done

done:
call Clrscr
call main_menu
ret
difficulty_menu endp


;==========================================LEADER BOARD PAGE=======================================

leader_board proc
call Clrscr
call Scorefile
mov eax,black+(Magenta*16)
call SetTextColor
call ClrScr
mov bordercolor,eax
mov eax,backwidth
mov recwidth,eax
mov eax,backheight
add eax,2
mov recheight,eax
mov row,0
mov col,0
mov object,'*'
call rectangle
;gameTitle
mov bordercolor,lightgray+(magenta*16)
mov recwidth,27
mov recheight,2
mov row,1
mov col,46
mov object,'~'
call rectangle
mov dh,2
mov dl,50
call Gotoxy
mov edx,offset gameTitle
call WriteString

;menuTitle
mov eax,229
mov bordercolor,eax
mov recwidth,25
mov recheight,2
mov row,4
mov col,47
mov object,'='
call rectangle
mov dh,5
mov dl,48
call Gotoxy
mov edx,offset LeaderBoardTitle
call WriteString
;options
mov bordercolor,eax
mov recwidth,39
mov recheight,22
mov row,8
mov col,40
mov object,'*'
call rectangle

mov bl,48

mov eax,red
call SetTextColor
mov dh,10
mov dl,bl
call Gotoxy
mov edx,offset p1
call WriteString


mov eax,yellow
call SetTextColor
mov dh,12
mov dl,bl
call Gotoxy
mov edx,offset p2
call WriteString

mov eax,red
call SetTextColor
mov dh,14
mov dl,bl
call Gotoxy
mov edx,offset p3
call WriteString


mov eax,green
call SetTextColor
mov dh,16
mov dl,bl
call Gotoxy
mov edx,offset p4
call WriteString

mov eax,blue
call SetTextColor
mov dh,18
mov dl,bl
call Gotoxy
mov edx,offset p5
call WriteString


mov eax,magenta
call SetTextColor
mov dh,20
mov dl,bl
call Gotoxy
mov edx,offset p6
call WriteString

mov eax,Lightblue
call SetTextColor
mov dh,22
mov dl,bl
call Gotoxy
mov edx,offset p7
call WriteString


mov eax,LightRed
call SetTextColor
mov dh,24
mov dl,bl
call Gotoxy
mov edx,offset p8
call WriteString

mov eax,lightgray
call SetTextColor
mov dh,26
mov dl,bl
call Gotoxy
mov edx,offset p9
call WriteString


mov eax,lightmagenta
call SetTextColor
mov dh,28
mov dl,bl
call Gotoxy
mov edx,offset p10
call WriteString

mov eax,black+magenta*16
call SetTextColor
mov dh,31
mov dl,32
call Gotoxy
mov edx,offset game_back
call WriteString

mov esi,0
mov bh,10
mov ecx,10
print:
mov eax,white+black*16
call SetTextColor
mov dh,bh
mov dl,68
call Gotoxy
mov eax,score_array[esi*4+4]
call WriteDec
call Crlf
inc esi
add bh,2
loop print



infinite:
call readkey
cmp al,'k'
je done
cmp al,'K'
je done
mov ecx,100000000
l1:
loop l1
jmp infinite

done:
call ClrScr
call main_menu
ret
leader_board endp

;==========================================INSTRUCTION PAGE=========================================

instruction_page proc
call Clrscr
mov eax,black+(Magenta*16)
call SetTextColor
call ClrScr
mov bordercolor,eax
mov eax,backwidth
mov recwidth,eax
mov eax,backheight
mov recheight,eax
mov row,0
mov col,0
mov object,'*'
call rectangle
;gameTitle
mov bordercolor,lightgray+(magenta*16)
mov recwidth,27
mov recheight,2
mov row,1
mov col,46
mov object,'~'
call rectangle
mov dh,2
mov dl,50
call Gotoxy
mov edx,offset gameTitle
call WriteString

;menuTitle
mov eax,229
mov bordercolor,eax
mov recwidth,25
mov recheight,2
mov row,4
mov col,47
mov object,'='
call rectangle
mov dh,5
mov dl,48
call Gotoxy
mov edx,offset instructionTitle
call WriteString
;options
mov bordercolor,eax
mov recwidth,60
mov recheight,20
mov row,8
mov col,30
mov object,'*'
call rectangle



mov eax,red
call SetTextColor
mov dh,10
mov dl,34
call Gotoxy
mov edx,offset instruction1
call WriteString

mov eax,yellow
call SetTextColor
mov dh,13
mov dl,34
call Gotoxy
mov edx,offset instruction2
call WriteString

mov eax,green
call SetTextColor
mov dh,16
mov dl,34
call Gotoxy
mov edx,offset instruction3
call WriteString

mov eax,white
call SetTextColor
mov dh,19
mov dl,34
call Gotoxy
mov edx,offset instruction4
call WriteString

mov eax,yellow
call SetTextColor
mov dh,22
mov dl,34
call Gotoxy
mov edx,offset instruction5
call WriteString

mov eax,black+magenta*16
call SetTextColor
mov dh,25
mov dl,34
call Gotoxy
mov edx,offset game_back
call WriteString

infinite:
call readkey
cmp al,'k'
je done
cmp al,'K'
je done
mov ecx,100000000
l1:
loop l1
jmp infinite

done:
call ClrScr
call main_menu
ret
instruction_page endp


;======================================TAXI MENU AND NAME PAGE =====================================

taxi_menu PROC
call ClrScr
mov eax,black+(lightBlue*16)
call SetTextColor
call ClrScr
mov bordercolor,eax
mov eax,backwidth
mov recwidth,eax
mov eax,backheight
mov recheight,eax
mov row,0
mov col,0
mov object,'*'
call rectangle
;gameTitle
mov bordercolor,lightgray+(magenta*16)
mov recwidth,27
mov recheight,2
mov row,1
mov col,46
mov object,'~'
call rectangle
mov dh,2
mov dl,50
call Gotoxy
mov edx,offset gameTitle
call WriteString

;menuTitle
mov eax,229
mov bordercolor,eax
mov recwidth,25
mov recheight,2
mov row,5
mov col,47
mov object,'='
call rectangle
mov dh,6
mov dl,48
call Gotoxy
mov edx,offset taxi_title
call WriteString

mov bordercolor,eax
mov recwidth,60
mov recheight,12
mov row,10
mov col,30
mov object,'*'
call rectangle

mov eax,red+white*16
call SetTextColor
mov dh,13
mov dl,50
call Gotoxy
    mov edx, OFFSET taxi_red
    call WriteString
        call Crlf
mov eax,green+white*16
call SetTextColor
mov dh,16
mov dl,50
call Gotoxy
    mov edx, OFFSET taxi_yellow
    call WriteString
        call Crlf

mov eax,cyan+white*16
call SetTextColor
mov dh,19
mov dl,49
call Gotoxy
    mov edx, offset taxi_choice
    call WriteString
    call ReadInt
    cmp eax,1
    je set_taxi_color_to_red
    cmp eax,2
    jne set_taxi_color_to_red
    mov taxi_color,14
    sub speed,10000000   ;yellow taxi is faster
    jmp naming
    set_taxi_color_to_red:
    mov taxi_color,4
    naming:

    

mov eax,magenta+white*16
call SetTextColor
mov dh,24
mov dl,49
call Gotoxy   
    mov edx, OFFSET name_prompt
    call WriteString
    mov edx,offset namebuffer
    mov ecx,lengthof namebuffer
    call readString


done:
call ClrScr
ret
taxi_menu ENDP

;============================================MAIN MENU=========================================

main_menu proc
call Clrscr
mov eax,black+(LightMagenta*16)
call SetTextColor
call ClrScr
mov bordercolor,eax
mov eax,backwidth
mov recwidth,eax
mov eax,backheight
mov recheight,eax
mov row,0
mov col,0
mov object,'*'
call rectangle
;gameTitle
mov bordercolor,lightgray+(magenta*16)
mov recwidth,27
mov recheight,2
mov row,1
mov col,46
mov object,'~'
call rectangle
mov dh,2
mov dl,50
call Gotoxy
mov edx,offset gameTitle
call WriteString

;menuTitle
mov eax,229
mov bordercolor,eax
mov recwidth,29
mov recheight,2
mov row,4
mov col,45
mov object,'='
call rectangle
mov dh,5
mov dl,54
call Gotoxy
mov edx,offset menuTitle
call WriteString

call car_model

mov bordercolor,eax
mov recwidth,33
mov recheight,16
mov row,7
mov col,43
mov object,'*'
call rectangle

;options
mov eax,boundary_color
mov button_color,eax
mov eax,button1X
mov buttonX,eax
call button_boundary
mov dh,9
mov dl,50
call Gotoxy
mov edx,offset option1
call WriteString

mov eax,boundary_color
mov button_color,eax
mov eax,button2X
mov buttonX,eax
call button_boundary
mov dh,12
mov dl,50
call Gotoxy
mov edx,offset option2
call WriteString

mov eax,boundary_color
mov button_color,eax
mov eax,button3X
mov buttonX,eax
call button_boundary
mov dh,15
mov dl,50
call Gotoxy
mov edx,offset option3
call WriteString

mov eax,boundary_color
mov button_color,eax
mov eax,button4X
mov buttonX,eax
call button_boundary
mov dh,18
mov dl,50
call Gotoxy
mov edx,offset option4
call WriteString

mov eax,boundary_color
mov button_color,eax
mov eax,button5X
mov buttonX,eax
call button_boundary
mov dh,21
mov dl,50
call Gotoxy
mov edx,offset option5
call WriteString

mov eax,button_highlight_color
mov button_color,eax
mov eax,buttonhighlightX
mov buttonX,eax
call button_boundary
infinite:
call ReadKey     
   
    
   cmp ah, 72
    je MoveUp_button

    cmp ah, 80
    je MoveDown_button

    enter_press:
    cmp al, 0Dh
    je go

    cmp al,'k'
    je done
    cmp al,'K'
    je done

    n:
    mov eax,button_highlight_color
    mov button_color,eax
    mov eax,buttonhighlightX
    mov buttonX,eax
    call button_boundary

    mov ecx,500000000
l1:
loop l1
jmp infinite

MoveUp_button:
mov eax,buttonhighlightX
mov buttonX,eax
call remove_button_boundary
mov eax,boundary_color
mov button_color,eax
mov eax,buttonhighlightX
mov buttonX,eax
call button_boundary
sub buttonhighlightX,3
cmp buttonhighlightX,8
jle button_reset1_U
jmp n
button_reset1_U:
mov buttonhighlightX,8
jmp n


MoveDown_button:
mov eax,buttonhighlightX
mov buttonX,eax
call remove_button_boundary
mov eax,boundary_color
mov button_color,eax
mov eax,buttonhighlightX
mov buttonX,eax
call button_boundary
add buttonhighlightX,3
cmp buttonhighlightX,20
jge button_reset1_D
jmp n
button_reset1_D:
mov buttonhighlightX,20
jmp n

go:
push 200          ; duration (ms)
push 400          ; frequency (Hz)
call Beep@8       ; call built-in function
mov eax,buttonhighlightX
mov buttonX,eax
mov ebx,button1X
cmp eax,ebx
je start_new_game
mov ebx,button2X
cmp eax,ebx
je continue_game
mov ebx,button3X  
cmp eax,ebx
je change_difficulty_level
mov ebx,button4X
cmp eax,ebx
je view_leaderboard
mov ebx,button5X
cmp eax,ebx
je read_instructions

start_new_game:
call restart_game
call game_mode_menu
jmp done
continue_game:
call game_start
jmp done
change_difficulty_level:
call difficulty_menu
jmp done
view_leaderboard:
call leader_board
jmp done
read_instructions:
call instruction_page
jmp done
done:
ret
main_menu endp


;======================================END GAME PAGE================================================

end_page proc
call Clrscr
push 400          ; duration (ms)
push 300          ; frequency (Hz)
call Beep@8       ; call built-in function
mov eax,score
call read_file
mov eax,black+(lightMagenta*16)
call SetTextColor
call ClrScr
mov bordercolor,eax
mov eax,backwidth
mov recwidth,eax
mov eax,backheight
mov recheight,eax
mov row,0
mov col,0
mov object,'*'
call rectangle
;gameTitle
mov bordercolor,lightgray+(magenta*16)
mov recwidth,27
mov recheight,2
mov row,1
mov col,46
mov object,'~'
call rectangle
mov dh,2
mov dl,50
call Gotoxy
mov edx,offset gameTitle
call WriteString

call car_model
mov bordercolor,eax
mov recwidth,43
mov recheight,14
mov row,10
mov col,40
mov object,'*'
call rectangle

mov bordercolor,magenta+black*16
mov recwidth,39
mov recheight,10
mov row,12
mov col,42
mov object,'='
call rectangle

mov eax,brown+white*16
call SetTextColor
mov dh,14
mov dl,54
call Gotoxy
mov edx,offset ending
call WriteString


mov eax,green+white*16
call SetTextColor
mov dh,18
mov dl,52
call gotoxy
mov edx,offset car_body1
call writestring
mov dh,18
inc dh
mov dl,52
call gotoxy
mov edx,offset car_body2
call writestring


mov eax,yellow+gray*16
call SetTextColor
mov dh,18
mov dl,60
call gotoxy
mov edx,offset person_body1
call writestring
mov dh,18
inc dh
mov dl,60
call gotoxy
mov edx,offset person_body2
call writestring



mov eax,red+black*16
call SetTextColor
mov dh,18
mov dl,68
call gotoxy
mov edx,offset destination_body1
call writestring
mov dh,18
inc dh
mov dl,68
call gotoxy
mov edx,offset destination_body2
call writestring


;options
mov eax,blue+white*16
call SetTextColor
mov dh,27
mov dl,49
call Gotoxy
mov edx,offset end_game
call WriteString



mov eax,button_highlight_color
mov button_color,eax
mov eax,26
mov buttonX,eax
call button_boundary
infinite:
call ReadKey     
    cmp al, 0Dh
    je go
    n:

    mov ecx,500000000
l1:
loop l1
jmp infinite


go:
push 200          ; duration (ms)
push 400          ; frequency (Hz)
call Beep@8       ; call built-in function
call main_menu
done:
ret
end_page endp

;=================CAR MODEL ON FRONT AND END PAGE============

car_model proc
;car on frontpage
mov eax,gray+(lightMagenta*16)
mov bordercolor,eax
mov recwidth,23
mov recheight,8
mov row,15
mov col,90
mov object,'O'
call rectangle
;wheel1
mov eax,black+(lightMagenta*16)
mov bordercolor,eax
mov recwidth,3
mov recheight,2
mov row,24
mov col,94
call rectangle
;wheel
mov recwidth,3
mov recheight,2
mov row,24
mov col,106
call rectangle

;car windows
mov eax,216
mov bordercolor,eax
;left window
mov eax,209
mov bordercolor,eax
mov recwidth,4
mov recheight,3
mov row,17
mov col,94
call rectangle

;right window
mov recwidth,4
mov recheight,3
mov row,17
mov col,105
call rectangle
;light
mov eax,222
mov bordercolor,eax
mov recwidth,6
mov recheight,5
mov row,18
mov col,114
call rectangle

ret
car_model endp



;========================================BACK GROUND BASE DRAW======================================

draw_board PROC
mov bordercolor,1
mov row,1
mov col,1
mov ecx,13
mov object,'B'
l1:
mov eax,boardheight
mov recheight,eax
mov eax,10
mov recwidth,eax
mov temp,ecx
call rectangle
add col,10
mov ecx,temp
loop l1

ret
draw_board ENDP

;===========================================OBSTACLES==============================================
draw_obstacle PROC
mov bordercolor,lightmagenta+magenta*16
mov object,'O'
obs1:
mov row,6
mov col,12
mov recheight,1
mov recwidth,18
call rectangle
obs2:
mov row,6
mov col,82
mov recheight,1
mov recwidth,48
call rectangle
obs3:
mov row,14
mov col,12
mov recheight,1
mov recwidth,13
call rectangle
mov row,16
mov col,22
mov recheight,1
mov recwidth,3
call rectangle
obs4:
mov row,20
mov col,12
mov recheight,1
mov recwidth,3
call rectangle

obs5:
mov row,14
mov col,32
mov recheight,1
mov recwidth,18
call rectangle
mov row,8
mov col,47
mov recheight,7
mov recwidth,3
call rectangle
;*********************print store inside obstacle****************
mov eax,blue+white*16
call SetTextColor
mov esi,offset store
mov ecx,5
mov x,9
mov y,48
l1:
mov dh,x
mov dl,y
call gotoxy
mov al,[esi]
call writechar
inc esi
inc y
mov dh,x
mov dl,y
call gotoxy
mov al,[esi]
call writechar
call Crlf
inc esi
dec y
inc x
loop l1
obs6:
mov row,18
mov col,62
mov recheight,1
mov recwidth,18
call rectangle
mov row,20
mov col,62
mov recheight,7
mov recwidth,3
call rectangle

;************print school inside obstacle******************

mov eax,red+white*16
call SetTextColor
mov esi,offset school
mov ecx,6
mov x,21
mov y,63
l2:
mov dh,x
mov dl,y
call gotoxy
mov al,[esi]
call writechar
inc esi
inc y
mov dh,x
mov dl,y
call gotoxy
mov al,[esi]
call writechar
call Crlf
inc esi
dec y
inc x
loop l2

obs7:
mov row,26
mov col,112
mov recheight,1
mov recwidth,8
call rectangle
mov row,22
mov col,107
mov recheight,5
mov recwidth,3
call rectangle
mov row,20
mov col,102
mov recheight,1
mov recwidth,8
call rectangle


;*******************print bank inside obstacle***************************
mov eax,green+white*16
call SetTextColor
mov esi,offset bank
mov ecx,4
mov x,23
mov y,108
l3:
mov dh,x
mov dl,y
call gotoxy
mov al,[esi]
call writechar
inc esi
inc y
mov dh,x
mov dl,y
call gotoxy
mov al,[esi]
call writechar
call Crlf
inc esi
dec y
inc x
loop l3
ret
draw_obstacle ENDP

;==================================DISPLAY PROCS===================================================

display_score PROC
mov eax,white+(blue*16)
call SetTextColor
mov dh,0
mov dl,10
call Gotoxy
mov edx,offset spacing
call WriteString
mov dh,0
mov dl,10
call Gotoxy
mov eax,score
call WriteInt

ret
display_score ENDP

display_time PROC
mov eax,white+(blue*16)
call SetTextColor
mov dh,0
mov dl,126
call Gotoxy

mov eax,current_time
mov edx, 0
mov ebx, 1000
div ebx
call WriteDec
ret
display_time ENDP

display_item PROC
mov eax,white+(blue*16)
call SetTextColor
mov dh,0
mov dl,98
call Gotoxy
mov eax,collected
call WriteInt

ret
display_item ENDP

display_target PROC
cmp career_mode,1
jne done
mov dh,0
mov dl,21
call Gotoxy
mov eax,white+(blue*16)
call SetTextColor
mov edx,offset target_display
call WriteString
mov eax,white+(blue*16)
call SetTextColor
mov dh,0
mov dl,55
call Gotoxy
mov eax,target_score
call WriteInt
done:
ret
display_target ENDP

;==============================GAME START AND BASIC BOARD LOOP======================================

game_start PROC
call taxi_menu
call ClrScr
mov eax,0
call SetTextColor
call Clrscr
mov in_game,1
call frame

;score label display
mov dh,0
mov dl,1
call Gotoxy
mov eax,white+(blue*16)
call SetTextColor
mov edx,offset score_label
call WriteString

;time label display
mov dh,0
mov dl,119
call Gotoxy
mov eax,white+(blue*16)
call SetTextColor
mov edx,offset time_label
call WriteString

call display_target

mov dh,0
mov dl,81
call Gotoxy
mov eax,white+(blue*16)
call SetTextColor
mov edx,offset item_display
call WriteString

car1:
mov car_color,11
mov car1X,2
mov eax,car1X
mov carX,eax
mov car1Y,2
mov eax,car1Y
mov carY,eax
call draw_car

car2:
mov car2X,24
mov eax,car2X
mov carX,eax
mov car2Y,127
mov eax,car2Y
mov carY,eax
call draw_car

car3:
mov car3X,10
mov eax,car3X
mov carX,eax
mov car3Y,7
mov eax,car3Y
mov carY,eax
call draw_car


car4:
mov car4X,18
mov car4Y,52
mov eax,car4X
mov carX,eax
mov eax,car4Y
mov carY,eax
call draw_car

car5:
mov car5X,12
mov car5Y,82
mov eax,car5X
mov carX,eax
mov eax,car5Y
mov carY,eax
call draw_car

cmp easy_mode,1
je easy
cmp medium_mode,1
je medium
cmp hard_mode,1
je hard
person_cont:
call collectible
mov eax, 0
call GetMseconds
mov start_time,eax

infinite_loop:
mov ebx,start_time
call GetMseconds
sub eax,ebx
mov current_time,eax

call display_time
call display_item

cmp timer_mode,1
je time
cmp career_mode,1
je career
cmp endless_mode,1
je endless

career:
mov eax,score
cmp eax,target_score
jge done
mov ebx,total_dropped
cmp ebx,drop_target
jge done
keys:
call ReadKey

    cmp al,' '
    je pickup_call
    cmp al,0Dh
    je collect_item
    cmp al,1Bh
    je done
    cmp al,'P'
    je pause_audio
    cmp al,'p'
    je pause_audio
    jmp movement
    pause_audio:
    push 200          ; duration (ms)
push 400          ; frequency (Hz)
call Beep@8       ; call built-in function
    pausing:
    call readkey
    cmp al,'C'
    je movement
    cmp al,'c'
    je movement
    jmp pausing
    movement:
    cmp al, 0         
    jne CONT    
    movzx eax, ah 
    
    cmp eax, 72
    je MoveUp

    cmp eax, 80
    je MoveDown

    
    cmp eax, 75
    je MoveLeft

    cmp eax, 77
    je MoveRight

    cmp eax,47h
    je drop_call 
    
 CONT:
 
cmp boxes,3
jge no_box
more_box:
call get_random_coordinates
call draw_collectible
no_box:
mov eax,car2X
mov carX,eax
mov eax,car2Y
mov carY,eax
call remove_car
mov eax,car3X
mov carX,eax
mov eax,car3Y
mov carY,eax
call remove_car
mov eax,car4X
mov carX,eax
mov eax,car4Y
mov carY,eax
call remove_car
mov eax,car5X
mov carX,eax
mov eax,car5Y
mov carY,eax
call remove_car

n1:
add car2X,2
cmp car2X,32
je reset2
jmp n2
reset2:
mov car2X,24
n2:
add car3X,2
cmp car3X,32
je reset3
jmp n3
reset3:
mov car3X,10
n3:

add car4X,2
cmp car4X,32
je reset4
jmp n4
reset4:
mov car4X,18
n4:

add car5X,2
cmp car5X,32
je reset5
jmp n5
reset5:
mov car5X,12
n5:
mov eax,taxi_color ;yellow
mov car_color,eax
mov eax,car1X
mov carX,eax
mov eax,car1Y
mov carY,eax
call draw_car

mov car_color,11
mov eax,car2X
mov carX,eax
mov eax,car2Y
mov carY,eax
call draw_car

mov eax,car3X
mov carX,eax
mov eax,car3Y
mov carY,eax
call draw_car

mov eax,car4X
mov carX,eax
mov eax,car4Y
mov carY,eax
call draw_car

mov eax,car5X
mov carX,eax
mov eax,car5Y
mov carY,eax
call draw_car

call display_score

mov ecx,speed
delaying:
loop delaying

jmp infinite_loop


MoveUp:

mov eax,car1X
mov carX,eax
mov eax,car1Y
mov carY,eax

;check obstacle
    mov eax, carX
    sub eax,2
    mov edx, 130
    imul edx
    add eax, carY
mov bl,grid[eax]
cmp bl,' '
jne crash_score

call remove_car
sub car1X,2
cmp car1X,2
jle reset1_U
jmp CONT
reset1_U:
mov car1X,2
jmp CONT


MoveDown:
 
mov eax,car1X
mov carX,eax
mov eax,car1Y
mov carY,eax

;check obstacle 
    mov eax, carX
    add eax,2
    mov edx, 130
    imul edx
    add eax, carY
mov bl,grid[eax]
cmp bl,' '
jne crash_score

call remove_car
add car1X,2
cmp car1X,32
jge reset1_D
jmp CONT

reset1_D:
mov car1X,30
jmp CONT

 
MoveLeft:
mov eax,car1X
mov carX,eax
mov eax,car1Y
mov carY,eax

;check obstacle
    mov eax, carX
    mov edx, 130
    imul edx
    add eax, carY
    sub eax,5
mov bl,grid[eax]
cmp bl,' '
jne crash_score

call remove_car
sub car1Y,5

cmp car1Y,2
jle reset1_L
jmp CONT
reset1_L:
mov car1Y,2
jmp CONT

MoveRight:
mov eax,car1X
mov carX,eax
mov eax,car1Y
mov carY,eax

;check obstacle 
    mov eax, carX
    mov edx, 130
    imul edx
    add eax, carY
    add eax,5
mov bl,grid[eax]
cmp bl,' '
jne crash_score

call remove_car
add car1Y,5
cmp car1Y,127
jge reset1_R
jmp CONT
reset1_R:
mov car1Y,127
jmp CONT

time:
mov eax,timer
cmp current_time,eax
jle keys
jmp done

endless:
jmp keys

easy:
call easy_person
jmp person_cont
medium:
call medium_person
jmp person_cont
hard:
call hard_person
jmp person_cont

crash_score:
push 200          ; duration (ms)
push 400          ; frequency (Hz)
call Beep@8       ; call built-in function

cmp bl,'P'
je person_crash
taxi_crash_score:
cmp taxi_color,4
je red_taxi_crash_score
cmp taxi_color,14
yellow_taxi_crash:
je yellow_taxi_crash_score
jmp CONT

person_crash:
sub score,5
cmp score,0
jge taxi_crash_score
mov score,0
jmp taxi_crash_score


red_taxi_crash_score:
cmp bl,'O'
jne l1
sub score,2
cmp score,0
jge l1
mov score,0
l1:
cmp bl,'C'
jne yellow_taxi_crash
sub score,3
cmp score,0
jge CONT
mov score,0
jmp CONT

yellow_taxi_crash_score:
cmp bl,'O'
jne l2
sub score,4
cmp score,0
jge l2
mov score,0
l2:
cmp bl,'C'
jne CONT
sub score,2
cmp score,0
jge CONT
mov score,0
jmp CONT


pickup_call:
cmp picked,0
jne CONT
mov eax,car1X
mov picked_personX,eax
mov eax,car1Y
mov picked_personY,eax

;check obstacle above
above:
    mov eax, picked_personX
    sub eax,2
    mov edx, 130
    imul edx
    add eax, picked_personY
mov bl,grid[eax]
cmp bl,'P'
jne below
sub picked_personX,2
call remove_person
mov picked,1
jmp CONT

below:
;check obstacle below
    mov eax, picked_personX
    add eax,2
    mov edx, 130
    imul edx
    add eax, picked_personY
mov bl,grid[eax]
cmp bl,'P'
jne right
add picked_personX,2
call remove_person
mov picked,1
jmp CONT

right:
;check obstacle on right
    mov eax, picked_personX
    mov edx, 130
    imul edx
    add eax, picked_personY
    add eax,5
mov bl,grid[eax]
cmp bl,'P'
jne left
add picked_personY,5
call remove_person
mov picked,1
jmp CONT

left:

;check obstacle on left
    mov eax, picked_personX
    mov edx, 130
    imul edx
    add eax, picked_personY
    sub eax,5
mov bl,grid[eax]
cmp bl,'P'
jne CONT
sub picked_personY,5
call remove_person
mov picked,1
jmp CONT


drop_call:
mov eax,car1X
mov picked_personX,eax
mov eax,car1Y
mov picked_personY,eax
destination_above:
mov eax, picked_personX
    sub eax,2
    mov edx, 130
    imul edx
    add eax, picked_personY
mov bl,grid[eax]
cmp bl,'D'
jne destination_below
sub picked_personX,2
call remove_destination
jmp CONT

destination_below:
;check obstacle below
    mov eax, picked_personX
    add eax,2
    mov edx, 130
    imul edx
    add eax, picked_personY
mov bl,grid[eax]
cmp bl,'D'
jne destination_right
add picked_personX,2
call remove_destination
jmp CONT

destination_right:
;check obstacle on right
    mov eax, picked_personX
    mov edx, 130
    imul edx
    add eax, picked_personY
    add eax,5
mov bl,grid[eax]
cmp bl,'D'
jne destination_left
add picked_personY,5
call remove_destination
jmp CONT


destination_left:
;check obstacle on left
    mov eax, picked_personX
    mov edx, 130
    imul edx
    add eax, picked_personY
    sub eax,5
mov bl,grid[eax]
cmp bl,'D'
jne CONT
sub picked_personY,5
call remove_destination
jmp CONT


collect_item:
mov eax,car1X
mov picked_collectibleX,eax
mov eax,car1Y
mov picked_collectibleY,eax

;check obstacle above
collectible_above:
    mov eax, picked_collectibleX
    sub eax,2
    mov edx, 130
    imul edx
    add eax, picked_collectibleY
mov bl,grid[eax]
cmp bl,'$'
jne collectible_below
sub picked_collectibleX,2
call remove_collectible
add score,10
jmp CONT

collectible_below:
;check obstacle below
    mov eax, picked_collectibleX
    add eax,2
    mov edx, 130
    imul edx
    add eax, picked_collectibleY
mov bl,grid[eax]
cmp bl,'$'
jne collectible_right
add picked_collectibleX,2
call remove_collectible
add score,10
jmp CONT

collectible_right:
;check obstacle on right
    mov eax, picked_collectibleX
    mov edx, 130
    imul edx
    add eax, picked_collectibleY
    add eax,5
mov bl,grid[eax]
cmp bl,'$'
jne collectible_left
add picked_collectibleY,5
call remove_collectible
add score,10
jmp CONT

collectible_left:
;check obstacle on left
    mov eax, picked_collectibleX
    mov edx, 130
    imul edx
    add eax, picked_collectibleY
    sub eax,5
mov bl,grid[eax]
cmp bl,'$'
jne CONT
sub picked_collectibleY,5
call remove_collectible
add score,10
jmp CONT


done:
mov in_game,0
call Clrscr
;call restart_game
call end_page
ret
game_start ENDP

;=============================================DRAW TREE=============================================

tree proc
tree1:
mov bordercolor,white+green*16
mov object,'*'
mov row,2
mov col,127
mov recwidth,3
mov recheight,1
call rectangle

mov bordercolor,6
mov object,'|'
mov row,4
mov col,127
mov recwidth,3
mov recheight,1
call rectangle

tree2:
mov bordercolor,white+green*16
mov object,'*'
mov row,10
mov col,32
mov recwidth,3
mov recheight,1
call rectangle

mov bordercolor,6
mov object,'|'
mov row,12
mov col,32
mov recwidth,3
mov recheight,1
call rectangle

tree3:
mov bordercolor,white+green*16
mov object,'*'
mov row,22
mov col,112
mov recwidth,3
mov recheight,1
call rectangle

mov bordercolor,6
mov object,'|'
mov row,24
mov col,112
mov recwidth,3
mov recheight,1
call rectangle
ret
tree ENDP

;========================================RANDOM COORDINATES ========================================

get_random_coordinates proc
call Randomize
mov row,4
mov col,2
get:
mov eax, 26
call RandomRange
mov ranNum, eax
cmp ranNum,1
je get
cmp ranNum,10
je get
cmp ranNum,16
je get
cmp ranNum,25
je get
mov ebx,5
mul ebx
add eax,2
mov col,eax
;5n+2
mov eax, 14
call RandomRange
mov ranNum, eax
mov ebx,2
mul ebx
add eax,2
mov row,eax
;2n+2
mov eax,row
    mov edx, 130
    imul edx
    add eax,col
mov bl,grid[eax]
cmp bl,' '
jne get


ret
get_random_coordinates endp

;=========================================PERSON DRAW===============================================

draw_person proc
mov bordercolor,15
mov object,'P'

mov recwidth,3
mov recheight,1
call rectangle

mov dh,BYTE PTR row
mov dl,BYTE PTR col
call gotoxy
mov edx,offset person_body1
call writestring
mov dh,BYTE PTR row
inc dh
mov dl,BYTE PTR col
call gotoxy
mov edx,offset person_body2
call writestring

ret
draw_person endp


easy_person proc
call get_random_coordinates
call draw_person
call get_random_coordinates
call draw_person
call get_random_coordinates
call draw_person
ret
easy_person endp

medium_person proc
call get_random_coordinates
call draw_person
call get_random_coordinates
call draw_person
call get_random_coordinates
call draw_person
call get_random_coordinates
call draw_person

ret
medium_person endp

hard_person proc
call get_random_coordinates
call draw_person
call get_random_coordinates
call draw_person
call get_random_coordinates
call draw_person
call get_random_coordinates
call draw_person
call get_random_coordinates
call draw_person
ret
hard_person endp


;=================PERSON REMOVE=================

remove_person PROC
call get_random_coordinates
call draw_person
call destination
mov bordercolor,black+black*16
mov object,' '
mov recwidth,3
mov recheight,1
mov eax,picked_personX
mov row,eax
mov eax,picked_personY
mov col,eax
call rectangle
add pickup_count,1
ret
remove_person ENDP

;=========================================CAR DRAW===================================================

draw_car PROC

mov object,'C'
mov eax,car_color
mov bordercolor,eax
mov recwidth,3
mov recheight,1
mov eax,carX
mov row,eax
mov eax,carY
mov col,eax
call rectangle

mov dh,BYTE PTR carX
mov dl,BYTE PTR carY
call gotoxy
mov edx,offset car_body1
call writestring
mov dh,BYTE PTR carX
inc dh
mov dl,BYTE PTR carY
call gotoxy
mov edx,offset car_body2
call writestring
ret
draw_car ENDP

;====================CAR REMOVE=================

remove_car PROC
mov bordercolor,black+black*16
mov object,' '
mov recwidth,3
mov recheight,1
mov eax,carX
mov row,eax
mov eax,carY
mov col,eax
call rectangle
ret
remove_car ENDP



;======================================DESTINATION DRAW=============================================

draw_destination proc
mov bordercolor,white+lightgreen*16
mov object,'D'
mov recwidth,3
mov recheight,1
call rectangle
mov dh,BYTE PTR row
mov dl,BYTE PTR col
call gotoxy
mov edx,offset destination_body1
call writestring
mov dh,BYTE PTR row
inc dh
mov dl,BYTE PTR col
call gotoxy
mov edx,offset destination_body2
call writestring

ret
draw_destination endp


destination PROC
call get_random_coordinates
call draw_destination
ret 
destination ENDP

;==============REMOVE DESTINATION======================

remove_destination PROC
push 200          ; duration (ms)
push 400          ; frequency (Hz)
call Beep@8       ; call built-in function
mov object,' '
mov recwidth,3
mov recheight,1
mov eax,picked_personX
mov row,eax
mov eax,picked_personY
mov col,eax
call rectangle
add drop_count,1
mov picked,0
add dropped,1
add total_dropped,1
cmp dropped,2
jl done
mov dropped,0
sub speed,10000000  ;speed inc after 2 successful drops
done:
add score,10
ret
remove_destination ENDP
;======================================COLLECTIBLE DRAW=============================================

draw_collectible proc
mov bordercolor,lightMagenta
mov object,'$'
mov recwidth,3
mov recheight,1
call rectangle
inc boxes

mov dh,BYTE PTR row
mov dl,BYTE PTR col
call gotoxy
mov edx,offset collectible_body1
call writestring
mov dh,BYTE PTR row
inc dh
mov dl,BYTE PTR col
call gotoxy
mov edx,offset collectible_body2
call writestring
ret
draw_collectible endp

collectible PROC
call get_random_coordinates
call draw_collectible
call get_random_coordinates
call draw_collectible
call get_random_coordinates
call draw_collectible
ret 
collectible ENDP


;===========REMOVE COLLECTIBLE BOX===========

remove_collectible PROC
push 200          ; duration (ms)
push 400          ; frequency (Hz)
call Beep@8       ; call built-in function
mov object,' '
mov recwidth,3
mov recheight,1
mov eax,picked_collectibleX
mov row,eax
mov eax,picked_collectibleY
mov col,eax
call rectangle
dec boxes
add collected,1
ret
remove_collectible ENDP
;========================================FILE HANDLING PART=========================================
;this prcedure reads score from file by using an array 
;***************************************************************************************************
read_file PROC
    mov edx, OFFSET filename
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je no_file
    mov fileHandle, eax
        
    ;Read file and copy to  buffer
    mov eax, fileHandle
    mov edx, OFFSET buffer
    mov ecx, LENGTHOF buffer
    call ReadFromFile
    ;saving the number of bytes read
    mov score_temp, eax               
    
    ;close file
    mov eax, fileHandle
    call CloseFile
    cmp score_temp, 0
    je no_file             
    mov esi,0                 
    mov edi,OFFSET buffer    
reading_file:
    cmp esi,10
    jge done_read
skip_characters:
    mov al,[edi]
    cmp al,0                  
    je done_read
    cmp al,'0'
    jl SkipChar
    cmp al,'9'
    jle convert_number_to_string            
SkipChar:
    inc edi
    jmp skip_characters
convert_number_to_string:
   mov ebx,0               
convert_digit:
    mov al,[edi]
    cmp al,'0'
    jl storing_number            
    cmp al,'9'
    jg storing_number            
    sub al, '0'
    movzx eax, al
    imul ebx, 10
    add ebx, eax
    inc edi
    jmp convert_digit
storing_number:
    mov score_array[esi*4], ebx
    inc esi
    jmp reading_file
done_read:
    cmp esi, 10
    jge done
FillRemaining:
    mov score_array[esi*4], 0
    inc esi
    cmp esi, 10
    jl FillRemaining
done:
    ret
no_file:
    call write_zeros  ;writing zeroes to file
    mov esi, 0
fill_zeros:           ;storing zeroes to array for bubble sort
    cmp esi, 10
    jge done
    mov score_array[esi*4],0
    inc esi
    jmp fill_zeros
ret
read_file ENDP
;***************************************************************************************************

;this function converts the digits into string first to write scores in file
convert_to_string PROC
    mov ebx, eax        
    mov edi, OFFSET buffer
    mov ecx, 20
    push eax
    mov al, 0
ClearLoop:
    mov [edi], al
    inc edi
    loop ClearLoop
    pop eax
    mov edi, OFFSET buffer
    cmp ebx, 0
    jne NotZero
    mov byte ptr [edi], '0'
    mov byte ptr [edi+1], 0
    jmp Done    
NotZero:
    ; Count digits and store them in reverse
    mov esi, 0  ; digit count
    
count_digits:
    cmp ebx, 0
    je reverse_digits
    mov eax, ebx
    xor edx, edx
    mov ecx, 10
    div ecx
    mov ebx, eax
    push edx
    inc esi
    jmp count_digits
reverse_digits:
    mov edi, OFFSET buffer
    mov ecx, esi
    
pop_digits:
    cmp ecx, 0
    je Done
    pop edx
    add dl, '0'
    mov [edi], dl
    inc edi
    dec ecx
    jmp pop_digits
    
Done:
    mov byte ptr [edi], 0 
   
    ret
convert_to_string ENDP
;===================this procedure is used to write zeroes to an empty file=========================
write_zeros PROC
    mov edx, OFFSET filename
    call CreateOutputFile
    mov fileHandle, eax
    mov esi, 0           ; index for 10 zeros
write_loop:
    cmp esi, 10
    jge done_zeros
    push esi
    mov eax, 0
    mov edx,OFFSET buffer
    call convert_to_string
    pop esi
    push esi
    mov edi,OFFSET buffer
    mov ecx, 0
FindNull:
    cmp byte ptr [edi], 0
    je FoundNull
    inc edi
    inc ecx
    jmp FindNull
FoundNull:
    mov score_temp, ecx
    pop esi

    ;storing in buffer
    push esi
    mov eax, fileHandle
    mov edx, OFFSET buffer
    mov ecx, score_temp
    call WriteToFile
    pop esi

    ;jmping to next line
    push esi
    mov eax, fileHandle
    mov edx, OFFSET line
    mov ecx, 2
    call WriteToFile
    pop esi
    inc esi
    jmp write_loop

done_zeros:
    ; close file
    mov eax, fileHandle
    call CloseFile

    ret
write_zeros ENDP
;===================this procedure is used to write scores to file==================================
write_to_file proc

;bubble sorting logic
    mov ecx,11          
outer:
    push ecx            
    mov esi,0          
inner:
    cmp esi,10          
    jge l1
    mov eax, score_array[esi*4]       ; current element
    mov ebx, score_array[esi*4 + 4]   ; next element
    cmp eax, ebx
    jge no_swap
    mov score_array[esi*4], ebx
    mov score_array[esi*4 + 4], eax
no_swap:
    inc esi
    jmp inner
l1:
    pop ecx              ; restore outer loop counter
    loop outer

;writing in file
    push esi
    push edi
    mov edx, OFFSET filename
    call CreateOutputFile
    mov fileHandle, eax
    mov esi, 0
write_loop:
    cmp esi, 10          ; Write only top 10 scores (indices 0-9)
    jge DoneWrite

    ; convert score_array[esi] to buffer
    mov eax, score_array[esi*4]
    mov edx, OFFSET buffer
    push esi
    call convert_to_string
    pop esi
    
    ; Calculate string length manually by finding null terminator
    push esi
    mov edi, OFFSET buffer
    mov ecx, 0
FindNull:
    cmp byte ptr [edi], 0
    je FoundNull
    inc edi
    inc ecx
    jmp FindNull
FoundNull:
    mov score_temp, ecx
    pop esi
    ; write buffer
    push esi
    mov eax, fileHandle
    mov edx, OFFSET buffer
    mov ecx, score_temp
    call WriteToFile
    pop esi
    ; write line
    push esi
    mov eax, fileHandle
    mov edx, OFFSET line
    mov ecx, 2
    call WriteToFile
    pop esi
    inc esi
    jmp write_loop
DoneWrite:
    ; close file
    mov eax, fileHandle
    call CloseFile
    
    pop edi
    pop esi
    ret
write_to_file endp
;=========================Final procedure calling all necessery functionalities=====================
Scorefile proc
    call read_file
    mov eax, score
    mov score_array[10*4], eax
    call write_to_file
ret
Scorefile endp

frame proc
mov esi,0
call draw_board
call draw_obstacle
call tree
ret 
frame endp

main PROC

call main_menu

mov dh,32
mov dl,0
call Gotoxy
exit
main ENDP
end main

; Author: Livan Ojito Villanueva
; Date: Sunday, Aug 2 2020.
; 
; This program written in assembly language displays in a tabular form the name, team and goals scored at a club level of some of the top soccer players in the world. 
; It then proceeds using the bubble sort algorithm also written in assembly language to sort the tables according to the number of goals scored and finally displays the result.   
; 
; I am using the FASM assembler on Windows. Sorry Linux users!
;
; C:\Users\Admin\Desktop\googledrive\assembly\assembly-bubble-sort>fasm soccer_players.asm
; flat assembler  version 1.73.24  (1048576 kilobytes memory)
; 3 passes, 4096 bytes.
;
; And last but not least, the answer to the question who is the best soccer player on the planet is no other than Lionel Messi. lol
;
; And yes, I am a soccer fan!
;
;

format PE console

entry start

include 'win32a.inc' 

struct TABLE_HEADER
	header1 db 10 dup (?)
	header2 db 10 dup (?)
	header3 db 10 dup (?)
ends

struct PLAYER
  name  db 20 dup ('n')
  team  db 20 dup ('t')
  goals dd ?
ends
; ****************************************************************
  
section '.data' data readable writeable

table_header TABLE_HEADER 'Player','Team','Goals'

group1_players:
 PLAYER 'Messi',       'Barcelona',           644
 PLAYER 'Ronaldo',     'Juventus',            636
 PLAYER 'Zlatan',      'AC Milan',            485
 PLAYER 'Benzema',     'Real Madrid',         329
 PLAYER 'Lewandowski', 'Bayern Munich',       423
 PLAYER 'Pogba',       'Manchester United',   66
 PLAYER 'Willian',     'Chelsea',             103
 PLAYER 'Salah',       'Liverpool',           171
 PLAYER 'Neymar',      'PSG',                 311
 PLAYER 'Aubameyang',  'Arsenal',             266

group1_number_of_players dd 10

group2_players:
 PLAYER 'Martial',     'Manchester United',   93
 PLAYER 'Immobile',    'Lazio',               203
 PLAYER 'Kane',        'Tottenham',           204
 PLAYER 'Vardy',       'Leicester City',      192
 PLAYER 'Mbappe',      'Paris Saint-Germain', 121
 PLAYER 'Rashford',    'Manchester United',   67
 PLAYER 'Jimenez',     'Wolves',              114
 PLAYER 'Sterling',    'Manchester City',     122
 PLAYER 'Lukaku',      'Inter',               216
 PLAYER 'Mane',        'Liverpool',           153

group2_number_of_players dd 10

string_header_format db '%-20s%-20s%-20s',0dh,0ah
                     db 50 dup ('-'),0dh,0ah,0
   
string_player_format db '%-20s%-20s%d',0dh,0ah,0

group1_unsorted_msg db 0dh,0ah,0dh,0ah,'The following table lists the names of some of the top soccer players along with the team they are playing on and the total number of goals scored at club level.',0dh,0ah,0dh,0ah,0

group1_sorted_msg db 0dh,0ah,0dh,0ah,'I am now displaying the previous table sorted in ascending order according to the number of goals scored by the player. The sorting algorithm used was bubble sort.',0dh,0ah,0dh,0ah,0

group2_unsorted_msg db 0dh,0ah,0dh,0ah,0dh,0ah,'This second table, basically another array in memory, displays another group of top soccer players along with the team they are playing on and the total number of goals scored at club level.',0dh,0ah,0dh,0ah,0

group2_sorted_msg db 0dh,0ah,0dh,0ah,'This time and using the same bubble sort subroutine this second table is sorted in descending order according to the number of goals scored by the player.',0dh,0ah,0dh,0ah,0



; ****************************************************************

section '.text' code readable executable

start:
	push group1_players
	push dword [group1_number_of_players]
	push sort_by_goals_scored_asc
	push group1_unsorted_msg
	push group1_sorted_msg
	call process_group_of_players
	
	push group2_players
	push dword [group2_number_of_players]
	push sort_by_goals_scored_desc
	push group2_unsorted_msg
	push group2_sorted_msg
	call process_group_of_players
	
	push 0
	call [ExitProcess]
	
	
; ****************************************************************	
	
process_group_of_players:
	push ebp
	mov ebp,esp
	
	push dword [ebp + 12]
	call [printf]
	add esp,4
	
	push dword [ebp + 24]
	push dword [ebp + 20]
	push sizeof.PLAYER
	call print_table

	push dword [ebp + 24]
	push dword [ebp + 20]
	push sizeof.PLAYER
	push dword [ebp + 16]
	call bubble_sort
	
	push dword [ebp + 8]
	call [printf]
	add esp,4
	
	push dword [ebp + 24]
	push dword [ebp + 20]
	push sizeof.PLAYER
	call print_table
	
	pop ebp
	ret 20
	
; ****************************************************************

print_table:
	push ebp
	mov ebp,esp
	
	push ebx	
	push ecx
	push esi
	
	call print_header
	
	mov ecx,dword [ebp + 12]
	mov esi,[ebp + 16]
next_player:
	push ecx ; printf overwrites this register	
	
	push esi
	call print_row
	
	add esi,[ebp + 8]
	pop ecx 
	loop next_player
	
	pop esi
	pop ecx
	pop ebx
	
	pop ebp
	ret 12

; ****************************************************************

print_header:
	push table_header + TABLE_HEADER.header3
	push table_header + TABLE_HEADER.header2
	push table_header + TABLE_HEADER.header1
	push string_header_format
	call [printf]
	add esp,16
	
	ret

; ****************************************************************

print_row:
	push ebp
	mov ebp,esp
	
	push ebx
	push esi
	
	mov esi,[ebp + 8]
	lea ebx,[esi + PLAYER.goals]	
	push dword [ebx]
	lea ebx,[esi + PLAYER.team]
	push ebx
	lea ebx,[esi + PLAYER.name]
	push ebx
	push string_player_format
	call [printf]
	add esp,16
	
	pop esi
	pop ebx
	
	pop ebp
	ret 4

; ****************************************************************

sort_by_goals_scored_asc:
	push ebp
	mov ebp,esp
	
	push ebx
	push ecx
	
	mov eax,-1
	
	mov ebx,dword [ebp + 12]
	mov ebx,dword [ebx + PLAYER.goals]
	mov ecx,dword [ebp + 8]
	mov ecx,dword [ecx + PLAYER.goals]
	cmp ebx,ecx
	jb exit_sort_asc
	
	mov eax,1
	
exit_sort_asc:
	pop ecx
	pop ebx
	
	pop ebp
	ret 8
	
; ****************************************************************

sort_by_goals_scored_desc:
	push ebp
	mov ebp,esp
	
	push ebx
	push ecx
	
	mov eax,-1
	
	mov ebx,dword [ebp + 12]
	mov ebx,dword [ebx + PLAYER.goals]
	mov ecx,dword [ebp + 8]
	mov ecx,dword [ecx + PLAYER.goals]
	cmp ebx,ecx
	ja exit_sort_desc
	
	mov eax,1
	
exit_sort_desc:
	pop ecx
	pop ebx	
	
	pop ebp
	ret 8

; ****************************************************************
	
include 'bubble_sort.inc'
	
section '.idata' import data readable
 
library kernel,'kernel32.dll',\
        msvcrt,'msvcrt.dll'
 
import  kernel,\
        ExitProcess,'ExitProcess'
		
import msvcrt,\
       printf,'printf'		
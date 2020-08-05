This program written in assembly language displays in a tabular form the name, team and goals scored at a club level of some of the top soccer players in the world. It then proceeds using the bubble sort algorithm also written in assembly language to sort the tables according to the number of goals scored and finally displays the result.  
 
I am using the FASM assembler on Windows. Sorry Linux users!

C:\Users\Admin\Desktop\googledrive\assembly\assembly-bubble-sort>fasm soccer_players.asm\
flat assembler  version 1.73.24  (1048576 kilobytes memory)
3 passes, 4096 bytes.

C:\Users\Admin\Desktop\googledrive\assembly\assembly-bubble-sort>soccer_players.exe

The following table lists the names of some of the top soccer players along with the team they are playing on and the total number of goals scored at club level.

Player              |Team                |Goals
:-------------------|:-------------------|:----
Messi               |Barcelona           |644
Ronaldo             |Juventus            |636
Zlatan              |AC Milan            |485
Benzema             |Real Madrid         |329
Lewandowski         |Bayern Munich       |423
Pogba               |Manchester United   |66
Willian             |Chelsea             |103
Salah               |Liverpool           |171
Neymar              |PSG                 |311
Aubameyang          |Arsenal             |266

I am now displaying the previous table sorted in ascending order according to the number of goals scored by the player. The sorting algorithm used was bubble sort.

Player              |Team                |Goals
:-------------------|:-------------------|:----
Pogba               |Manchester United   |66
Willian             |Chelsea             |103
Salah               |Liverpool           |171
Aubameyang          |Arsenal             |266
Neymar              |PSG                 |311
Benzema             |Real Madrid         |329
Lewandowski         |Bayern Munich       |423
Zlatan              |AC Milan            |485
Ronaldo             |Juventus            |636
Messi               |Barcelona           |644

This second table, basically another array in memory, lists another group of top soccer players along with the team they are playing on and the total number of goals scored at club level.

Player              |Team                |Goals
:-------------------|:-------------------|:----
Martial             |Manchester United   |93
Immobile            |Lazio               |203
Kane                |Tottenham           |204
Vardy               |Leicester City      |192
Mbappe              |Paris Saint-Germain |121
Rashford            |Manchester United   |67
Jimenez             |Wolves              |114
Sterling            |Manchester City     |122
Lukaku              |Inter               |216
Mane                |Liverpool           |153


This time and using the same bubble sort subroutine the table is sorted in descending order according to the number of goals scored by the player.

Player              |Team                |Goals
:-------------------|:-------------------|:----
Lukaku              |Inter               |216
Kane                |Tottenham           |204
Immobile            |Lazio               |203
Vardy               |Leicester City      |192
Mane                |Liverpool           |153
Sterling            |Manchester City     |122
Mbappe              |Paris Saint-Germain |121
Jimenez             |Wolves              |114
Martial             |Manchester United   |93
Rashford            |Manchester United   |67


And last but not least, the answer to the question who is the best soccer player on the planet is no other than Lionel Messi. lol

And yes, I am a soccer fan!
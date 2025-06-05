extends Node

var currentlevel = 1
var playerhp = 100

#-------doors-----------

var numberofdoors = 3

#typenya 1 2 3
#type 1 emptydoor type2 stripedoor type3 reddoor
var door1type = 1
var door2type = 2
var door3type = 3

#var isdoor1open = 0
#var isdoor2open = 0
#var isdoor3open = 0
var arraydooropen = [0,0,0,0]
#arraydooropen [1] berarti door1open 

var currentdoor = 0
var previousdoortype = 0 #untuk generate chance apakah ada treasure enemy atau apa

#-------enemy---------
var isenemyexist = [0,0,0,0]
#posisi enemy kalau satu berarti di pintu tengah [0,0,1,0]
#kalau ada dua enemy berarti di kanan kiri [0,1,0,1]
#kalau ada tiga enemy semua [0,1,1,1]
#enemy 1 tipe 1
#enemy 2 tipe 2 misal [0,1,2,3] berarti ada tiga enemy, masing2 beda tipe

#ini position ya kalau 1 berarti di door kiri
var currentenemy = 0
var currentenemytype = 2

var enemydefeated = 0 #jumlah enemy defeated

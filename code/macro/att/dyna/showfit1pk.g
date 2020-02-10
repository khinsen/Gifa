; showfit1pk.g $data_typ
;
; calculate and show the fitted curve on (10*$nbexp) points
;

set data_typ = $_

if (($data_typ s! "R1") & ($data_typ s! "R2") & ($data_typ s! "T1") & ($data_typ s! "T2") & ($data_typ s! "J")) then
  alert ("Wrong data type for displaying fit !")
  goto fin
endif

disp1d 1

; draw the fit curve
dim 1
set sc = ($scale*65/abs($integ[1]))
set vh = (100*$vheight)
set nbfit = (10*$nbexp) chsize $nbfit
set stosc = $scolor
scolor 3

; determine the scale of x axis
for i = 1 to $si1_1d
  set pari = ($paramx[$nbexp]*$i/$nbfit) 
  setval $i ($pari)
endfor
put tab 
zero refmacro 1 
set stounit = $unit unit t
clear 0 

set fftmp = ('gifa' // int(100000*$random))
open $fftmp
fprint $fftmp ';temporary file created by showexp'
fprint $fftmp 'set x = $_'
fprint $fftmp ('return (' // $exp // ')' )
close $fftmp

; calculate the first point of the curve
set i = 1
set pari = ($paramx[$nbexp]*$i/$nbfit) 
@($fftmp) $pari
set tmp = $returned
set y = ($vh + $sc*$tmp)
;print ($tmp ; $i)

; calculate the other points
for i = 2 to $si1_1d
;  set pari = (($paramx[$nbexp]+100)*$i/$nbfit) 
  set pari = ($paramx[$nbexp]*$i/$nbfit) 
  @($fftmp) $pari
set tmp = $returned
; print ($tmp ; $i ; $pari ; (-$R1*$pari))
  set y2 = ($vh + $sc*$tmp)
;  print ($pari ; $tmp ; "showline";($i-1); $y; $i; $y2)
  showline ($i-1) $y $i $y2
  set y = $y2
endfor

sh ('/bin/rm'; $fftmp)

; show experimental points with error bars
scolor 2
for i = 1 to $nbexp
;  set indx = ($paramx[$i]*$nbfit/($paramx[$nbexp]+100))
  set indx = ($paramx[$i]*$nbfit/$paramx[$nbexp])
  set y = ($vh + $sc*$integ[$i])
  set r = ($sc*$error[$i])
;  showtext 'X' $indx $y
;  print ($i ; $pari )
  showline ($indx-0.5) ($y-2) ($indx+0.5) ($y+2) 
  showline ($indx-0.5) ($y+2) ($indx+0.5) ($y-2) 
  showline $indx ($y-$r) $indx ($y+$r) 
  showline ($indx-0.5) ($y-$r) ($indx+0.5) ($y-$r) 
  showline ($indx-0.5) ($y+$r) ($indx+0.5) ($y+$r) 
endfor
scolor $stosc

refmacro 0
clear 1
unit $stounit unref

=fin 




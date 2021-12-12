program zmejka;
uses crt;
  const LX=20; LY=20; dif=0;
var rej,dx,dy,n,j,z,xa,ya: integer; f: Boolean; k:char;
  nmax: array[1..3] of integer;
  X: array[1..LX*LY] of integer;
  Y: array[1..LX*LY] of integer;
     procedure form;
     var i:integer;
     begin
        clrscr;
        if (rej=1) then begin
        for i:=2 to LY+1 do begin gotoXY(LX+1,i); write ('|'); end;
        for i:=2 to LX+1 do begin gotoXY(i,LY+1); write ('-'); end;
        for i:=2 to LY+1 do begin gotoXY(1,i); write ('|'); end;
        for i:=2 to LX+1 do begin gotoXY(i,1); write ('-'); end;
        gotoXY(1,1); write ('/');
        gotoXY(LX+1,LY+1); write ('/');
        gotoXY(1,LY+1); write ('\');
        gotoXY(LX+1,1); write ('\');
        gotoXY(LX+5,10); write('score'); gotoXY(LX+5,12); write(0);
        gotoXY(LX+5,4); write('score MAX'); gotoXY(LX+5,6); write(nmax[rej]-1);end; {оформление}
        if (rej<>1) then begin
        for i:=2 to LY+1 do begin gotoXY(LX+1,i); write ('-'); end;
        for i:=2 to LX+1 do begin gotoXY(i,LY+1); write ('|'); end;
        for i:=2 to LY+1 do begin gotoXY(1,i); write ('-'); end;
        for i:=2 to LX+1 do begin gotoXY(i,1); write ('|'); end;
        gotoXY(1,1); write ('\');
        gotoXY(LX+1,LY+1); write ('\');
        gotoXY(1,LY+1); write ('/');
        gotoXY(LX+1,1); write ('/');
        gotoXY(LX+5,10); write('score'); gotoXY(LX+5,12); write(0);
        gotoXY(LX+5,4); write('score MAX'); gotoXY(LX+5,6); write(nmax[rej]-1);end;
     end;
begin
  nmax[1]:=1; nmax[2]:=1; nmax[3]:=1; 

  repeat
    clrscr; gotoXY(1,2); write('score MAX rejim 1'); gotoXY(1,4); write(nmax[1]-1);
        gotoXY(1,8); write('score MAX rejim 2'); gotoXY(1,10); write(nmax[2]-1);
      gotoXY(1,20);
      write ('rejim(1/2)'); repeat k:=readkey; until (k='1') or (k='2'); if (k='1') then rej:=1 else rej:=2;
    form;
  randomize; 
  n:=1; 
  X[1]:= 3 + random(LX-5);
  Y[1]:= 3 + random(LY-5);
  xa:= LX div 4 + random(LX div 2);ya:= LY div 4 + random(LY div 2);
  gotoXY(X[1],Y[1]); write ('x');
  gotoXY(xa, ya); write ('$');
  f:=true;
   {задание начальных данных}
  dx:=0; dy:=0;
  
  repeat
      gotoXY(LX+2, LY+1);
    

    {проверка}
    if n< 25 then delay (60-2*n) else delay (10);

         if keypressed then begin k:=readkey;
      if (k='s') and (dy<>-1) then begin dx:=0; dy:=1; end;
      if (k='w') and (dy<>1) then begin dx:=0; dy:=-1; end;
      if (k='d') and (dx<>-1) then begin dx:=1; dy:=0; end;
      if (k='a') and (dx<>1) then begin dx:=-1; dy:=0; end; end; {задание движения}
      delay (60+dif*10);

      z:=1;
      gotoXY(X[n],Y[n]); write (' ');
    while z<n do begin
      X[n-z+1]:= X[n-z];
      Y[n-z+1]:= Y[n-z];
      z:=z+1;
    end;
      X[1]:= X[1]+dx;
      Y[1]:= Y[1]+dy;
      if (rej<>1) then begin if (X[1]=LX+1) then X[1]:=2; if (Y[1]=LY+1)then Y[1]:=2; if (X[1]=1) then X[1]:=LX; if (Y[1]=1) then Y[1]:=LY; end else
           if (X[1]>=LX+1) or (Y[1]>=LY+1)or (X[1]<=1) or (Y[1]<=1) then f:=false;   
    if n>3 then
    for z:=4 to n do if (X[1]=X[z]) and(Y[1]=Y[z]) then f:=false;
      gotoXY(X[1],Y[1]); if f=true then write ('x') else write ('Ж');
      if (X[1]=xa) and (Y[1]=ya) then begin
         n:=n+1; if (n<(LX-2-2*dif)*(LY-2-2*dif)) then begin
         repeat
           j:=0;
          xa:= 2 + dif + random(LX-2-dif*2);ya:= 2 + dif + random(LY-2-dif*2);
           for z:=1 to n do if (xa=X[z]) and (ya=Y[z]) then j:=1;
         until (j=0); end else f:=false; 

         gotoXY(xa, ya); write ('$'); end;
         gotoXY(LX+5,12); write(n-1);
         if n>nmax[rej] then begin nmax[rej]:=n; gotoXY(LX+5,6); write(nmax[rej]-1); end;
  until f=false;
  gotoXY(LX+5,LY);
  write('end');
  delay (240); write ('.'); delay (240); write ('.'); delay (240); write ('.');
  if (n>=(LX-2-2*dif)*(LY-2-2*dif)) then write ('WIN') else write ('wasted');
  gotoXY(1,LY+3);
  writeln ('press R to restart or Q to exit'); repeat k:=readkey; until (k='q') or (k='r');
  until (k='q');
end.
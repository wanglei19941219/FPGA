clear all ;
N=256;
a=0:255;
sin_data=sin(2*pi*(a/N));
fixed_words=sin_data*127;
sin_p_wave=fix(fixed_words);
for i=1:N
   if sin_p_wave(i) < 0
       sin_p_wave(i)=N+sin_p_wave(i);
   else
       sin_p_wave(i)=sin_p_wave(i);
   end
end
x=[a;sin_p_wave];
fid=fopen('ram.txt','w+');
fprintf (fid,'%d %d\n',a,sin_p_wave);
% fprintf (fid,'%d : %d;\n',x);
fclose(fid);
type ram.txt;

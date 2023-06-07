%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STP - Projekt 2 - dane nr 13
% Autor - Denys Fokashchuk
% Zadanie 3.b - Wyznaczenie parametrów dyskretnego regulatora PID
% 
% UWAGA!
% Przed włączeniem skryptu należy uruchomić skrypt zad1.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% UWAGA!
% Przed włączeniem skryptu należy uruchomić skrypt zad1.m, zad3_ZN.m

close all;

k_count = 1000;

y_zad = zeros(1,k_count);
y_zad(13:k_count) = 1;
y=zeros(1,k_count);
u=zeros(1,k_count);
e=zeros(1,k_count);

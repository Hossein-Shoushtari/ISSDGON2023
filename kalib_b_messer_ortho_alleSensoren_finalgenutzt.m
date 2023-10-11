%code by: Thomas Willemsen
clear all
close all
clc


D = importdata('calib_Platine_2.txt');

g = 9.8137;


for ii = 0:9
    ax = D(:,2+8*ii); % 10, 18, 26, 34 ...
    ay = D(:,3+8*ii);
    az = D(:,4+8*ii);

    % N??herung f??r Unbekannte
    mx = 1;
    my = 1;
    mz = 1;
    bx = 0;
    by = 0;
    bz = 0;
    rxy = 0;
    rxz = 0;
    ryz = 0;


    % 0. Funktionaler Zusammenhang

    % g^2 = (ax.*mx+rxy.*ay+rxz.*az + bx)^2 + (ay.*my+az.*ryz + by)^2 +
    % (az.*mz + bz)^2 % 9 parameter bias + scale + orthgonalit?t
    
    % g^2 = (ax.*mx + bx)^2 + (ay.*my+ by)^2 + (az.*mz + bz)^2 % 6
    % parameter bias + scale

    % Optional mit Orthogonalit??ten, siehe Mitschriften
    for i = 1:100
            % 1. Funktionales Modell
            x_anteil = (ax.*mx+rxy.*ay+rxz.*az + bx);
            y_anteil = (ay.*my+az.*ryz + by);
            z_anteil = (az.*mz + bz);
            l(1:length(D),1) = g^2;
            l0 = x_anteil.^2 + y_anteil.^2 + z_anteil.^2;
            dl = l - l0;
            if i == 1
                figure(1)
                plot( dl)
                xlabel('ID of measurement')
                ylabel('Difference: g?_{reference} - g?_{measurement}')
                %fontsize(16,"points")
                Mittel_dlvor = mean(dl)
            end

             A(1:length(x_anteil),1) = ax.*2.*x_anteil; % mx
             A(1:length(x_anteil),2) = 2.*x_anteil; % bx
             A(1:length(x_anteil),3) = ay.*2.*y_anteil; % my
             A(1:length(x_anteil),4) = 2.*y_anteil; % by
             A(1:length(x_anteil),5) = az.*2.*z_anteil; % mz
             A(1:length(x_anteil),6) = 2.*z_anteil; % bz
  %%%%% 1 von 2: HIER uncomment folgende drei Zeilten f?r 9 Parameter                                                                                               A(1:length(x_anteil),6) = 2.*z_anteil; % bz
             A(1:length(x_anteil),7) = ay.*2.*x_anteil; % rxy
             A(1:length(x_anteil),8) = az.*2.*x_anteil; % rxz
             A(1:length(x_anteil),9) = az.*2.*y_anteil; % ryz

            % 2. Stochastisches Modell
            if i == 1
                E = eye(length(D));
                P = E;
            end
%%% 1 von 2: HIER Grobe Fehler durch Bewegung entfernen 
            if i == 4 
              ID_fehler =   find(abs(dl)>1.5);
              ID_fehlerfrei =   find(abs(dl) <= 1.5);
              AnzahlMessungen = length(l)
              AnzahlgroberAbweichungen = length(ID_fehler)
              p(1:length(E)) = 1;
              p(ID_fehler) = 0;
              P = diag(p);
              P(length(E),length(E)) = 0;
            end




            % 3. Berechnung
            N = A'*P*A;
            n = A'*P*dl;
            Qx = inv(N);
            dx = Qx*n;

             mx = mx + dx(1);
             bx = bx + dx(2);
             my = my + dx(3);
             by = by + dx(4);
             mz = mz + dx(5);
             bz = bz + dx(6);

%%%%% 2 von 2: HIER uncomment folgende drei Zeilten f?r 9 Parameter 
             rxy = rxy + dx(7);
             rxz = rxz + dx(8);
             ryz = ryz + dx(9);



            if max(abs(dx)) < 0.00000000000001
                dx
                i
                x_anteil = (ax.*mx+rxy.*ay+rxz.*az + bx);
                y_anteil = (ay.*my+az.*ryz + by);
                z_anteil = (az.*mz + bz);
                l0 = x_anteil.^2 + y_anteil.^2 + z_anteil.^2;
                dl = l - l0;
                %% 2 von 2: HIER Grobe Fehler durch Bewegung entfernen 
                figure(2)
                plot(dl(ID_fehlerfrei))
                xlabel('ID of measurement')
                ylabel('Difference: g?_{reference} - g?_{measurement}')
                %fontsize(16,"points")
                Mittel_dlnach = mean(dl)
                [bx by bz];
                [mx my mz];
                [rxy rxz ryz];

                break
            end



    end

    % 4. Proben
    Vausg = A*dx-dl;

    Rechenprobe  = A'*P*Vausg;
    Vergleich = -dl - Vausg;


    % 5. Genauigkeiten
    [z s] = size(A);
    S0 = sqrt((Vausg'*P*Vausg)/(z-s))
    Sx = sqrt(diag(Qx))*S0;

    % 6. Data Snopping

    % 7. Robuste Ausgleichung

    disp(['Sensor: ' num2str(ii)])
    disp([mx bx my by mz bz rxy rxz ryz Sx'])
    pause(0.2)
    dlmwrite('kalibpara_9.txt', [mx bx my by mz bz rxy rxz ryz Sx'], '-append','delimiter', ' ', 'precision', '%.6f')
    
    clear A N Qx P p ax ay az S0 Sx l l0 x_anteil y_anteil z_anteil Vausg dx dl Vergleich Rechenprobe ID_fehler ID_fehlerfrei
 end

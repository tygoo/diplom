while 1
%folder-n file uudiin listiig todorhoiloh
cd ('C:\xampp\htdocs\touch\searcher');
 folderContents = dir;
 folderContents = folderContents(~ismember({folderContents.name}, {'.', '..'}));
 for k=1:length(folderContents)
       if folderContents(k).isdir
           myFolder = fullfile(pwd, folderContents(k).name);
           fprintf('%s\n',myFolder); % or perform task
       end
 end
%folder-n hamgiin suuld orj irsen ugugdliig oloh ---------------
   dates = [folderContents.datenum];
   [~, newestIndex] = max (dates);
   folderContents(newestIndex);
   folderContents.date % will display long list of files and stuff, consider deleting...
   newest = folderContents(newestIndex(end)).name;
%read newest file
   next_value = newest;
   if ~strcmp(next_value,pre_value)
       close all;
          fileID = fopen(newest,'r');
           formatSpec = '%s';
           k = fscanf(fileID, formatSpec);
        %check newest file in folder, get data from server 
        data = strsplit(k,'+');
        name = data(1);
        z_axis = data(2);
        method = data(3);
        I_width = data(4);
        I_height = data(5);
        direct = char('C:\xampp\htdocs\touch\uploads\');
        direction = strcat(direct,name,'.bmp');

        if str2double(method) == 0
            tic
            A = imread(char(direction)); 
            figure(1);
            imshow(A);
            Pl=5; g=11; zz=str2double(z_axis);   % 10x10 lens array
            W=str2double(I_width);               % II image size [mm]
            H=str2double(I_height); 
            pd=0.284;
            pi=(pd*zz)/g;
            [rows,columns,z]=size(A);
            B=zeros(round(H/pd),round(W/pd),3);
            B = uint8(B);
            for i=1:rows
                for j=1:columns
                    for x=1:round(H/Pl)
                        for y=1:round(W/Pl)
                            rr=i*pi;
                            cc=j*pi;
                            XX=(Pl*(x-0.5)-((g/zz)*(cc-Pl*(x-0.5))));
                            YY=(Pl*(y-0.5)-((g/zz)*(rr-Pl*(y-0.5))));
                            if Pl*(y-1) <=YY && YY< Pl*y && Pl*(x-1) <=XX && XX< Pl*x
                                N=round(YY/pd);
                                M=round(XX/pd);
                                if N>0 && M>0
                                    B(N,M,:)= A(i,j,:);
                                end
                            end
                        end
                    end
                end
            end
            t=toc;
            figure(3);
            imshow(B);
           % imwrite(B, 'C:\xampp\htdocs\touch\created_image_research\elemental_image_rec_con4.bmp');

        else

             %%%%%% niilmel dursen delgetsiin huvid shine argaar tegsh onstogt lesniii elemental image hurdan
            %%%%%% uusgeh 
            %% imput parameters
            tic
            PD=0.284;   % pitch of display [mm]
            g1=11;             % gap [mm]
            W=str2double(I_width);               % II image size [mm]
            H=str2double(I_height);               % II image size [mm]
            z=str2double(z_axis); % Delgetsees CDP havtgai hurtleh zai
            PI1=PD*z/g1 ;         % pixel size of image
            pl=5;
            IN = imread(char(direction));
            %figure(1);
            %imshow(IN);

            %%
            J=round(H/pl);
            I=round(W/pl);

            %% 
            [h w col]=size(IN);
            EI=zeros(round(H/PD),round(W/PD),3);
            EI = uint8(EI);   
                for y=1:round(H/PD)
                    yc = pl *((fix((y*PD)/pl)+1)-0.5);
                    v=round((yc+(yc-y*PD)*(z/g1))*(1/PI1));
                    for x=1:round(W/PD)
                        xc = pl *((fix((x*PD)/pl)+1)-0.5);
                        u=round((xc+(xc-x*PD)*(z/g1))*(1/PI1));
                        if v>=1 && u>=1 && v<=h && u<=w
                            if IN(v,u,:) == 0
                            else
                                EI(y,x,:)=IN(v,u,:);
                            end
                        end       
                     end
                end
            t = toc
            figure(1);
            imshow(uint8(EI));
            %imwrite(EI, 'C:\xampp\htdocs\touch\created_image_research\elemental_image_rec_fast4.bmp');
        end
        clearvars -except pre_value next_value;
   end
      pre_value = next_value;
       clearvars -except pre_value next_value;
end
       
       
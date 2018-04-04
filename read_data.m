%folder-n file uudiin listiig todorhoiloh
clear;
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

  fileID = fopen(newest,'r');
   formatSpec = '%s';
   k = fscanf(fileID, formatSpec);
%check newest file in folder, get data from server 
data = strsplit(k,'+');
name = data(1);
z_axis = data(2);
method = data(3);
direct = char('C:\xampp\htdocs\touch\uploads\');
direction = strcat(direct,name,'.bmp');

if str2double(method) == 0
    A = imread(char(direction)); 
    figure(1);
    imshow(A);
    Pl=5; g=15; zz=str2double(z_axis);   % 10x10 lens array
    pd=0.284;
    pi=(pd*zz)/g;
    [rows,columns,z]=size(A);
    tic
    for i=1:rows
        for j=1:columns
    %       if A(i,j,:)~=0
            for x=1:15
                count = 0;
                for y=1:15
                    rr=i*pi; %1pixel  0.18
                    YY=(Pl*(y-0.5)-((g/zz)*(rr-Pl*(y-0.5))));
                    cc=j*pi;
                    if count == 0
                    XX=(Pl*(x-0.5)-((g/zz)*(cc-Pl*(x-0.5))));
                    count = 1;
                    end 
                    if Pl*(y-1) <=YY && YY< Pl*y && Pl*(x-1) <=XX && XX< Pl*x
                        N=round(YY/pd);
                        M=round(XX/pd);
                        if N>0 && M>0
                            B(N,M,:)= A(i,j,:);
                        end
                    end
                end
            end
    %       end
        end
    end
    t=toc;
    figure(3);
    imshow(B);
    imwrite(B, 'C:\xampp\htdocs\touch\created_image_1\elemental_image_rec_con2.bmp');

else
    
     %%%%%% niilmel dursen delgetsiin huvid shine argaar tegsh onstogt lesniii elemental image hurdan
    %%%%%% uusgeh 
    %% imput parameters
    PD=0.284;   % pitch of display [mm]
    g1=15;             % gap [mm]
    W=75;               % II image size [mm]
    H=75;               % II image size [mm]
    z=str2double(z_axis); % Delgetsees CDP havtgai hurtleh zai
    PI1=PD*z/g1 ;         % pixel size of image
    pl=5;
    IN = imread(char(direction));
    figure(1);
    imshow(IN);

    %%
    J=round(H/pl);
    I=round(W/pl);

    %% 
    [h w col]=size(IN);
    EI=zeros(round(H/PD),round(W/PD),3);
    EI = uint8(EI);
    tic    
        for y=1:round(H/PD)
            yc = pl *((fix((y*PD)/pl)+1)-0.5);
            for x=1:round(W/PD)
                 xc = pl *((fix((x*PD)/pl)+1)-0.5);
                        u=round((xc+(xc-x*PD)*(z/g1))*(1/PI1));
                        v=round((yc+(yc-y*PD)*(z/g1))*(1/PI1));
                        if v>=1
                            if u>=1
                                if v<=h 
                                    if u<=w
                                        if IN(v,u,:)~=0;
                                            EI(y,x,:)=IN(v,u,:);
                                        end
                                    end
                                end
                            end
                        end       
                end
        end
    t = toc
    figure(1);
    imshow(uint8(EI));
    imwrite(EI, 'C:\xampp\htdocs\touch\created_image_1\elemental_image_rec_fast2.bmp');
end
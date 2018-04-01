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
    Pl=5; g=12.5; zz=str2double(z_axis);   % 10x10 lens array
    pd=0.18;
    pi=(pd*zz)/g;
    [rows,columns,z]=size(A);
    tic
    for i=1:rows
        for j=1:columns
    %       if A(i,j,:)~=0
            for x=1:10
                count = 0;
                for y=1:10
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
    imwrite(B, 'C:\xampp\htdocs\touch\created_image\elemental_image_rec_tra1.bmp');

else
    
     %%%%%% niilmel dursen delgetsiin huvid shine argaar tegsh onstogt lesniii elemental image hurdan
    %%%%%% uusgeh 
    %% imput parameters
    PD=0.18;   % pitch of display [mm]
    g=12.5;             % gap [mm]
    W=50;               % II image size [mm]
    H=50;               % II image size [mm]
    z=str2double(z_axis); % Delgetsees CDP havtgai hurtleh zai
    PI=PD*z/g ;         % pixel size of image
    pl=5;
    IN = imread(char(direction));
    figure(1);
    imshow(IN);

    %%
    J=round(H/pl);
    I=round(W/pl);

    %% lens tov oloh
    tic
    for j=0:J
        ym=pl*((j+1)-0.5);
        for i=0:I
             xm=(pl*((i+1)-0.5));
             cen_Y(j+1,i+1)=ym;
             cen_X(j+1,i+1)=xm;

        end 
    end 


    clear  xm ym

    t = toc
    %%
    tic     
    [h w col]=size(IN);
    EI=zeros(round(H/PD),round(W/PD),3);
    EI = uint8(EI);

        for y=1:round(H/PD)
            for x=1:round(W/PD)

    %********** start ************ toviig todorhoilno tuhain tsegtei hamgiin oir **************************        

                temp_y=cen_Y-y*PD;
                temp_x=cen_X-x*PD;

                temp=(temp_x.^2+temp_y.^2).^0.5;
                [a b]=find(temp==min(min(temp)));

                        yc=cen_Y(a(1,1),b(1,1));
                        xc=cen_X(a(1,1),b(1,1));

    %********** start ********** EI->II calculate  ************************** 

                        u=round((xc+(xc-x*PD)*(z/g))*(1/PI));
                        v=round((yc+(yc-y*PD)*(z/g))*(1/PI));

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
    imwrite(EI, 'C:\xampp\htdocs\touch\created_image\elemental_image_rec_tra1.bmp');
end



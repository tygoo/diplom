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
   A = fscanf(fileID, formatSpec);
%check newest file in folder, get data from server 
data = strsplit(A,'+');
name = data(1);
z_axis = data(2);
method = data(3);
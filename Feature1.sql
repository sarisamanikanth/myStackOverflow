Create or Replace Procedure CreateAccount(User_ID Varchar2,Pwd Varchar2,Name Varchar2,Mail Varchar2,Country Varchar2)
AS 
UsrID Varchar2(30);
Status Varchar2(20):='Active';
Begin
Select Count(UserID) into UsrID from Users Where UserID=User_ID;
If (UsrID is not null and UsrID!=0) Then
Dbms_Output.Put_Line('Username: '||User_ID|| ' already exists. User a different username');
Else
INSERT INTO Users(UserID,Password,Name,Email,Country,CreationTime) Values(User_ID,Pwd,Name,Mail,Country,systimestamp);
INSERT INTO RegularUser(UserID,Status) Values(User_ID,Status);
Dbms_Output.Put_Line('New account with Username: ' || Name || ' is created.');
End If;
End;


Exec CreateAccount('AniurdhAkkati','AkkatiA','Anirudh','Anirudh@gmail.com');


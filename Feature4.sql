Create or Replace Type TagListType as varray(5) of varchar2(20);

Create Or Replace Function getTagID(Tag_Name Varchar2)
Return Integer
AS
Tag_ID Integer;
Begin
Select TagID into Tag_ID from Tags where UPPER(TagName)=Upper(Tag_Name);
If (Tag_ID is not null) then
return Tag_ID;
End If;
Exception When no_data_found then
return 1;
End;


Create or Replace Function RegularUserTagCount(User_ID Varchar2)
return Integer
As
UserTagCount Integer;
Begin
Select Count(TagID) into UserTagCount From UserTags where UserID=User_ID;
Return UserTagCount;
End;


Create or Replace Procedure UserTag(User_ID Varchar2,Pwd Varchar2,TagList TagListType)
As
UserTagCount Integer;
UserTagID Integer;
Tag_ID Integer;
Account_Status Varchar2(40); --Variable to store AccountStatus.
Begin
Account_Status:=CheckAccount(User_ID,Pwd); --Call CheckAccount Function and check the validity of the user.
If(Account_Status='Login Successful') Then
  UserTagCount:=RegularUserTagCount(User_ID);
  If(UserTagCount=5) Then 
     Dbms_output.Put_line('You can add only 5 skills in your expertise');
  ElsIF(UserTagCount<=5)Then
     For I in 1..TagList.Count --Loop to check and add the Tags to the User expertise.
     Loop
     Tag_ID:=getTagID(TagList(I)); --Call the function getTagID to retrieve TagID.
      If(Tag_ID=1) Then --If the Tag is new one, add to the Tags table and then to the UserTag Table.
               Insert into Tags(TagID,TagName) Values(TagID_seq.Nextval,TagList(I));
               Insert Into UserTags(UserID,TagID) Values(User_ID,TagID_seq.currval);
               Dbms_Output.Put_Line(TagList(I)||' added to your expertise');
           ElsIF(Tag_ID is not null) Then --Check if the given is already present in the UserTag table.
                Select Count(TagID) into UserTagID From UserTags Where TagID=Tag_ID and UserID=User_ID;
                    If(UserTagID=0) Then
                        Insert Into UserTags(UserID,TagID) Values(User_ID,Tag_ID);
                        Dbms_Output.Put_Line(TagList(I)||' added to your expertise');
                    Else
                       Dbms_output.Put_line(TagList(I)||' is already present in your expertise'); --Print error statement if the tag already exists in the database.
                    End If;  
        End If;
        UserTagCount:=RegularUserTagCount(User_ID); --Call the Function RegularUserTagCount to get the count of UserTags for a User.
        If(UserTagCount=5) Then 
        Dbms_output.Put_line('You can add only 5 skills in your expertise');
        Exit When UserTagCount=5;--Print error statement if User is trying to add more than 5 tags.
        End If; 
      End Loop;
    End If;  
Else
 Dbms_Output.Put_Line(User_ID||' '||Account_Status); --Print User Account Status if not active.
End If;
End;

Exec UserTag('PhaniM1','mav2',TagListType('Node.js','JAVA','Cobol','SAS')); 
 


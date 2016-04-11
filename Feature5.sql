Create or Replace Type TagListType as varray(5) of varchar2(20);


Create Or Replace Function getTagID(Tag_Name Varchar2)
Return Integer
AS
Tag_ID Integer;
Begin
Select TagID into Tag_ID from Tags where TagName=Tag_Name;
If (Tag_ID is not null) then
return Tag_ID;
End If;
Exception When no_data_found then
return 1;
End;


Create or Replace Procedure PostQuestion(User_ID Varchar2,Pwd Varchar2,Question Varchar2,TagList TagListType)
AS
Tag_ID Integer;
Account_Status Varchar2(40);
Begin
Account_Status:=CheckAccount(User_ID,Pwd);
If(Account_Status='Login Successful') Then 
  Insert into Questions(QuestionID,UserID,QuestionDesc,PostingTime) Values(QuestionID_seq.nextval,User_ID,Question,systimestamp);
  For I in 1..TagList.Count
  Loop
  Tag_ID:=getTagID(TagList(I));
  If(Tag_ID =1) Then
  Insert into Tags(TagID,TagName) Values(TagID_seq.nextval,TagList(I));
  Insert into QuestionTags(QuestionID,TagID) Values(QuestionID_seq.currval,TagID_seq.currval);
  Elsif (Tag_ID!=1) Then
  Insert into QuestionTags(QuestionID,TagID) Values(QuestionID_seq.currval,Tag_ID);
  End If;
  End Loop;
  Dbms_Output.Put_Line('Question posted successfully');
Else 
Dbms_Output.Put_Line(User_ID||' '||Account_Status||'. User account needs to be active to post a question');
End If;
End;


Exec PostQuestion('Vineeth','Vinny1993','i cannot retrieve sql rows in java where one of the rows is NULL',TagListType('JAVA','MYSQL','JTABLE'));

Exec PostQuestion('BinilB','Binil1990','Store vector result from a loop into matrix when the dimension in unkown in R',TagListType('R'));
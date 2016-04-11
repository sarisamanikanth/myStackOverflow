
Create or Replace Procedure Top3Users(Question_ID Integer)
As
Tag_ID Tags.TagID%Type;
Question_Status Questions.QuestionStatus%type;
Cursor C1 is Select TagID from QuestionTags Where QuestionID=Question_ID;
Begin
Question_Status:=getQuestionStatus(Question_ID);
If(Question_Status='Active') Then
  Open C1;
   Loop
   Fetch C1 into Tag_ID;
   Exit When C1%NotFound;
   QuesTags(Tag_ID);
   End Loop;
  Close C1;
Else
 Dbms_Output.Put_Line('Question in closed');
End If;
Exception 
When No_Data_Found Then
Dbms_Output.Put_Line('Given QuestionID: '||Question_ID||' not found');
End;

Exec Top3Users(5);


Create or Replace Function getQuestionStatus(Question_ID Integer)
Return Varchar
AS
Status Questions.QuestionStatus%type;
Begin
Select QuestionStatus into Status from Questions Where QuestionID=Question_ID;
If(Status='Active')
Then 
return Status;
Else
return 'Closed';
End If;
End;


Create or Replace Procedure QuesTags(Tag_ID Integer)
AS
User_Name Users.Name%type;
Tag_Name Tags.TagName%Type;
Cursor C1 is Select Name into User_Name from (Select Name from Users U, RegularUser R,UserTags T Where U.UserID=R.UserID and R.UserID=T.UserID and T.TagID=Tag_ID order by R.ReputationScore desc) where  rownum <=3;
Begin
   Select TagName into Tag_Name from Tags where TagID=Tag_ID;
   Dbms_Output.Put_Line('Top-3 Users for '||Tag_Name||' are:');
   Open C1;
   Loop  
   Fetch C1 into User_Name;
   If User_Name is Null Then
   Raise No_data_Found ;
   Else 
   Exit When C1%NotFound;
   Dbms_Output.Put_Line(User_Name);
   End If;
   End Loop;
   Close C1;
Exception When No_data_Found Then
Dbms_Output.Put_Line('No user(s) found for the tag: '||Tag_Name);
End;

Create or Replace Procedure ActiveQuestions(Tag_Name in Varchar2) 
AS
Question_Desc Long;
Cursor C1 is Select QuestionDesc From Questions Q, QuestionTags T where Q.QuestionID=T.QuestionID and Q.QuestionStatus='Active' and T.TagID in (Select TagID from Tags where TagName=Tag_Name) order by Q.PostingTime ;
Begin
Dbms_output.put_line('List of active questions with tag "'||Tag_Name||'" are as belows:');
Open C1;
Loop
Fetch C1 into Question_Desc;
Exit When C1%NotFound;
Dbms_output.put_line(Question_Desc);
End Loop;
Close C1;
Exception 
When no_data_found Then
Dbms_output.put_line('No Active Questions');
End;

Exec ActiveQuestions('SQL');

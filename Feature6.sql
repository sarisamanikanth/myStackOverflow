Create or Replace Procedure QuestionDetails(Question_ID Integer)
As
User_ID Users.UserID%Type;
Question_Status Questions.QuestionStatus%type;
Question_Desc Questions.QuestionDesc%type;
Posting_Time Timestamp;
No_Answers_Found Exception;
AnswerDesc Long;
Cursor C1 is Select A.Answer From Answers A Where A.QuestionID=Question_ID Order by A.VoteCount Desc,A.PostingTime Desc;
Begin
Select UserID,QuestionDesc,PostingTime,QuestionStatus into User_ID,Question_Desc,Posting_Time,Question_Status from Questions Where QuestionID=Question_ID;
Dbms_Output.Put_Line('QuestionID: '||Question_ID|| '   Question: '||Question_Desc||'. Posting Time: '||Trunc(Posting_Time)|| ' Status:'||Question_Status||' Posted by: '||User_ID);
Open C1;
Loop
Fetch C1 into AnswerDesc;
Exit When C1%NotFound; 
If AnswerDesc is null Then 
Raise No_Answers_found;
Else
Dbms_output.put_line(AnswerDesc);
End If;
End Loop;
Close C1;
Exception 
When No_Data_Found Then 
Dbms_output.put_line('Given QuestionID does not exists');
When No_Answers_found Then
Dbms_output.put_line('No answers provided for this question');
End;


Exec QuestionDetails(3);
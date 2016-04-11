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


Create or Replace Procedure PostAnswer(User_ID in Varchar2,Pwd Varchar2,Question_ID in Integer,Answer_Desc in Long)
AS
Usr_ID Users.UserID%Type;
Question_Status Questions.QuestionStatus%type;
Account_Status Varchar2(40);
Begin
Account_Status:=CheckAccount(User_ID,Pwd);
If(Account_Status='Login Successful') Then 
Question_Status:=getQuestionStatus(Question_ID);
Select UserID into Usr_ID from Questions Where QuestionID=Question_ID;
    If(User_ID!=Usr_ID) Then 
         If(Question_Status='Closed') Then
            Dbms_Output.Put_Line('You cannot add anymore answers to this question as it was already closed.');
         Else
            Insert Into Answers(AnswerID,UserID,QuestionID,Answer,PostingTime) Values(AnswerID_seq.nextval,User_ID,Question_ID,Answer_Desc,systimestamp);
            Dbms_output.put_line('Answer Posted Succesfully');
         End If;
    Else 
      Dbms_output.put_line('You cannot answer to your own question');
    End If;
Else 
 Dbms_Output.Put_Line(Account_Status);
End If;
Exception When DUP_VAL_ON_INDEX 
Then 
Dbms_Output.Put_Line('You can post an answer only once for the question');
End;

Exec PostAnswer('AbhiG','Abhi123',12,'SELECT field,CONVERT(SUBSTRING_INDEX(field,-1),UNSIGNED INTEGER) AS num FROM table ORDER BY num');

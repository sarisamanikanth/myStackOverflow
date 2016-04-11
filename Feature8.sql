
Create or Replace Procedure AcceptAnswer(User_ID Varchar2,Pwd Varchar2,Question_ID Integer,Answer_ID Integer)
AS 
Usr_ID Users.UserID%Type;
Account_Status Varchar2(40);
Ques_ID Integer;
Question_Status Questions.QuestionStatus%type;
Begin
Account_Status:=CheckAccount(User_ID,Pwd);
If(Account_Status='Login Successful') Then 
Select UserID into Usr_ID from Questions Where QuestionID=Question_ID;
Question_Status:=getQuestionStatus(Question_ID);
   If(User_ID=Usr_ID) Then 
       If(Question_Status='Closed') Then 
           Dbms_output.put_line('Question is already closed. You cannot accept anymore answers.');
       Else 
           Select QuestionId into Ques_ID from Answers Where AnswerID=Answer_ID;
             IF(Ques_ID=Question_ID) Then
                Update Answers Set AnswerStatus='Accepted' where AnswerID=Answer_ID and QuestionID=Question_ID;
                Update Questions Set QuestionStatus='Closed', ClosingTime=systimestamp Where QuestionID=Question_ID;
                Update RegularUser Set ReputationScore=ReputationScore+15 where UserID in (Select UserID from Answers where AnswerID=Answer_ID);
                Dbms_output.put_line('Answer accepted successfully');
             Else 
                Dbms_output.put_line('QuestionID is inappropriate to the AnswerID provided. Please Check');
             End If;   
      End If;
  Else 
     Dbms_output.put_line('Only the user who posted the question can accept the answer');
  End If;
Else 
 Dbms_Output.Put_Line(Account_Status);
End If;
End;

Exec AcceptAnswer('AbhiG','Abhi123',12,15);
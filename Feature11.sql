Create or Replace Function VoteUp(User_ID Varchar,Post_ID Integer,VoteType Varchar2,PostType Varchar2)
Return Varchar2
AS 
Begin
If(PostType='Question') Then
Update Questions Set VoteCount=VoteCount+1 Where QuestionID=Post_ID;
Update RegularUser Set ReputationScore=ReputationScore+5 Where UserID in (Select UserID from Questions Where QuestionID=Post_ID);
Insert Into QuestionVotes Values(User_ID,Post_ID);
Return 'Question: '||Post_ID||' voted up successfully' ;
ElsIf(PostType='Answer')Then 
Update Answers Set VoteCount=VoteCount+1 Where AnswerID=Post_ID;
Update RegularUser Set ReputationScore=ReputationScore+10 Where UserID in (Select UserID from Answers Where AnswerID=Post_ID);
Insert Into AnswerVotes Values(User_ID,Post_ID);
Return 'Answers: '||Post_ID||' voted up successfully' ;
End IF;
End;

Create or Replace Function VoteDown(User_ID Varchar,Post_ID Integer,VoteType Varchar2,PostType Varchar2)
Return Varchar2
AS 
Begin
If(PostType='Question') Then
Update Questions Set VoteCount=VoteCount-1 Where QuestionID=Post_ID;
Insert Into QuestionVotes Values(User_ID,Post_ID);
Return 'Question: '||Post_ID||' voted down successfully';
ElsIf(PostType='Answer')Then 
Update Answers Set VoteCount=VoteCount-1 Where AnswerID=Post_ID;
Insert Into AnswerVotes Values(User_ID,Post_ID);
Return 'Answer: '||Post_ID||' voted down successfully';
End IF;
End;

Select UserID from Questions Q,Answers A Where Q.QuestionID=A.QuestionID and (Q.QuestionID=33 or A.AnswerID=33);


Create or Replace Procedure Vote(User_ID Varchar,Pwd Varchar2,Post_ID Integer,PostType Varchar2,VoteType Varchar2)
AS
UsrID Users.UserID%Type;
VoteStatus Varchar2(40);
Account_Status Varchar2(40); 
Begin
Account_Status:=CheckAccount(User_ID,Pwd); 
If(Account_Status='Login Successful') Then 
Select UserID into UsrId from Questions Where QuestionID=Post_ID;
Select UserID into UsrID from Answers Where AnswerID=Post_ID;
If(UsrID!=User_ID) Then
  If(VoteType='VoteUp') Then
     VoteStatus:=VoteUp(User_ID,Post_ID,VoteType,PostType);
     Dbms_Output.Put_Line(VoteStatus);
  elsIf(VoteType='VoteDown') Then
     VoteStatus:=VoteDown(User_ID,Post_ID,VoteType,PostType);
     Dbms_Output.Put_Line(VoteStatus);
  End If;
ElsIf(UsrID=User_ID)Then
 Dbms_Output.Put_Line('You cannot vote for your own post.');
End If;
Else 
    Dbms_Output.Put_Line(Account_Status); 
End If;
Exception When DUP_VAL_ON_INDEX 
Then 
Dbms_Output.Put_Line('You cannot vote for the same post again');
When No_data_found Then
Dbms_Output.Put_Line('Invalid Post ID.No such posts exists in the system');
End;

Exec Vote('PhaniM1','mav2',10,'Answer','VoteUp');
Exec Vote('AbhiG','Abhi123',9,'Question','VoteDown');

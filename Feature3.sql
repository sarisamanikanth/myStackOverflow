Create or Replace Procedure UsageReport(User_ID Varchar2,Pwd Varchar2,K Integer)
AS
NoOfdays Integer;
RepScore Integer;
NoOfQues Integer;
NoOfAns Integer;
NoOfActQues Integer;
NoOfActAns Integer;
NoOfAnsPosted Integer;
Account_Status Varchar2(40);
Begin
Account_Status:=CheckAccount(User_ID,Pwd);
If(Account_Status='Login Successful') Then 
Select TRUNC(systimestamp)-Trunc(CreationTime) into NoOfdays from Users Where UserID=User_ID;
Select ReputationScore into RepScore from RegularUser where UserID=User_ID;
Select Count(*) into NoOfQues from Questions Q,Users U where Q.UserID=U.UserID and Q.UserID=User_ID;
Select Count(*) into NoOfAns from Answers A,Users U where A.UserID=U.UserID and A.UserID=User_ID;
Select Count(*) into NoOfActQues from Questions Q,Users U where Q.UserID=User_ID and Q.UserID=U.UserID and Q.QuestionStatus='Active' and Q.PostingTime >(sysdate - K);
Select Count(*) into NoOfAnsPosted from Answers A,Users U where A.UserID=User_ID and A.UserID=U.UserID and A.PostingTime >(sysdate - K);
Dbms_Output.Put_Line('Welcome '|| User_ID);
Dbms_Output.Put_Line('The number of days since the user first created his/her account in the system: '||NoOfDays);
Dbms_Output.Put_Line('The current reputation score of the user: '||RepScore);
Dbms_Output.Put_Line('The number of questions that are posted by the current user: '||NoOfQues);
Dbms_Output.Put_Line('The number of answers that are provided by the current user: '||NoOfAns);
Dbms_Output.Put_Line('The number of active questions that are posted by the current user in last '||K||' days: '||NoOfActQues);
Dbms_Output.Put_Line('The number of answers that are posted by the current user in last '||K||' days: '||NoOfAnsPosted);
Else 
Dbms_Output.Put_Line(User_ID||' '||Account_Status);
End If;
Exception When no_data_found Then
Dbms_Output.Put_Line('No data found');
End;

Exec UsageReport('PhaniM1','mav2',80);

Create OR Replace Procedure UpdateTime(User_ID Varchar2,Pwd Varchar2)
As
Account_Status Varchar2(40);
Begin
Account_Status:=CheckAccount(User_ID,Pwd); --Call CheckAccount Function and check the validity of the user.
If(Account_Status='Login Successful') Then 
Update RegularUser Set Status='Inactive' Where UserID in (Select UserID from Users Where (TRUNC(systimestamp)-TRUNC(LastLoginTime))>180);
Update Questions Set QuestionStatus='Closed' Where QuestionID in (Select QuestionID from Questions Where (TRUNC(systimestamp)-TRUNC(PostingTime))>90);
End If;
End;

Exec UpdateTime;
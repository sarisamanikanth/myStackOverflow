Create or Replace Procedure UserStatusSet(User_ID Varchar2,Pwd Varchar2,RegularUserID Varchar2)
AS
Account_Status Varchar2(40);
Begin
Account_Status:=CheckAccount(User_ID,Pwd); --Call CheckAccount Function and check the validity of the user.
If(Account_Status='Login Successful') Then --Update 
Update Admin Set Status='Inactive' Where UserID=RegularUserID;
Dbms_output.put_line('User Status updated successfully'); 
End If;
Exception When No_data_Found Then
Dbms_Output.Put_Line('No user found for the given UserID');
End;

Exec AdminStatusSet('Admin','manik123');

Create or Replace Function CheckUser(UID Varchar2,Pwd Varchar2)
Return integer
AS
User_ID Users.UserID%Type;
User_Password Users.Password%Type;
AdminUser Integer;
RegUser Integer;
Begin
Select UserID,Password into User_ID,User_Password from Users Where UserID=UID;
Select Count(*) into AdminUser from Admin A,Users U where A.UserID=U.UserID and A.UserID=UID;
Select Count(*) into RegUser from RegularUser R,Users U where R.UserID=U.UserID and R.UserID=UID;
If(UID=User_ID and Pwd=User_Password)
  Then
     If(AdminUser is not null and AdminUser!=0) Then 
      return 1;
     ElsIF (RegUser is not null and RegUser!=0) Then 
      return 2;
     End IF;
End If;
Exception When No_data_found Then
 return 3;
End;


Create or Replace Function CheckAccount(User_ID Varchar2,Pwd Varchar2)
Return Varchar2
AS
Usertype Integer;
AdminStatus Admin.Status%type;
RegularUserStatus RegularUser.Status%type;
Begin
Usertype:=CheckUser(User_ID,Pwd);
IF(UserType=1) Then 
    Update Users SET LastLoginTime=systimestamp Where UserID=User_ID;
    return 'Login Successful';
ElsIf(UserType=2) Then 
 Select Status into RegularUserStatus from RegularUser where UserID=User_ID;
  If(RegularUserStatus='Active') Then 
    Update Users SET LastLoginTime=systimestamp Where UserID=User_ID;
    return 'Login Successful';
  Else 
    return 'Account is inactive. Contact Admin';
  End If;
ElsIf(UserType=3) Then
 return 'Invalid Credentials';
End If;
End;
 
Declare
Account_Status Varchar2(50);
Begin
Account_Status:=CheckAccount('djsask','djasad');
Dbms_Output.Put_Line(Account_Status);
End;

Create or Replace Procedure Top3Tags(User_ID Varchar2,Pwd Varchar2)
AS
Tag_Name Varchar2(20);
Account_Status Varchar2(40);
Cursor C1 is Select TagName from (Select T.TagName From Tags T,Questions Q,QuestionTags P where Q.UserID=User_ID and Q.QuestionID=P.QuestionID and P.TagID=T.TagID group by T.TagName order by Count(T.TagName) desc )  where rownum <=3;
Begin
Account_Status:=CheckAccount(User_ID,Pwd);
If(Account_Status='Login Successful') Then 

   Open C1;
    Dbms_output.put_line('Top-3 frequent tags used by the User: ' ||User_ID);
     Loop 
     Fetch C1 Into Tag_Name;
     Exit when C1%NOTFOUND;
     Dbms_output.put_line(Tag_Name); 
  END Loop;
  If (C1%rowcount=0) Then
     Dbms_output.put_line(User_ID||' has not posted any question yet.');
     End If;
 Close C1;
Else 
 Dbms_Output.Put_Line(Account_Status);
End If;
End;

    
Exec Top3Tags('PhaniM1','mav2');
Exec Top3Tags('Prashant','PrashantS');
Exec Top3Tags('BinilB','Binil1990');
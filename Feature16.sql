

Create or Replace PROCEDURE SearchQuestion (Keyword Varchar2) AS
KeywordArray Apex_Application_Global.Vc_arr2;
QueryStatement varchar2(200);
SQLStatement varchar2(200);
TYPE Cur_Typ IS REF CURSOR;
C1           Cur_Typ;
Question_Desc Questions.Questiondesc%type;
Begin
KeywordArray:=Apex_Util.String_To_Table(Keyword,' ');
QueryStatement:=' ';
For I in 1..KeywordArray.Count
Loop
If (I=1)Then  
  QueryStatement:= QueryStatement||'UPPER(Questiondesc) LIKE ''%'||Upper(KeywordArray(i))||'%''';
Else
  QueryStatement:= QueryStatement||' and '|| 'UPPER(Questiondesc) LIKE ''%'||Upper(KeywordArray(i))||'%''';
End if;
End loop;
SQLStatement := ('Select QuestionDesc From Questions where '||QueryStatement||'order by VoteCount desc' );
OPEN C1 FOR SQLStatement;
LOOP
  FETCH C1 INTO Question_Desc;
  If Question_Desc is Null Then 
  Raise No_Data_Found;
  Else 
  Exit When C1%NotFound;
  Dbms_Output.Put_Line(Question_Desc);
  End If;
END LOOP;
CLOSE C1;
Exception
When No_Data_Found Then
Dbms_output.put_line('No Questions found for the given keywords.');
End;

Exec SearchQuestion('SQL');
Exec SearchQuestion('to the');
Create or Replace Procedure SummaryReport
As
ActiveUsers Integer;
InactiveUsers Integer;
AvgQuestions Integer;
AvgAnswers Integer;
AvgVoteCount Integer;
QuestionCloseTime Integer;
AvgRepuatationScore Integer;
Begin
Select Count(*) into ActiveUsers from RegularUser Where Status='Active';
Select Count(*) into InactiveUsers from RegularUser Where Status='Inactive';
Select Avg(Count(*)) into AvgQuestions from Questions group by UserID;
Select Avg(Count(*)) into AvgAnswers from Answers group by UserID;
Select Avg(VoteCount) into  AvgVoteCount  from QuestionVotes V,Questions Q where Q.QuestionID=V.QuestionID and Q.QuestionStatus='Closed';
Select Avg(Trunc(ClosingTime)-Trunc(PostingTime)) into QuestionCloseTime from Questions;
Select Avg(ReputationScore)into AvgRepuatationScore from RegularUser;
Dbms_Output.Put_Line('The number of active users: '||ActiveUsers);
Dbms_Output.Put_Line('The number of inactive users: '||InactiveUsers);
Dbms_Output.Put_Line('The average number of questions posted by each user (either active or inactive) in the system: '||AvgQuestions);
Dbms_Output.Put_Line('The average number of answers provided by each user (either active or inactive) in the system: '||AvgAnswers);
Dbms_Output.Put_Line('The average vote counts of all the closed questions in the system: '||AvgVoteCount);
Dbms_Output.Put_Line('The average number of days that are needed for a question to be closed: '||QuestionCloseTime);
Dbms_Output.Put_Line('The average reputation score of all the users in the system: '||AvgRepuatationScore);
Dbms_Output.Put_Line('--------------------------------------------------------------------------------------------------------------');
AllTags;
End;

Exec SummaryReport;


Create or Replace Procedure AllTags
As
Tag_ID Integer;
Cursor C1 is Select TagID from Tags;
Begin
Open C1;
Loop
Fetch C1 into Tag_ID;
Exit When C1%NotFound;
TopUser(Tag_ID);
End Loop;
Close C1;
End;

Exec AllTags;

Create Or Replace Procedure TopUser(Tag_ID Integer)
AS
UserName Users.Name%Type;
Tag_Name Tags.TagName%Type;
Begin
Select TagName into Tag_Name from Tags where TagID=Tag_ID;
Select Name into UserName from (Select Name from Users U, RegularUser R,UserTags T Where U.UserID=R.UserID and R.UserID=T.UserID and T.TagID=Tag_ID order by R.ReputationScore desc) where  rownum <=1;
Dbms_Output.Put_Line('Top-1 User with Highest Reputation Score for Tag:'||Tag_Name||' is '||UserName);
Exception When No_data_Found Then
Dbms_Output.Put_Line('No user found for the tag: '||Tag_Name); 
End;


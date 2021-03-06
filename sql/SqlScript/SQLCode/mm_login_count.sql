USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_login_count]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--mm_login_count '2014-06-01', '2014-07-01'
CREATE Procedure [dbo].[mm_login_count]
@begdate date,
@enddate date,
@usertype int
as
Set Nocount On 

Select @enddate = dateadd(dd, 1, @enddate)

Select Convert(Varchar(10), Operdate, 120) DD, UserID, Max(Case When operation = 98 Then 1 Else 0 End) C 
  Into #B
  From applogs.dbo.operation_record
  Group by Convert(Varchar(10), Operdate, 120), UserID

Select Distinct DD Into #A
  From #B
  Where DD between @begdate and @enddate

Select Distinct Convert(Varchar(10), Operdate, 120) DD, UserID, d.usertype Into #C
  From applogs.dbo.operation_record b, applogs.dbo.operation_config d
  Where b.operation = d.ID and b.operdate between @begdate and @enddate and d.usertype = @usertype

;With Data1 as (
Select DD, usertype, COUNT(Distinct userid) C
  From #C
  Group by DD, usertype
), Data2 as (
Select DD, Sum(C) C
  From #B
  Group by DD
), Data3 as (
Select b.DD, b.userType, Count(Distinct b.userid) C
  From #C b
  Where Not Exists (Select * From #B c Where b.userid = c.userid and c.DD < b.DD)
  Group by b.userType, b.DD
)
Select a.DD [日期], IsNull(b.C, 0) [每天登陆人数], IsNull(d.C, 0) [每天新增用户人数], IsNull(c.C, 0) [每天写日记数量], b.usertype
  Into #D
  From #A a Left Join Data1 b On a.DD = b.DD
            Left Join Data2 c On a.DD = c.DD and b.userType = 0
            Left Join Data3 d On a.DD = d.DD and b.usertype = d.usertype

if @usertype = 97
  Select [日期], [每天登陆人数], [每天新增用户人数] From #D Where usertype = 97 Order by [日期]

if @usertype = 1
  Select [日期], [每天登陆人数], [每天新增用户人数] From #D Where usertype = 1 Order by [日期]

if @usertype = 0
  Select [日期], [每天登陆人数], [每天新增用户人数], [每天写日记数量] From #D Where usertype = 0 Order by [日期]

Drop Table #A, #B, #C, #D



GO

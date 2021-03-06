USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[rep_appcenter_log]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author: YZ    
-- Create date: 2014-04-26    
-- Description: 全局用户行为查询    
-- [rep_appcenter_log] '2014-1-1','2014-4-1','2014-1-1','2014-4-1'      
-- =============================================    
CREATE PROCEDURE [dbo].[rep_appcenter_log]    
@kidbgndate date,  
@kidenddate date,  
@bgndate date,    
@enddate date  
    
AS    
BEGIN    
 SET NOCOUNT ON;    
 
  select k.actiondate, u.name, k.kname, k.kid, lat.actionname, ROW_NUMBER() Over(partition by k.kid order by actiondatetime) Row
    into #A
    from (Select userid, appid, actiondatetime   
            From applogs..appcenter_log   
            Where usertype = 98    
              and actiondatetime >= CONVERT(VARCHAR(10),@bgndate,120)    
              and actiondatetime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)) al    
      inner join BasicData..[user] u    
        on al.userid = u.userid    
      inner join applogs..log_action_type lat    
        on al.appid = lat.appidid    
      inner join BasicData..kindergarten k    
        on u.kid = k.kid    
       where k.actiondate >= CONVERT(VARCHAR(10),@kidbgndate,120)    
         and k.actiondate < CONVERT(VARCHAR(10),DATEADD(DD,1,@kidenddate),120)  

  Select Distinct kid, kname 所属幼儿园, Convert(varchar(10), actiondate, 120) 注册时间, CAST(null as varchar(max)) 操作 Into #B From #A
  
  declare @id int, @mid int
  Select @id = 1, @mid = MAX(Row) From #A
  while @id <= @mid
  begin
    Update #B Set 操作 = ISNULL(a.操作 + '->', '') + b.actionname
      From #B a, #A b
      Where a.kid = b.kid and b.Row = @id
  
    Select @id = @id + 1
  end
  
  select 所属幼儿园, 注册时间, 操作 From #B
END    
GO

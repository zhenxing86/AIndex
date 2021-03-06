USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[buginfo_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie
-- Create date: 2013-11-28      
-- Description:       
-- Memo:        
exec buginfo_GetListTag 1,10,12511,'帼英',6,-1,-1,'2013-11-1 10:00:00','2013-12-3 23:59:59'    
exec buginfo_GetListTag 1,10,0,'',-1,0,-1,'2013-11-1 10:00:00','2014-12-3 23:59:59' ,'2013-11-1 10:00:00','2014-12-3 23:59:59',1,'201406171007',0
*/      
CREATE PROCEDURE [dbo].[buginfo_GetListTag]      
@page int,
@size int,
@kid int,
@username nvarchar(20),
@douserid int,
@bugtype int,
@process int,
@bgndate datetime,
@enddate datetime,
@dobgndate datetime=null,
@doenddate datetime=null,
@smallbugtype int=-1,      
@bugid varchar(25) ='',
@timetype int = 0
 AS       
 
begin      


 DECLARE @fromstring NVARCHAR(2000)      
 SET @fromstring =       
 'ossapp..buginfo b
 left join basicdata..kindergarten k on k.kid=b.kid
 left join ossapp..users u on b.userid=u.ID and u.deletetag=1
 left join ossapp..users u2 on b.douserid=u2.ID and u2.deletetag=1
 where b.applydate>=@T1 and b.applydate<=@T2 and b.deletetag=1
  and ((b.dodate>=@T3 and b.dodate<=@T4) or b.dodate=''1900-01-01 00:00:00.000'') ' 
  if @bugtype=0 and @smallbugtype<0 set @bugtype=-1  
  IF @username <> '' SET @fromstring = @fromstring + ' AND u.name like ''%'' + @S1 + ''%'''  
  IF @kid > 0 SET @fromstring = @fromstring + ' AND b.kid = @D1'      
  IF @douserid > -1 SET @fromstring = @fromstring + ' AND b.douserid = @D2'      
  IF @bugtype > -1 SET @fromstring = @fromstring + ' AND b.bug_type = @D3'    
  IF @process > -1 SET @fromstring = @fromstring + ' AND b.process = @D4' 
  IF @smallbugtype > -1 SET @fromstring = @fromstring + ' AND b.small_bug_type = @D5'     
  if @bugid<>'' SET @fromstring = @fromstring + ' AND (replace(convert(varchar(10),applydate,111),''/'','''')+right(convert(varchar, serialno),3))=convert(varchar,'''+@bugid+''')' 
  if @timetype=1 SET @fromstring = @fromstring + ' AND  (DATEDIFF(dd,b.applydate,getdate())<30) '   
  if @timetype=2 SET @fromstring = @fromstring + ' AND  (DATEDIFF(dd,b.applydate,getdate())>30) '   
     
 --分页查询      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  ' b.bugid,b.userid,u.name username,b.applydate,b.bug_des,b.kid,k.kname,b.bug_type,b.enddate,b.process,b.dodate,
  b.doresult,b.douserid,u2.name dousername,b.serialno,b.small_bug_type,b.reason_level',      --查询字段      
  @returnstring =       
  ' bugid,userid,username,applydate,bug_des,kid,kname,bug_type,enddate,process,dodate,
  doresult,douserid,dousername,serialno,small_bug_type,reason_level',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' b.applydate desc ',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid,      
  @D2 = @douserid,      
  @D3 = @bugtype,
  @D4 = @process,
  @D5 = @smallbugtype,

  
  @S1 = @username,
  @T1 = @bgndate,
  @T2 = @enddate,
  @T3 = @dobgndate,
  @T4 = @doenddate

end 




GO

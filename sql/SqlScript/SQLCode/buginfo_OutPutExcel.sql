USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[buginfo_OutPutExcel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*            
-- Author:      xie      
-- Create date: 2014-05-27            
-- Description:  导出客服问题到excel表    
-- Memo:              
exec buginfo_OutPutExcel 12511,'帼英',6,-1,-1,'2013-11-1 10:00:00','2013-12-3 23:59:59'      
    
exec [buginfo_OutPutExcel]    
@kid =-1,      
@username='',      
@douserid =-1,      
@bugtype =0,      
@process =-1,      
@bgndate ='2014-6-6 00:00:00',      
@enddate ='2014-6-13 10:00:00',  
@dobgndate ='2014-6-6 00:00:00',      
@doenddate ='2014-6-13 10:00:00',  
@smallbugtype =-1             
*/            
CREATE PROCEDURE [dbo].[buginfo_OutPutExcel]            
@kid int,      
@username nvarchar(20),      
@douserid int,      
@bugtype int,      
@process int,      
@bgndate datetime,      
@enddate datetime,  
@dobgndate datetime,      
@doenddate datetime,  
@smallbugtype int=-1,
@bugid varchar(25) ='',  
@timetype int = 0    
 AS             
begin            
      
  set nocount on     
       
 DECLARE @selectstring NVARCHAR(800),@fromstring NVARCHAR(2000),@orderString NVARCHAR(100),    
 @ParmDefinition NVARCHAR(4000),@tempMain NVARCHAR(4000)             
 SET @fromstring =             
 'ossapp..buginfo b      
  left join basicdata..kindergarten k on k.kid=b.kid      
  left join ossapp..users u on b.userid=u.ID and u.deletetag=1      
  left join ossapp..users u2 on b.douserid=u2.ID and u2.deletetag=1      
  where b.applydate>=@bgndate and b.applydate<=@enddate and b.deletetag=1  
  and ((b.dodate>=@dobgndate and b.dodate<=@doenddate) or b.dodate=''1900-01-01 00:00:00.000'') '    
  if @bugtype=0 and @smallbugtype<0 set @bugtype=-1    
  IF @username <> '' SET @fromstring = @fromstring + ' AND u.name like ''%'' + @username + ''%'''               
  IF @kid > 0 SET @fromstring = @fromstring + ' AND b.kid = @kid'            
  IF @douserid > -1 SET @fromstring = @fromstring + ' AND b.douserid = @douserid'            
  IF @bugtype > -1 SET @fromstring = @fromstring + ' AND b.bug_type = @bugtype'          
  IF @process > -1 SET @fromstring = @fromstring + ' AND b.process = @process'                
  IF @smallbugtype > -1 SET @fromstring = @fromstring + ' AND b.small_bug_type = @smallbugtype'   
  
  if @bugid<>'' SET @fromstring = @fromstring + ' AND (replace(convert(varchar(10),applydate,111),''/'','''')+right(convert(varchar, serialno),3))=convert(varchar,'''+@bugid+''')'   
  if @timetype=1 SET @fromstring = @fromstring + ' AND  (DATEDIFF(dd,b.applydate,getdate())<30) '     
  else if @timetype=2 SET @fromstring = @fromstring + ' AND  (DATEDIFF(dd,b.applydate,getdate())>30) ' 
                       
  set @selectstring ='b.bugid,k.kname,b.bug_type,b.bug_des,u.name username,b.applydate,b.process,    
  u2.name dousername,b.dodate,b.serialno,b.small_bug_type,b.reason_level';    
    
  set @orderString = 'b.bugid desc';    
  SET @tempMain =       
   ' SELECT '     
    + @selectstring +'       
     FROM '+@fromstring+'        
     order by '+@orderString     
    
  SET @ParmDefinition =       
    N'@kid INT = NULL,      
      @douserid INT = NULL,       
      @bugtype INT = NULL,       
      @process INT = NULL,      
      @username varchar(50) = NULL,     
      @bgndate DATETIME = NULL,       
      @enddate DATETIME = NULL,  
      @dobgndate DATETIME = NULL,       
      @doenddate DATETIME = NULL,  
      @smallbugtype INT = NULL';        
    
   declare @t table(bugid int ,kname nvarchar(200),bug_type int,bug_des varchar(max),    
   username nvarchar(50),applydate datetime,process int,dousername nvarchar(50),  
   dodate datetime,serialno varchar(50),small_bug_type int,reason_level int)    
   --客服问题主表    
   print @tempMain    
    insert into @t    
 EXEC SP_EXECUTESQL @tempMain,@ParmDefinition,      
   @kid = @kid,      
   @douserid = @douserid,      
   @bugtype = @bugtype,       
   @process = @process,       
   @username = @username,      
   @bgndate = @bgndate,       
   @enddate = @enddate,  
   @dobgndate = @dobgndate,       
   @doenddate = @doenddate,    
   @smallbugtype = @smallbugtype;   
     
    select * from @t    
 --客服跟进（提出人意见）     
     
 select d.*    
 from @t t     
  inner join bug_detial d     
   on t.bugid=d.bugid     
    and d.deletetag=1     
    and d.ftype=0  
     
 --客服跟进（处理人意见）     
 select d.*    
 from @t t     
  inner join bug_detial d     
   on t.bugid=d.bugid     
    and d.deletetag=1     
    and d.ftype <>0  
            
end       
GO

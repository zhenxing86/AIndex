USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_log_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie      
-- Create date: 2013-09-11      
-- Description:       
-- Memo:        
exec mc_log_GetList 1,300,12511,'','',-3,'2013-02-02 00:00:00.410','2013-11-12 23:57:25.410'    
*/      
--       
CREATE PROCEDURE [dbo].[mc_log_GetList]      
@page int      
,@size int      
,@kid int      
,@cardno nvarchar(50)      
,@doname nvarchar(50)      
,@dotype int      
,@bgndate DateTime      
,@enddate DateTime      
 AS       
begin      
      
CREATE TABLE #T(card sql_variant, k2 sql_variant, k3 sql_variant,DoType varchar(10) , ColName varchar(100), Oldvalue sql_variant, NewValue sql_variant, DoName varchar(50), CrtDate datetime)    
insert into #T    
exec applogs..LogQuery @DbName  = 'mcapp',    
 @TbName  = 'cardinfo',     
 @Item  = 'kid',     
 @value  = @kid,     
 @kid  = @kid,    
 @bgntime  = @bgndate,    
 @endtime  = @enddate,    
 @DoType  = -1--（0新增，2删除，1修改，-1不限）    
     
 select CAST(card as varchar(50)) cardno,     
 CASE WHEN CAST( NewValue AS int) = 1 then 1    
 when CAST( NewValue AS int) = -1 THEN -1    
 when CAST( NewValue AS int) = 0 THEN 2    
 when CAST( NewValue AS int) = -2 THEN -2    
 when t.DoType = '删除' THEN 3    
 when t.DoType = '新增' THEN 0     
 END dotype,    
 ISNULL(u.name,u1.name) name, t.DoName DoName,crtdate    
 into #CET    
 from #T t     
 LEFT JOIN basicdata..[user] u on t.ColName = '用户ID' and u.userid = CAST( t.OldValue  AS int)     
 LEFT JOIN basicdata..[user] u1 on t.ColName = '用户ID' and u1.userid = CAST( t.NewValue  AS int)     
     
select cardno, MAX(dotype) dotype, MAX(name) name, DoName, CrtDate    
  into #log    
 from #CET    
  GROUP BY cardno, DoName, CrtDate    
      
 DECLARE @fromstring NVARCHAR(2000)      
 SET @fromstring =       
 ' #log where 1=1'      
  IF @cardno <> '' SET @fromstring = @fromstring + ' AND cardno like @S1 + ''%'''       
  IF @dotype<>-3 set @fromstring = @fromstring + ' AND dotype = @D1'      
  IF @doname <> '' SET @fromstring = @fromstring + ' AND (u.name=@S2 or u1.name=@S2)'            
 --分页查询 卡号  操作指令 操作方式  操作对象 操作者 操作时间      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  ' cardno,dotype,name,DoName,CrtDate',      --查询字段      
  @returnstring =       
  ' cardno,dotype,name,DoName,CrtDate',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' CrtDate desc ',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @dotype,      
  @S1 = @cardno,      
  @S2 = @doname    
      
  DROP TABLE  #T,#CET,#log    
end      
GO

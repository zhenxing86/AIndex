USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_fever_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*    
-- Author:      xie    
-- Create date: 2013-10-22    
-- Description:   获取晨检体温偏高的列表  
-- Paradef:     
-- Memo:    
exec rep_mc_fever_GetList 8247,1,100,'2013-10-1 00:00:00','2013-10-22 23:59:59', ''  
    
*/    
CREATE procedure [dbo].[rep_mc_fever_GetList]    
 @kid int,     
 @page int,     
 @size int,    
 @bgndate datetime,    
 @enddate datetime,    
 @kname varchar(20),
 @cuid int=-1,         
 @developer varchar(100)=''    
AS    
BEGIN    
 SET NOCOUNT ON    
    
    
 DECLARE @fromstring NVARCHAR(2000)
 CREATE TABLE #T(smstype int, kid int)     
 CREATE TABLE #kid(kid int)    
  DECLARE @flag int    
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex @kid,@kname,'','','',@cuid,@developer       
  IF @flag = -1  
  BEGIN     
	 SET @fromstring =     
	  ' mcapp..stu_mc_day_raw r  
		inner join mcapp..stu_mc_day d  
		  on r.[card] = d.[card] and r.kid=d.kid and r.cdate = d.cdate   
		inner join BasicData..kindergarten k  
		  on r.kid = k.kid  
		inner join BasicData..[user] u  
		  on d.stuid = u.userid  
	        
	  where d.tw > 37.8  
		and r.kid in (select distinct kid  
				   from mcapp..gun_para_xg   
				   where [Status] = 2)  
		and r.kid <> 12511  
		and d.cdate>=@T1 and d.cdate<=@T2'   
 END
 ELSE
 BEGIN
	SET @fromstring =     
	  ' mcapp..stu_mc_day_raw r  
		inner join mcapp..stu_mc_day d  
		  on r.[card] = d.[card] and r.kid=d.kid and r.cdate = d.cdate   
		inner join BasicData..kindergarten k  
		  on r.kid = k.kid  
		inner join #kid
		  on r.kid = #kid.kid  
		inner join BasicData..[user] u  
		  on d.stuid = u.userid  
	        
	  where d.tw > 37.8  
		and r.kid in (select distinct kid  
				   from mcapp..gun_para_xg   
				   where [Status] = 2)  
		and r.kid <> 12511  
		and d.cdate>=@T1 and d.cdate<=@T2'  
 END 
    
 IF @kid >0 SET @fromstring = @fromstring + ' AND d.kid =@D1'     
 IF @kname <> '' SET @fromstring = @fromstring + ' AND k.kname like @S1 + ''%'''     
     
 exec sp_MutiGridViewByPager    
  @fromstring = @fromstring,  --数据集      
  @selectstring =     
  ' r.kid,k.kname,d.stuid,u.name uname,r.cdate,d.tw,r.ta,r.toe,r.devid,r.gunid',      --查询字段    
  @returnstring =     
  ' kid, kname,stuid,uname, cdate,tw,ta,toe,devid,gunid',      --返回字段    
  @pageSize = @Size,                 --每页记录数    
  @pageNo = @page,                     --当前页    
  @orderString = ' r.kid,d.cdate desc',          --排序条件    
  @IsRecordTotal = 1,             --是否输出总记录条数    
  @IsRowNo = 0,           --是否输出行号    
  @D1 = @kid,    
  @S1 = @kname,   
  @T1 = @bgndate,    
  @T2 = @enddate   
     
END    
GO

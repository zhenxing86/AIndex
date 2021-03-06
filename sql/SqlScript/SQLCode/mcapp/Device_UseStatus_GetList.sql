USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[Device_UseStatus_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                    
-- Author:      xie                    
-- Create date:  2014-06-26                 
-- Description: 幼儿园使用设备情况表(给科康他们看的)                    
-- Memo:                      
exec [Device_UseStatus_GetList] 1,100,-1,'','','','',1,'',-1                          
*/                    
CREATE PROC [dbo].[Device_UseStatus_GetList]                     
 @page int,          
 @size int,                  
 @kid int,                    
 @kname varchar(100),                    
 @provinceid varchar(100),                    
 @cityid varchar(100),                    
 @areaid varchar(100),                      
 @cuid int=0,                     
 @developer varchar(100)='',                 
 @devicetype int =-1                  
AS                    
BEGIN                     
 SET NOCOUNT ON                    
 CREATE TABLE #kid(kid int)  
 CREATE TABLE #RESULT(kid int,kname nvarchar(200),ytjcnt int,pbcnt int,guncnt int,childcnt int,stu_opencardcnt int,tea_opencardcnt int )                                                 
  DECLARE @flag int                    
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex @kid,@kname,@provinceid,@cityid,@areaid,@cuid,@developer                   

--幼儿园名称，一体机数量，平板数量，晨检枪数量，学生数量，开卡数量
--设备类型：0：一体机，1：平板，2：MU260,3：晨检枪
    select kid,
	 sum(case when devicetype=0 then 1 else 0 end) ytjcnt,
	 sum(case when devicetype=1 then 1 else 0 end) pbcnt
	 into #DeviceCnt
	from driveinfo 
	where devicetype <2
	group by kid

	select kid,COUNT(1) guncnt
	 into #GunCnt 
	from tcf_setting
	group by kid

	select uc.kid,COUNT(1) childcnt
	 into #ChildCnt
	from BasicData..User_Child uc
	 inner join BlogApp..permissionsetting p
	  on uc.kid =p.kid and p.ptype = 90 and uc.kid not in (12511,11061,22018,22030,22053,21935,22084)
	group by uc.kid

	select c.kid,sum(case when u.usertype=0 then 1 else 0 end) stu_opencardcnt,
	sum(case when u.usertype>0 then 1 else 0 end) tea_opencardcnt
	 into #OpenCardCnt
	from cardinfo c  
	 inner join BasicData..[user] u 
	  on c.userid=u.userid
	where c.userid>0 and c.usest=1
	group by c.kid  

              
 IF @flag = -1                    
 BEGIN       
    insert into #RESULT
	select c.kid,CAST(NULL AS VARCHAR(200))kname,d.ytjcnt,d.pbcnt,g.guncnt,c.childcnt,oc.stu_opencardcnt,oc.tea_opencardcnt
	from #ChildCnt c
	 left join #OpenCardCnt oc
	  on c.kid= oc.kid 
	 left join #DeviceCnt d
	  on c.kid=d.kid
	 left join #GunCnt g
	  on c.kid=g.kid
	        
 END                    
 ELSE                    
 BEGIN 
    insert into #RESULT                  
    select c.kid,CAST(NULL AS VARCHAR(200))kname,d.ytjcnt,d.pbcnt,g.guncnt,c.childcnt,oc.stu_opencardcnt,oc.tea_opencardcnt
	from #ChildCnt c
	 inner join #kid k 
	  on c.kid = k.kid
	 left join #OpenCardCnt oc
	  on c.kid= oc.kid 
	 left join #DeviceCnt d    
	  on c.kid=d.kid
	 left join #GunCnt g
	  on c.kid=g.kid             
 END                      
                       
 update r set kname = k.kname                     
  from #RESULT r                     
   inner join BasicData.dbo.kindergarten k on r.kid = k.kid                    
                    
 select COUNT(kid) kidcnt,SUM(ytjcnt) ytjcnt,SUM(pbcnt) pbcnt,SUM(guncnt) guncnt,
 SUM(childcnt) childcnt,SUM(stu_opencardcnt) stu_opencardcnt,SUM(tea_opencardcnt) tea_opencardcnt          
 from #RESULT                                 
          
 --分页查询                  
 exec sp_MutiGridViewByPager                  
  @fromstring = '#RESULT',      --数据集                  
  @selectstring =                   
  ' kid,kname,ytjcnt,pbcnt,guncnt,childcnt,stu_opencardcnt,tea_opencardcnt',      --查询字段                  
  @returnstring =                   
  ' kid,kname,ytjcnt,pbcnt,guncnt,childcnt,stu_opencardcnt,tea_opencardcnt',      --返回字段                  
  @pageSize = @Size,                 --每页记录数                  
  @pageNo = @page,                     --当前页                  
  @orderString = ' stu_opencardcnt desc,guncnt desc,pbcnt desc,ytjcnt desc',          --排序条件     
  @IsRecordTotal = 1,             --是否输出总记录条数                  
  @IsRowNo = 0          --是否输出行号                  
      
  drop table #RESULT, #OpenCardCnt, #ChildCnt,#GunCnt , #DeviceCnt       
END 
GO

USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_man_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      Master谭      
-- Create date: 2013-05-22      
-- Description:       
-- Paradef: roletype(1：园长，2：校医，3：主班老师)      
-- Memo:      
mc_sms_man_GetList 12511,2,1,10      
go      
mc_sms_man_GetList 12511,1,1,10      
*/      
CREATE procedure [dbo].[mc_sms_man_GetList]      
 @kid int,       
 @roletype int,      
 @page int,       
 @size int      
AS      
BEGIN      
 SET NOCOUNT ON      
      
--1.获取老师园长列表（分页）mc_sms_man_GetList      
--输入：@kid int,@username varchar(20),@page int,@size int      
--输出（列表）：userid,username,title,mobile,state(0：未设置，1：已设置)      
      
DECLARE @fromstring NVARCHAR(2000)      
SET @fromstring =       
 ' basicdata.dbo.[user] u       
    inner join [BasicData].[dbo].[teacher] t       
     on u.userid = t.userid       
    left join sms_man_kid sm       
     on u.userid = sm.userid       
   where u.kid = @D1 '   
   --where u.usertype <> 98 and  u.kid = @D1 '    
           
 IF @roletype <> -1       
       
 SET @fromstring =       
   ' basicdata.dbo.[user] u       
    inner join [BasicData].[dbo].[teacher] t       
     on u.userid = t.userid       
    outer apply(select top(1)* from sms_man_kid sm where u.userid = sm.userid  order by (case when sm.roletype=@D2 then 99 else sm.roletype end ) desc) sm       
   where u.kid = @D1 '  
   --where u.usertype <> 98 and  u.kid = @D1 '  
         
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  ' u.userid, u.name username, t.title, u.mobile,       
      CASE WHEN SM.userid is null then 0 ELSE sm.roletype END [state],u.usertype',      --查询字段      
  @returnstring =       
  ' userid, username, title, mobile, [state], usertype',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' CASE WHEN  SM.userid is null then 999 else sm.roletype end,u.usertype desc, u.name',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid,      
  @D2 = @roletype      
       
END      
GO

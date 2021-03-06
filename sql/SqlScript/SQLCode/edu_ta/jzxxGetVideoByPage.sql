USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[jzxxGetVideoByPage]    Script Date: 2014/11/24 23:06:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      Master谭      
-- Create date: 2013-12-3      
-- Description: 分页读取视频的列表      
-- Memo:    
exec fmcapp..GetVideoByPage 'fmc_expertsforum',  1    
exec fmcapp..GetVideoByPage 'fmc_microvideo',  2    
*/      
--      
create PROC [dbo].[jzxxGetVideoByPage]    
 @TbName varchar(20),    
 @page int       
AS    
BEGIN      
 SET NOCOUNT ON      
 DECLARE     
   @fromstring NVARCHAR(2000)    
 SELECT  @fromstring = @TbName + ' a    
  inner join fmc_authorityexpert fa    
   on a.expertid = fa.ID    
  where a.deletetag = 1'     
 exec sp_MutiGridViewByPager    
   @fromstring = @fromstring,      --数据集    
   @selectstring =     
   'fa.name author, fa.post,a.smallimg imgurl, a.title, a.mp4url videourl, a.intime ctrdate,fa.mobileauthorpic mobileauthorpic,a.mobilepicurl,fa.smallimg faimgurl ',      --查询字段    
   @returnstring =     
   'author, post, imgurl, title, videourl, ctrdate,mobileauthorpic,mobilepicurl,faimgurl ',      --返回字段    
   @pageSize = 100,                 --每页记录数    
   @pageNo = @page,                     --当前页    
   @orderString = ' a.intime desc',          --排序条件    
   @IsRecordTotal = 1,             --是否输出总记录条数    
   @IsRowNo = 0          --是否输出行号    
END 
GO

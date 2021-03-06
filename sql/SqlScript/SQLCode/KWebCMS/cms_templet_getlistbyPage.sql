USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_templet_getlistbyPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xnl	
-- Create date: 2014-5-15
-- Description:	获取报名控件模版表的列表
-- =============================================
CREATE PROCEDURE [dbo].[cms_templet_getlistbyPage]
 @siteid int,
	@page int,
@size int
AS

exec sp_MutiGridViewByPager      
@fromstring = 'enlistonline_templet c,site s where c.siteid=s.siteid and c.deletetag=1 
  and c.siteid=Case When @D1 >=0 Then @D1 Else c.siteid End',      --数据集      
@selectstring =       
'c.ID,title,type,orderno,cssclass,c.siteid,isrequired',      --查询字段      
@returnstring =       
'ID,title,type,orderno,cssclass,siteid,isrequired',      --返回字段      
@pageSize = @Size,                 --每页记录数      
@pageNo = @page,                     --当前页      
@orderString = 'c.id desc',          --排序条件      
@IsRecordTotal = 1,             --是否输出总记录条数      
@IsRowNo = 0,           --是否输出行号      
@D1 = @siteid
GO

USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[teainfo_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
*/
CREATE PROCEDURE [dbo].[teainfo_GetList]
	@page int,
	@size int,
	@uname nvarchar(30),
	@cid int,
	@kid int,
	@cardno varchar(100)
AS
BEGIN 
	SET NOCOUNT ON
	SELECT	u.userid, c.cardno card, u.name, u.tts, 
					CASE WHEN u.gender = 2 then '女' ELSE '男' END sex, 
					u.mobile tel, u.headpic tpic, CAST(NULL AS INT)syntag
		INTO #result  	 
		FROM BasicData..[User] u 
			left join cardinfo c on u.userid = c.userid
		where u.kid = @kid  
			and u.name like @uname + '%' 
			and u.usertype >= 1
			and u.deletetag = 1
			and u.usertype <> 98  
			and @cardno in(cardno, '')

 exec dbo.sp_GridViewByPager      
   @viewName = '#result',             --表名  
     @fieldName = 'userid, card, name, tts, sex, tel, tpic, syntag',      --查询字段  
     @keyName = 'userid',       --索引字段  
     @pageSize = @size,                 --每页记录数  
     @pageNo = @page,                     --当前页  
     @orderString = ' name ',          --排序条件  
     @whereString = '1=1',  --WHERE条件  
     @IsRecordTotal = 1,             --是否输出总记录条数  
     @IsRowNo = 0   

END

GO

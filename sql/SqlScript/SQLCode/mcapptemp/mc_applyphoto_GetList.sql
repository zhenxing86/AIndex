USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_applyphoto_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
EXEC[mc_applyphoto_GetList] 12511,-1, '2013-05-01','2013-06-10',1,100
EXEC[mc_applyphoto_GetList] 12511,1, '2013-05-01','2013-06-10',1,100
*/
--0:待上传；1：已上传
CREATE PROCEDURE [dbo].[mc_applyphoto_GetList]
@kid int
,@applystate int
,@txttime1 datetime
,@txttime2 datetime
,@page int
,@size int
 AS 
--分页存储过程

begin
	set nocount on
	DECLARE 
			@fromstring NVARCHAR(2000)				--数据集
	SET @fromstring = 
	'mc_applyphoto ap
		 inner join BasicData..kindergarten k on k.kid=ap.kid 
		 inner join BasicData..[user] u on u.userid=ap.applyuserid 
		where	ap.applystate>0
			and ap.applytime between @T1 and @T2'	
	IF @kid<>-1
	SET @fromstring = @fromstring + ' AND ap.kid = @D1 '
	IF @applystate<>-1
	SET @fromstring = @fromstring + ' AND ap.applystate = @D2 '			
			
		exec	sp_MutiGridViewByPager
			@fromstring = @fromstring,      --数据集
			@selectstring = 
			'ap.mc_pid,ap.kid,kname,applyuserid,u.[name],ap.applytime,ap.applystate
	,(select COUNT(*) from dbo.mc_applyphoto_stuid aps where aps.mc_pid=ap.mc_pid) childcount',      --查询字段
			@returnstring = 
			'mc_pid,kid,kname,applyuserid,name,applytime,applystate, childcount',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' case when ap.applystate=1 then 1 else 0 end asc,ap.applytime desc',          --排序条件
			@IsRecordTotal = 1,             --是否输出总记录条数
			@IsRowNo = 0,										 --是否输出行号
			@D1 = @kid,									
			@D2 = @applystate,									
			@T1 = @txttime1,									
			@T2 = @txttime2
end

GO

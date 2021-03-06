USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_ClassChild_GetListByPage]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[blog_ClassChild_GetListByPage]
@classid int,
@userid int,
@page int,
@size int

AS

declare @fromstring nvarchAR(1000),@kid int
select @kid = kid from BasicData.dbo.[user] where userid = @userid
IF (@classid=-1)
SET @fromstring = 'BasicData..[user] u
		               where usertype = 0
		                 and kid = @D3
		                 and userid <> @D2'
ELSE	
SET @fromstring = 'BasicData..[user] u
		                 inner join BasicData.dbo.user_class uc
		                    on u.userid = uc.userid
		               where u.usertype = 0
		                 and uc.cid = @D1'
	
exec	sp_MutiGridViewByPager
  @fromstring = @fromstring,      --数据集
	@selectstring = 'u.userid,u.name',      --查询字段
	@returnstring = 'userid,name',      --返回字段
	@pageSize = @Size,                 --每页记录数
	@pageNo = @page,                     --当前页
	@orderString = 'u.regdatetime desc',          --排序条件
	@IsRecordTotal = 1,             --是否输出总记录条数
	@IsRowNo = 0,										 --是否输出行号
	@D1 = @classid,										
	@D2 = @userid,
	@D3 = @kid
	

GO

USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_applyphoto_stuid_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[mc_applyphoto_stuid_GetList]
	@mc_pid int,
	@kid int,
	@cid int,
	@page int,
	@size int
 AS 
--分页存储过程

begin
	set nocount on
	DECLARE 
			@fromstring NVARCHAR(2000)				--数据集
	SET @fromstring = 
	' mc_applyphoto_stuid s
			inner join BasicData..user_class uc on userid=stuid
			inner join BasicData..class c on c.cid=uc.cid
			inner join BasicData..[user] b on b.userid=uc.userid 
			where s.mc_pid=@D1 
			and c.kid=@D2 '	
	IF @cid<>-1
	SET @fromstring = @fromstring + ' AND c.cid=@D3 '	
			
		exec	sp_MutiGridViewByPager
			@fromstring = @fromstring,      --数据集
			@selectstring = 
			's.stuid,b.name,c.cid,c.cname',      --查询字段
			@returnstring = 
			'stuid, name, cid, cname',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' stuid',          --排序条件
			@IsRecordTotal = 1,             --是否输出总记录条数
			@IsRowNo = 0,										 --是否输出行号
			@D1 = @mc_pid,									
			@D2 = @kid,										
			@D3 = @cid

end

GO

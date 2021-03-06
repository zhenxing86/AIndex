USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_man_tea_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      xie
-- Create date: 2013-05-22
-- Description:	
-- Paradef: roletype(1：园长，2：校医，3：主班老师)
-- Memo:
mc_sms_man_tea_GetList 12511,1,10
go
*/

CREATE procedure [dbo].[mc_sms_man_tea_GetList]
	@kid int, 
	@page int, 
	@size int
AS
BEGIN
	SET NOCOUNT ON

--1.获取老师园长列表（分页）mc_sms_man_GetList
--输入：@kid int,@username varchar(20),@page int,@size int
--输出（列表）：userid,username,title,mobile,state(0：未设置，1：已设置)

DECLARE @fromstring NVARCHAR(2000)
SET @fromstring = ' basicdata..class c 
				INNER JOIN basicdata..grade g ON c.grade = g.gid and c.grade<>38
				left join mcapp..sms_man_kid sm on sm.cid = c.cid 
				left join basicdata..user_class uc on uc.cid=sm.cid and uc.userid = sm.userid 
				left join basicdata..User_Teacher ut on uc.userid=ut.userid
				WHERE c.kid = @D1 AND c.deletetag = 1 AND c.iscurrent = 1'
				 
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,      --数据集
		@selectstring = 
		' c.cid, c.kid, c.cname, g.gname, c.grade gradeid,ut.userid,ut.name uname,ut.mobile, 
					 CASE WHEN SM.userid is null then 0 ELSE sm.roletype END [state]',      --查询字段
		@returnstring = 
		'cid, kid, cname, gname, gradeid, userid, uname, mobile, [state]',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' CASE WHEN  SM.userid is null then 999 else sm.roletype end,c.grade desc, c.cid',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @kid
	
END



GO

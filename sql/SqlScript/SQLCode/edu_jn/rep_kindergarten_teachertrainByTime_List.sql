USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teachertrainByTime_List]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	取某个园当天的学生晨检记录
-- Memo:		exec rep_kindergarten_teachertrainByTime_List 19198,0,16,11,1,10
*/
CREATE PROCEDURE [dbo].[rep_kindergarten_teachertrainByTime_List]
	@gid int,
	@aid int,
	@timetype int,
	@level int,
	@page int,
	@size int
AS
begin
	SET NOCOUNT ON
	DECLARE 
			@fromstring NVARCHAR(2000)
	SET @fromstring = 
	'rep_kininfo r
		inner join kininfoapp..group_teachertrain g on r.uid=g.userid 
		inner join BasicData..teacher t on t.userid=r.uid
		where r.kid=@D1 
			and usertype=1 '
	IF 	@timetype<>-1	SET @fromstring = @fromstring + ' AND  timetype=@D2'
	IF 	@level<>-1	SET @fromstring = @fromstring + ' AND  [level]=@D3'
	exec	sp_MutiGridViewByPager
			@fromstring = @fromstring,      --数据集
			@selectstring = 
			'g.userid,r.uname,dbo.GetDictByid(g.timetype) timetype,dbo.GetDictByid(g.[level]) [level],
					t.title,t.post,t.education,t.employmentform,t.politicalface',      --查询字段
			@returnstring = 
			'userid, uname,timetype,[level], title, post, education, employmentform, politicalface',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' g.userid',          --排序条件
			@IsRecordTotal = 1,             --是否输出总记录条数
			@IsRowNo = 0,										 --是否输出行号
			@D1 = @gid,										
			@D2 = @timetype,										
			@D3 = @level

end

GO

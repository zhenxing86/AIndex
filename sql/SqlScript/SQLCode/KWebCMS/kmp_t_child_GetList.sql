USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_t_child_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 好友总数	
-- Memo:
exec kmp_t_child_GetList   10290,0,'谭苗苗园长',1,10
*/
CREATE PROCEDURE [dbo].[kmp_t_child_GetList]
	@siteid int,
	@classid int,
	@sitename nvarchar(50),
	@page int,
	@size int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE 
			@fromstring NVARCHAR(max)				--数据集
	set @fromstring = 'basicdata.dbo.[user] u 
			inner join basicdata.dbo.user_class uc on u.userid=uc.userid
			inner join basicdata.dbo.class c on uc.cid=c.cid
			inner join basicdata.dbo.child c1 on c1.userid=u.userid  
			WHERE u.deletetag = 1 
			and u.usertype = 0 
			AND u.kid = @D1'
	IF (@classid>0)		
	set @fromstring = @fromstring + ' AND uc.cid = @D2 ' 
		exec	sp_MutiGridViewByPager
			@fromstring = @fromstring,      --数据集
			@selectstring = 
			'u.userid,'''' blank1,u.name,''''blank2,cast(u.birthday as varchar(30)) birthday,u.gender,u.nation,u.address,u.mobile,u.mobile mobile1,
			u.kid,uc.cid,c1.fathername,c1.mothername,u.enrollmentdate,u.regdatetime,1 status1,''''blank3,''''blank4,
			c1.vipstatus,1 status2,
			startdate=(SELECT top 1 startdate FROM zgyey_om..vipdetails v WHERE u.userid=v.userid AND iscurrent=1 order by startdate desc),
			enddate=(SELECT top 1 enddate FROM zgyey_om..vipdetails v WHERE u.userid=v.userid AND iscurrent=1 order by enddate desc),
			feeamount=(SELECT top 1 feeamount FROM zgyey_om..vipdetails v WHERE u.userid=v.userid AND iscurrent=1 order by enddate desc)',      --查询字段
			@returnstring = 
			'userid, blank1, name, blank2, birthday, gender, nation, address, mobile, mobile1,
			 kid, cid, fathername, mothername, enrollmentdate, regdatetime, status1, blank3, blank4,
			 vipstatus, status2, startdate,	enddate, feeamount',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' u.userid	',          --排序条件
			@IsRecordTotal = 0,             --是否输出总记录条数
			@IsRowNo = 0,										 --是否输出行号
			@D1 = @siteid,										 
			@D2 = @classid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_t_child_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_t_child_GetList', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_t_child_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO

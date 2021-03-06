USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[GetTeaInfoUpdateStatus]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012-10-16 21:55:38
/*test

select * 
		from teainfo s left join basicdata..user_baseinfo u
			on s.teaid=u.userid			 
			where s.kid=11061 and u.updatetime<='2013-07-16 19:35:55'
exec [GetTeaInfoUpdateStatus] 12511,'001251100',0,'2013-08-09 09:02:55'

*/
------------------------------------
CREATE PROCEDURE [dbo].[GetTeaInfoUpdateStatus]
@kid int,
@devid varchar(10),
@s_cnt int,
@lupdate datetime
 AS

	declare @server_stucnt int
   if(@s_cnt=0)
	begin
		set @lupdate='2000-01-01';
	end
				
   select @server_stucnt=COUNT(*) 
		from basicdata..[user] u left join teainfo s 
			on s.teaid=u.userid			 
			where u.kid=@kid and u.updatetime>=@lupdate and u.usertype not in(0,98)
    if(@server_stucnt=0)
		select 0	
	if(@s_cnt =0 or @server_stucnt>0)
		select 2
	else
		select 0


GO

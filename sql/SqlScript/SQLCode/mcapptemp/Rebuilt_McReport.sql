USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[Rebuilt_McReport]    Script Date: 2014/11/24 23:19:16 ******/
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
CREATE PROC [dbo].[Rebuilt_McReport]
	@kid int
as
begin
	set nocount on
	--清空计数器
	update  HealthApp.DBO.ExceptionCount 
			set recentupdate = 0,
					lbtcount = 0, 
					hlfycount= 0, 
					kscount= 0, 
					fscount= 0, 
					hycount= 0, 
					szkcount= 0, 
					fxcount= 0, 
					pccount= 0, 
					jzjcount= 0, 
					fytxcount= 0, 
					gocount = 0
		where kid = @kid
		
	update  mcapp.DBO.zz_counter 
			set recentupdate = 0,
					fs = 0,
					ks = 0,
					hlfy = 0,
					pz = 0,
					fx = 0,
					hy = 0,
					Isweak = 0,
					star3 = null,
					star4 = null,
					star5 = null
		where kid = @kid

	--删除班级报表
	delete rep_mc_class_checked_sum where kid = @kid
	--删除幼儿园报表
	delete record_mc_kid_day where kid = @kid
	--删除出勤日期列表
	delete mc_kid_date_list where kid = @kid 

	--补齐stu_mc_day 表
	INSERT INTO mcapp..stu_mc_day(CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype)
	select cdate,t.kid,uc.userid,t.card,t.cdate,t.tw,t.zz,t.adate,t.devid,t.gunid,0,1 
		from stu_mc_day_raw t 
			inner join mcapp..cardinfo c
				on t.card = c.card
			inner join basicdata..[user_Child] uc 
				on c.userid = uc.userid 
		where t.kid = @kid
			and ISNUMERIC(t.tw) = 1    
		
	--将 mcapp..stu_mc_day 的status 设为0
	UPDATE  mcapp..stu_mc_day SET Status = 0
		WHERE kid = @kid
		
	--执行 重新生成报表
	exec sqlagentdb..SMS_yz_day_New 1
end

GO

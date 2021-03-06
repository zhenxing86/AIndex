USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetStafferListByDepartmentid]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------      
--用途:取教师列表      
--项目名称：classhomepage      
--说明：      class_sms_GetStafferListByDepartmentid 0,14570
--时间：2009-7-18 14:54:31      
------------------------------------      
CREATE PROCEDURE [dbo].[class_sms_GetStafferListByDepartmentid]      
@departmentid int,      
@kid int      
AS      
IF(@departmentid=0)      
BEGIN      
 select t1.userid,t1.name,commonfun.dbo.fn_cellphone(t1.mobile) mobileview,t1.mobile From BasicData.dbo.[user] t1      
 inner join BasicData.dbo.teacher t4 on t1.userid=t4.userid      
 where t1.kid = @kid       
 and t1.usertype<>98 and t1.usertype<>0      
 and t1.deletetag=1       
 and  t1.mobile is not null       
    
 order by t1.name desc      
END      
ELSE      
BEGIN      
 select t1.userid,t1.name,commonfun.dbo.fn_cellphone(t1.mobile) mobileview,t1.mobile From BasicData.dbo.[user] t1      
 inner join BasicData.dbo.teacher t4 on t1.userid=t4.userid      
 where t1.kid = @kid       
 and t1.usertype<>98   and t1.usertype<>0      
 and t1.deletetag=1       
 and t4.did =@departmentid       
 and  t1.mobile is not null       
 order by t1.name desc      
END 
GO

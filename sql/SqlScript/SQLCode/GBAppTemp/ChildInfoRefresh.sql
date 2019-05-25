USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[ChildInfoRefresh]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChildInfoRefresh]
AS
BEGIN
 update t1 set t1.birthday=t2.birthday,t1.child_name=t2.name 
 from childreninfo t1 
 left join basicdata..[user] t2  
 on t1.userid=t2.userid
where t1.birthday='1900-01-01' 
and t2.birthday>'1900-01-01'
end

GO

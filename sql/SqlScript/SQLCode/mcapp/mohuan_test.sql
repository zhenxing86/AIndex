USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mohuan_test]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[mohuan_test] 
@kid int
AS     
begin 
Exec reportapp..[class_activitycount_GetListByPage] @kid,'2013/2/1 16:09:22','2014/10/11 16:09:22','visitscount',1,20

 --select top 10 logid,devid,gunid,logmsg,result,logtime,uploadtime,kid
 --from
 -- mcapp..loginfo 
 -- where logtype = 16
 -- and kid = @kid
 
 --select top 10 logid,devid,gunid,logmsg,result,logtime,uploadtime,kid
 --from
 -- mcapp..loginfo 
 -- where logtype = 16
 -- and kid = @kid
  
 -- select top 10 logid,devid,gunid,logmsg,result,logtime,uploadtime,kid
 --from
 -- mcapp..loginfo 
 -- where logtype = 16
 -- and kid = @kid
 
end 
GO

USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[user_del_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------  
--author: xie
--用途：查询用户删除信息列表
--项目名称： mcapp ，客户端采集软件
--说明：根据更新时间、kid获取用户删除信息
--时间：2012-10-16 21:55:38  
--memo:
--user_del_GetList 12511,'2013-1-16 21:55:38 '   
------------------------------------  
CREATE PROCEDURE [dbo].[user_del_GetList]  
 @kid int,  
 @l_update datetime  
 AS  
BEGIN  
 SET NOCOUNT ON 
  SELECT userid,usertype 
    FROM  BasicData..User_Del
    where kid = @kid   
    and updatetime >= @l_update   

END  

GO

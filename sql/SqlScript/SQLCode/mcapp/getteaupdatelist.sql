USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[getteaupdatelist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：查询记录信息   
--项目名称：  
--说明：  
--时间：2012-10-16 21:55:38  
--[getteaupdatelist] 8812,'000881201'  
--[getteaupdatelist] 12511,'001251101',0,'2013-01-01'  
------------------------------------  
CREATE PROCEDURE [dbo].[getteaupdatelist]  
 @kid int,  
 @devid varchar(10),  
 @cnt int,  
 @l_update datetime  
 AS  
BEGIN  
 SET NOCOUNT ON  
 if(@cnt=0)  
 begin  
   SELECT ut.userid,c.cardno card,ut.name,case ut.gender when '2' then '0' when '3' then '1' end, ut.tts,ut.sname   
    FROM BasicData..User_Teacher ut    
     left join mcapp..cardinfo c   
      on c.userid = ut.userid  
    where ut.kid = @kid   
 end  
 else  
 begin  
  SELECT ut.userid,c.cardno card,ut.name,case ut.gender when '2' then '0' when '3' then '1' end , ut.tts,ut.sname  
    FROM  BasicData..User_Teacher ut    
    left join mcapp..cardinfo c   
     on c.userid=ut.userid  
   where ut.kid = @kid   
    and ut.updatetime >= @l_update   
 end  
END  
GO

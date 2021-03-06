USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[getgbinfoV2]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie   
-- Create date: 2014-02-11      
-- Description: 读取成长档案的数据      
-- Memo:use ngbapp      
select * from growthbook where userid=295765      
[getgbinfoV2] 79818,'2013-0'     
*/      
create PROCEDURE [dbo].[getgbinfoV2]    
@cid int  
,@term nvarchar(10)='2013-0'  
 AS    
select gb.gbid  
           ,uc.name  
            from ngbapp..growthbook gb 
inner join basicdata..[User_Child] uc on gb.userid=uc.userid   
where uc.cid=@cid and  
 gb.term=@term
order by uc.name  
  
--select * from basicdata..class where kid=12511  
GO

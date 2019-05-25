USE GBApp
GO
/*          
-- Author:      xie       
-- Create date: 2014-02-11          
-- Description: 读取成长档案的数据          
-- Memo:use ngbapp          
select * from growthbook where userid=295765          
[getgbinfoV2] 79818,'2013-0'         
*/          
CREATE PROCEDURE [dbo].[getgbinfoV2]        
@cid int      
,@term nvarchar(10)='2013-1'      
 AS 
 BEGIN       
	select gb.gbid,uc.name      
	 from ngbapp..growthbook gb     
	  inner join basicdata..user_child uc
	   on gb.userid=uc.userid       
	  inner join BasicData..child c on gb.userid=c.userid and c.vipstatus=1    
	  where uc.cid=@cid 
	   and gb.term=@term    
	  order by uc.name      
END 
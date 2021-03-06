/*  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description:   
-- Memo:    
child_Baseinfo_GetModel 519979  
*/  
alter PROCEDURE child_Baseinfo_GetModel  
 @userid int  
AS  
BEGIN  
 SET NOCOUNT ON   
 declare @cid int ,@ngbid int =0
   
 select top  1 @cid = cid   
  from user_class   
  where userid = @userid  
    
    
    if(exists(select count(1) from ngbapp..growthbook where userid= @userid))
    begin
		set @ngbid=1
    end
    
    
 SELECT u.name, u.nickname, u.gender, u.birthday, u.mobile, u.exigencetelphone,   
     u.email, u.[address], c.fathername, c.mothername, c.favouritething, c.fearthing,   
     c.favouritefoot, c.footdrugallergic, u.headpic, u.headpicupdate, u.privince,   
     u.city,s.sitedns, ubu.bloguserid, u.tiprule, 0 as network, @cid,@ngbid  
  FROM [user] u  
   left join  child c on u.userid = c.userid   
   left join  user_bloguser ubu on u.userid = ubu.userid   
   left join  kwebcms..[site] s on u.kid = s.siteid  
  Where u.userid = @userid              
END  
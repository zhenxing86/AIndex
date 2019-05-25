USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[getgbinfo]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
--select * from growthbook where gbid=154676    
      
CREATE PROCEDURE [dbo].[getgbinfo]      
@cid int   
,@term nvarchar(10)='2013-0'    
 AS      
    
select gb.gbid    
           ,c.child_name    
            from growthbook gb left join homebook hb on gb.hbid=hb.hbid     
left join childreninfo c on gb.gbid=c.gbid    
inner join basicdata..[user] u on gb.userid=u.userid    
inner join basicdata..user_class uc on u.userid=uc.userid    
where u.deletetag=1 and  uc.cid=@cid and    
 hb.term=@term  
--and gb.gbid=68955    
--and gb.userid=384921    
and hb.classid=@cid    
order by c.child_name    
    
    
--select * from basicdata..class where kid=14979    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
GO

USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[GetTermAndRiseClass]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获取学期信息和升班信息  
-- exec GetTermAndRiseClass 23115,'2014/8/25 15:19:16'  
CREATE proc [dbo].[GetTermAndRiseClass]    
@kid int,    
@date datetime    
as    
begin    
declare @temp     
table    
(term varchar(50),    
cansetterm int,    
haschgclassterm int,    
riseclass int)    
declare @name varchar(50),@douserid int,@dotime datetime    
    
 select @name=name,@douserid=douserid,@dotime=actiondate from     
 (select top 1 kid,actiondate,douserid from basicdata..class_changehistory where kid=@kid  group by kid,actiondate,douserid    
 order by actiondate desc) tb join basicdata..[user] on userid=tb.douserid and deletetag=1    
    
 insert into @temp   exec  CommonFun..GetTermInfo  @kid, @date     
     
   
 select term,cansetterm,haschgclassterm,riseclass,@douserid,@name,@dotime from @temp     
     
end
GO

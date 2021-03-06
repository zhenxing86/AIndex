USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[buginfo_Add]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*          
-- Author:      xie    
-- Create date: 2013-11-28          
-- Description:           
-- Memo:            
exec buginfo_Add 1,10,12511,'帼英',6,-1,'2013-11-27 10:00:00','2013-11-28 23:59:59'          
*/          
CREATE PROCEDURE [dbo].[buginfo_Add]          
@bugdes varchar(max),  
@kid int, 
@bugtype int, 
@enddate datetime,     
@douserid int,   
@process int, 
@dodate datetime,
@userid int,
@smallbugtype int 
       
 AS           
begin   
    declare @serialno int   
    select @serialno = max(isnull(serialno,1000))+1 
     from buginfo 
     where applydate>= CONVERT(varchar(10), GETDATE(),120) 
      and applydate<=GETDATE()   
        
        if @serialno is null
			select @serialno=1001
        
    insert into buginfo(applydate,bug_des,kid,bug_type,enddate,
     douserid,process,dodate,userid,update_userid,serialno,small_bug_type)
     values(GETDATE(),@bugdes,@kid,@bugtype,@enddate,
     @douserid,@process,@dodate,@userid,@userid,@serialno,@smallbugtype)

if @@ERROR>0
	return -1
else return 1	

end     


GO

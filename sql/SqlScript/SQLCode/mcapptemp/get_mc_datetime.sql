USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[get_mc_datetime]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:        
-- Create date:   
-- Description:   
-- Memo:  
   EXEC [get_mc_datetime] 12511,1,'2013-04-29'  
*/  
CREATE PROCEDURE [dbo].[get_mc_datetime]    
 @kid int,    
 @day int,    
 @checktime1 datetime    
as  
BEGIN    
SET NOCOUNT ON
  
declare @ctime datetime

if(@day=-1)  
begin  
 ;with cet  
  as  
  (  
   select distinct cdate from rep_mc_class_checked_sum  
   where kid=@kid and cdate<@checktime1  
  )  
 select top 1 @ctime=cdate from cet order by cdate desc  
 if(@ctime is null)
	begin
		 select @ctime=min(cdate) from rep_mc_class_checked_sum where kid=@kid 
	end

end  
else  
begin  
 ;with cet  
  as  
  (  
   select distinct cdate from rep_mc_class_checked_sum  
   where kid=@kid and cdate>@checktime1  
  )  
 select top 1 @ctime=cdate from cet order by cdate asc 
  if(@ctime is null)
	begin
		 select @ctime=max(cdate) from rep_mc_class_checked_sum where kid=@kid 
	end 
end  


select @ctime


  select top 1 cdate from rep_mc_class_checked_sum  
   where kid=@kid and cdate=@checktime1  
   
END   

GO

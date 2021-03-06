USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetClassPotosList]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      xie        
-- Create date: 2014-10-29        
-- Description: h   
-- Memo:        
GetClassAlbumList 531,24989,'2014-0'       
*/        
--        
CREATE PROC [dbo].[GetClassPotosList]   
@kid int   
,@albumid int   
,@term nvarchar(6)       
AS        
BEGIN      
    declare @bgn datetime,@end datetime   
 --exec commonfun.dbo.Calkidterm @kid, @term, @bgn output, @end output   
 if @kid = 14926 
  begin
    if @term in ('2014-0','2013-1')
    begin
		set @bgn='2013-09-01 00:00:00.000'
		set @end ='2014-09-01 00:00:00.000'
    end
    else if @term in ('2013-0','2012-1')
    begin
		set @bgn='2012-09-01 00:00:00.000'
		set @end ='2013-09-01 00:00:00.000'
    end
  end
  else
  begin
	exec commonfun.dbo.Calkidterm @kid, @term, @bgn output, @end output 
  end
    
   
 SELECT photoid,albumid,title,filename,filepath,filesize,viewcount,commentcount,  
  uploaddatetime,iscover,isfalshshow,classapp.dbo.IsNewPhoto(uploaddatetime) AS newphoto,orderno,net    
     FROM classapp..class_photos  
     where albumid=@albumid AND status=1  
      and uploaddatetime>=@bgn and uploaddatetime<= @end       
     order by orderno desc    
    
    
END  
     
       
       
           
      
      
      
      
      
      
      
      
      
     
  
GO

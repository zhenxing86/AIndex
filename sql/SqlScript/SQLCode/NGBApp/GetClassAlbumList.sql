USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetClassAlbumList]    Script Date: 2014/11/24 23:18:26 ******/
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

GetClassAlbumList 14938,60248,'2014-0'  
       
*/          
--          
CREATE PROC [dbo].[GetClassAlbumList]     
@kid int     
,@classid int     
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
       
  if (@kid =14938)
  begin
	 SELECT a.albumid,a.title,a.description,a.photocount,a.classid,a.kid,a.userid,a.author,a.createdatetime,    
	  a.coverphoto AS defaultcoverphoto, a.coverphoto,classapp.dbo.IsNewPhoto(a.lastuploadtime) AS newalbum,0 AS isblogalbum,    
	  coverphotodatetime AS defaultphotodatetime,a.coverphotodatetime,ca.cname as classname,a.net        
	   FROM classapp..class_album  a     
		inner join BasicData.dbo.class_all ca     
	  on a.classid=ca.cid and ca.deletetag=1     
	   and ca.term=@term       
	   where  a.classid=@classid and a.status = 1     
	   --and a.createdatetime>=@bgn and a.createdatetime<= @end        
	   order by a.createdatetime desc  
   end
   else
   begin
	   SELECT a.albumid,a.title,a.description,a.photocount,a.classid,a.kid,a.userid,a.author,a.createdatetime,    
		  a.coverphoto AS defaultcoverphoto, a.coverphoto,classapp.dbo.IsNewPhoto(a.lastuploadtime) AS newalbum,0 AS isblogalbum,    
		  coverphotodatetime AS defaultphotodatetime,a.coverphotodatetime,ca.cname as classname,a.net        
		   FROM classapp..class_album  a     
			inner join BasicData.dbo.class_all ca     
		  on a.classid=ca.cid and ca.deletetag=1     
		   and ca.term=@term       
		   where  a.classid=@classid and a.status = 1     
		   and a.createdatetime>=@bgn and a.createdatetime<= @end        
		   order by a.createdatetime desc  
   end    
      
END    
       
         
         
             
        
        
        
        
        
        
        
        
        
       
GO

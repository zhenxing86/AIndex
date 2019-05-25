use NGBApp
go
/*      
-- Author:      xie      
-- Create date: 2014-10-29      
-- Description: h 
-- Memo:      
[GetKinClassInfo] 224899     
*/      
--      
CREATE PROC [dbo].[GetKinClassInfo]      
 @classid int 
 ,@term nvarchar(6)     
AS      
BEGIN    
    
 select k.kname,ca.cname 
  from BasicData..class_all ca   
    inner join BasicData..kindergarten k
     on ca.kid = k.kid
    where ca.deletetag = 1
     and ca.cid=@classid
     and ca.term=@term     
END   
go

use NGBApp
go
/*      
-- Author:      xie      
-- Create date: 2014-10-29      
-- Description: h 
-- Memo:      
GetClassAlbumList 531,24989,'2014-0'     
*/      
--      
CREATE PROC [dbo].GetClassAlbumList 
@kid int 
,@classid int 
,@term nvarchar(6)     
AS      
BEGIN    
    declare @bgn datetime,@end datetime 
	exec commonfun.dbo.Calkidterm @kid, @term, @bgn output, @end output   
	
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
  
END

go
use NGBApp
go
/*      
-- Author:      xie      
-- Create date: 2014-10-29      
-- Description: h 
-- Memo:      
GetClassAlbumList 531,24989,'2014-0'     
*/      
--      
CREATE PROC [dbo].GetClassPotosList 
@kid int 
,@albumid int 
,@term nvarchar(6)     
AS      
BEGIN    
    declare @bgn datetime,@end datetime 
	exec commonfun.dbo.Calkidterm @kid, @term, @bgn output, @end output   
	
	SELECT photoid,albumid,title,filename,filepath,filesize,viewcount,commentcount,
	 uploaddatetime,iscover,isfalshshow,classapp.dbo.IsNewPhoto(uploaddatetime) AS newphoto,orderno,net  
     FROM classapp..class_photos
     where albumid=@albumid AND status=1
      and uploaddatetime>=@bgn and uploaddatetime<= @end     
     order by orderno desc  
END
    
    
   




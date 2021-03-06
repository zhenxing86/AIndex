use KWebCMS
go
-- =============================================        
-- Author:lx        
-- Create date: 2009-01-12        
-- Description: 添加文章        
-- ============================================        
alter PROCEDURE [dbo].[cms_content_Add]        
@categoryid int,        
@content ntext,        
@title nvarchar(150),        
@titlecolor nvarchar(10),        
@author nvarchar(20),        
@searchkey nvarchar(50),        
@searchdescription nvarchar(100),        
@browsertitle nvarchar(100),        
@commentstatus bit,        
@status bit,        
@siteid int,      
@crttime datetime=null,    
@isshow int=0,    
@showtime int =1    
AS        
BEGIN        
 declare @orderno int        
 select @orderno=Max(orderno)+1 from cms_content where siteid=@siteid and categoryid=@categoryid and deletetag = 1      
        
 IF @orderno is null        
 BEGIN        
  SET @orderno=0        
 END       
       
 if @crttime is null      
 begin      
 set @crttime=GETDATE()      
 end       
  declare @newid int      
INSERT INTO [KWebCMS].[dbo].[cms_content]        
           ([categoryid]        
           ,[content]        
           ,[title]        
           ,[titlecolor]        
           ,[author]        
           ,[createdatetime]        
           ,[searchkey]        
           ,[searchdescription]        
           ,[browsertitle]        
           ,[viewcount]        
           ,[commentcount]        
           ,[orderno]        
           ,[commentstatus]        
           ,[ispageing]        
           ,[status]        
           ,[siteid],appcontent)           
 values(@categoryid,@content,@title,@titlecolor,@author,@crttime,@searchkey,@searchdescription,@browsertitle,0,0,@orderno,@commentstatus,0,@status,@siteid,@content)        
   set @newid=SCOPE_IDENTITY()      


if exists(select 1 from cms_category where categorycode='TVX' and siteid =@siteid and categoryid=@categoryid) --tvshow    
begin    
  declare @url nvarchar(200),@orderby int    
 select @orderby=Max(orderby)+1 from tv_show where kid=@siteid and deletetag = 1      
     
  insert into tv_show(kid,showtime,isshow,deletetag,contentid)    
   select siteid,@showtime,@isshow,1,@newid    
    from kwebcms..[site] s    
    where siteid=@siteid    
       
end    
    
 IF @@ERROR <> 0         
 BEGIN         
    RETURN(-1)        
 END        
 ELSE        
 BEGIN        
    RETURN @newid        
 END        
END 
 use KWebCMS
 go     
-- =============================================      
-- Author:  hanbin      
-- Create date: 2009-01-12      
-- Description: 文章内容更新   更新content,title,titlecolor,author,searchkey,searchdescription,browsertitle,commentstatus八项      
-- =============================================      
alter PROCEDURE [dbo].[cms_content_Update]      
@contentid int,      
@content ntext,      
@title nvarchar(150),      
@titlecolor nvarchar(20),      
@author nvarchar(40),      
@searchkey nvarchar(150),      
@searchdescription nvarchar(200),      
@browsertitle nvarchar(200),      
@commentstatus bit,    
@crttime datetime=null,  
@isshow int=0,  
@showtime int =1      
AS       
BEGIN      
   
 declare @categoryid int =0  
 UPDATE cms_content       
 SET [content] = @content,[author]=@author,[title] = @title,[searchkey] = @searchkey,    
 [searchdescription] = @searchdescription,[browsertitle] = @browsertitle,[commentstatus] = @commentstatus,[createdatetime] =isnull(@crttime,[createdatetime]) ,appcontent=@content    
WHERE [contentid] = @contentid      
  
 select @categoryid=categoryid from cms_content WHERE [contentid] = @contentid      
   
declare @siteid int      
select @siteid=siteid from cms_content where [contentid]=@contentid      
  
if exists(select 1 from cms_category where categorycode='TVX' and siteid =@siteid and categoryid=@categoryid) --tvshow    
begin 
     
   update tv_show set isshow =@isshow,showtime=@showtime   
    where contentid=@contentid  
     
end  
  
exec [kweb_site_RefreshIndexPage] @siteid      
      
 IF @@ERROR <> 0       
 BEGIN       
    RETURN(-1)      
 END      
 ELSE      
 BEGIN      
    RETURN (1)      
 END      
END 
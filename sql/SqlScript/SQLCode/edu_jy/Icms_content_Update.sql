

alter PROCEDURE Icms_content_Update 
@contentid int,  
@title nvarchar(max),  
@content varchar(max),  
@siteid int
 AS   
BEGIN  

SET NOCOUNT ON

update cms_content 
		set title=@title,
			content=@content
		where siteid=@siteid
			and (contentid-2147483647)=@contentid 
			and [status]=2
END  
  
go


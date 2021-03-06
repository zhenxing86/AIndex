USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[questions_add]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[questions_add]      
@testid int,      
@title nvarchar(200),      
   
@categoryid int      
as      
begin      
 declare @orderno int      
 select @orderno=isnull(MAX(orderno),0) from Questions      
 insert into Questions(testid,title,categoryid) values(@testid,@title,@categoryid)      
if(@@ERROR<>0)      
 return -1      
 else      
 return @@identity
end 
GO

USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[options_Delete]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[options_Delete]  
@id int  
as  
begin  
delete from options where id=@id  
if(@@ERROR<>0)  
 return -1  
 else  
 return 1  
end  
GO

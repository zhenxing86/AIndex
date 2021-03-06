USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testpapercategory_add]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[testpapercategory_add]  
 
@title nvarchar(200),
@description nvarchar(max)  
as   
begin  
declare @orderno int
select @orderno=isnull(max(orderno),0)+1 from  Category
insert into  Category( categorytitle,[description],orderno) values( @title,@description,@orderno)  
if(@@ERROR<>0)  
return 0  
else  
return 1  
end

GO

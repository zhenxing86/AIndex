USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[options_GetList]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [dbo].[options_GetList]  
 @questionid int     
as       
begin      
select  id,questionid, content,score from options   where questionid=@questionid
       
end

GO

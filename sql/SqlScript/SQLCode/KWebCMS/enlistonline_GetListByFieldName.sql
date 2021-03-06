USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonline_GetListByFieldName]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[enlistonline_GetListByFieldName]    
@siteid int,        
@filedname varchar(500),    
@page int,        
@size int,    
@Counts int  output    
as    
begin    
declare @pageCount int, @strwhere varchar(5000)    
set @strwhere=' and siteid='+cast(@siteid as varchar(50))   
  
exec proc_GetPageOfRecords 'enlistonline',@filedname,@size,@page,@pageCount output,@Counts,'id',1,@strwhere,id,0    
end    
GO

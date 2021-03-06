USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonline_GetListByFieldNameAndDateRange]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[enlistonline_GetListByFieldNameAndDateRange]    
@siteid int,        
@filedname varchar(500),    
@page int,        
@size int,   
@starttime varchar(200)='1900-01-01 00:00:00.000',    
@endtime varchar(200)='1900-01-01 00:00:00.000'  
as    
begin    
declare @pageCount int,@Counts int, @strwhere varchar(5000)    
set @strwhere=' and siteid='+cast(@siteid as varchar(50))   
if(@starttime!='1900-01-01 00:00:00.000')  
begin  
set @strwhere=@strwhere +'  and createdatetime> '''+@starttime +' '''  
end  
if(@endtime!='1900-01-01 00:00:00.000')  
begin  
set @strwhere=@strwhere +'  and createdatetime< '''++@endtime+''' '  
end  
  
exec proc_GetPageOfRecords 'enlistonline',@filedname,@size,@page,@pageCount output,@Counts,'id',1,@strwhere,id,0    
  
end    
GO

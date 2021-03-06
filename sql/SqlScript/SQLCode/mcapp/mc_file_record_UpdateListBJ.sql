USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_file_record_UpdateListBJ]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
create proc [dbo].[mc_file_record_UpdateListBJ] 
@idlst varchar(max)  
,@erridlst varchar(max)  
,@startdate datetime    
,@enddate datetime    
as    
  
CREATE TABLE #ID(col int)   
CREATE TABLE #ID_ERROR(col int)    
  
INSERT INTO #ID    
 select distinct col  --将输入字符串转换为列表    
 from BasicData.dbo.f_split(@idlst,',')    
  
INSERT INTO #ID_ERROR    
 select distinct col   
 from BasicData.dbo.f_split(@erridlst,',')    
      
update r    
 set ftype=2,startdate=@startdate,enddate=@enddate  
 from mc_file_recordBJ r  
  inner join #ID i   
   on r.id = i.col  
  
update r    
 set ftype=3,startdate=@startdate,enddate=@enddate   
 from mc_file_recordBJ r  
  inner join #ID_ERROR i   
   on r.id = i.col  
  
drop table #ID,#ID_ERROR  
  
 if @@ERROR<>0    
 return -1    
 else     
 return 1    
     
  

GO

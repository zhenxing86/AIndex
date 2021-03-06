USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_file_record_UpdateList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
author: xie
altertime: 2014-09-16 17:40
des: 将晨检数据写入到数据库后，将记录修改为已处理（晨检数据写入失败，标记为失败。）

demo：
*/
CREATE proc [dbo].[mc_file_record_UpdateList]      
@idlst varchar(max)    
,@erridlst varchar(max)    
,@startdate datetime      
,@enddate datetime      
as      
    
CREATE TABLE #ID(col int)     
CREATE TABLE #ID_ERROR(col int)      
    
INSERT INTO #ID      
 select distinct col   --将输入字符串转换为列表      
 from BasicData.dbo.f_split(@idlst,',')      
    
INSERT INTO #ID_ERROR      
 select distinct col     
 from BasicData.dbo.f_split(@erridlst,',')      

update r      
 set ftype=2,startdate=@startdate,enddate=@enddate    
 from mc_file_record r    
  inner join #ID i     
   on r.id = i.col    
    
update r      
 set ftype=3,startdate=@startdate,enddate=@enddate     
 from mc_file_record r    
  inner join #ID_ERROR i     
   on r.id = i.col    
    
drop table #ID,#ID_ERROR    
    
 if @@ERROR<>0      
 return -1      
 else       
 return 1      
       
    


GO

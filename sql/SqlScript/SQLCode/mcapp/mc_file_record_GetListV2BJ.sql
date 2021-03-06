USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_file_record_GetListV2BJ]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*          
author: xie          
altertime: 2014-09-16 17:40          
des: 获取待处理的晨检数据记录          
          
demo： mcapp         
        
select *from mc_file_record where ftype=6        
        
*/    
create proc [dbo].[mc_file_record_GetListV2BJ]  
@lastdate datetime      
as          
       
update mc_file_recordBJ           
 set ftype = 1         
 output Deleted.id,Deleted.kid,Deleted.devid,Deleted.filepath,Deleted.[filename]          
where ftype=0 and crtdate<=@lastdate 

GO

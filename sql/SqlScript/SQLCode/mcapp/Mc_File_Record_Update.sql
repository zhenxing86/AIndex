USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[Mc_File_Record_Update]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Mc_File_Record_Update] 
@id int 
,@ftype int
,@startdate datetime
,@enddate datetime
,@succeedcnt int 
,@errorcnt int
as

update mc_file_record set ftype=@ftype,startdate=@startdate ,
 enddate=@enddate,succeedcnt=@succeedcnt,errorcnt=@errorcnt
  where id =@id
  
   if @@ERROR<>0  
 return -1  
 else   
 return 1 
GO

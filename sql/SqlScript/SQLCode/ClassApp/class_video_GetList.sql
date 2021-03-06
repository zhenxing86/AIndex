USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_video_GetList]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
/*------------------------------------    
--用途：根据kid、班级id、学期获取班级视频(.flv)信息     
--说明：    
--时间：2014-06-26  
  
exec [class_video_GetList] 12511,46144,'2014-0'    
exec [class_video_GetList] 14926,56750,'2014-0'    
  
select top 10* from ClassApp..class_video where kid =12511 
 
 declare @bgn datetime,@end datetime   
 exec commonfun.dbo.Calkidterm 0, '2013-0', @bgn output, @end output  
 select @bgn,@end 
------------------------------------  */  
CREATE PROCEDURE [dbo].[class_video_GetList]    
@kid int,    
@classid int,    
@term nvarchar(50)    
 AS    
  declare @bgn datetime,@end datetime   
BEGIN  
    
  if @kid = 14926 
  begin
    if @term in ('2014-0','2013-1')
    begin
		set @bgn='2013-09-01 00:00:00.000'
		set @end ='2014-09-01 00:00:00.000'
    end
    else if @term in ('2013-0','2012-1')
    begin
		set @bgn='2012-09-01 00:00:00.000'
		set @end ='2013-09-01 00:00:00.000'
    end
  end
  else
  begin
	exec commonfun.dbo.Calkidterm @kid, @term, @bgn output, @end output 
  end
  
  SELECT  t1.videoid,t1.userid,t1.classid,t1.kid,t1.title,'',t1.filename,t1.filepath,t1.filesize,    
    t1.viewcount,t1.commentcount,t1.uploaddatetime,t1.author,t1.coverphoto,'' as classname,t1.weburl,t1.videotype,t1.net    
  FROM class_video t1    
  where t1.classid=@classid and t1.status=1    
   and uploaddatetime>=@bgn and uploaddatetime<= @end and weburl='' and t1.filename like '%.flv'    
  order by t1.videoid desc    
    
END  
  
GO

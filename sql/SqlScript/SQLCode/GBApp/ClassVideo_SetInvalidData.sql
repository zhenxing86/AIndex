USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[ClassVideo_SetInvalidData]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		xie
-- Create date: 2012-12-20
-- Description:	获取指定服务器上的无效资源文件列表 （图片、视频）
-- =============================================
CREATE PROCEDURE [dbo].[ClassVideo_SetInvalidData] 
(
@dataType nvarchar(100),
@startTime datetime,
@endTime datetime
)
AS
BEGIN
    delete gbapp..invalid_data_temp
                
    if @dataType='classphotos'  
    begin
		insert into gbapp..invalid_data_temp(filepath,[filename])
		 select filepath,[filename] from classapp..class_photos 
		 where uploaddatetime between @startTime and @endTime
    end
    else if @dataType='cmsphoto'
    begin
		insert into gbapp..invalid_data_temp(filepath,[filename])
		 select filepath,[filename] from kwebcms..cms_photo 
		 where createdatetime between @startTime and @endTime
    end
    else if @dataType='classvideo'
    begin
		insert into gbapp..invalid_data_temp(filepath,[filename])
		 select filepath,[filename] from classapp..class_video 
		 where uploaddatetime between @startTime and @endTime
    end
    else if @dataType='cmscontentattachs'
    begin
		insert into gbapp..invalid_data_temp(filepath,[filename])
		 select filepath,[filename] from kwebcms..cms_contentattachs 
		 where createdatetime between @startTime and @endTime and deletetag = 1
    end if @dataType='classbackgroundmusic'
    begin
		insert into gbapp..invalid_data_temp(filepath,[filename])
		 select backgroundmusicpath, '' from classapp..class_backgroundmusic
		 where uploaddatetime between @startTime and @endTime
    end 
    
    
    update gbapp..invalid_data_temp set filepath = Replace(filepath,'\','/')
	update gbapp..invalid_data_temp set filepath = Replace(filepath,'//','/')
	update gbapp..invalid_data_temp set filepath = Replace(filepath,'//','/')
	update gbapp..invalid_data_temp set filepath = Replace(filepath,'//','/')
	update gbapp..invalid_data_temp set filepath = substring(filepath,2,len(filepath)-1) where filepath like '/%'
	
	
  if @dataType='classbackgroundmusic'
  begin
	  update gbapp..video_temp set [status]=0   where not exists 
	  (	select 1 from gbapp..invalid_data_temp v where v.filepath =video_temp.filepath+video_temp.[filename] )
  end
  else
  begin
	  update gbapp..invalid_data_temp set filepath = filepath+'/'  where filepath not like '%/'
	  update gbapp..video_temp set [status]=0   where not exists 
	  (	select 1 from gbapp..invalid_data_temp v where --v.filepath =video_temp.filepath  and
		v.[filename]=video_temp.[filename] )
  end
  IF @@ERROR <> 0 
  BEGIN 
	RETURN -1
  END
  ELSE
  BEGIN
	RETURN 1
  END

END






GO

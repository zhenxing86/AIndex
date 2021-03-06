USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[ClassVideo_GetList_By]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		xie
-- Create date: 2012-12-20
-- Description:	获取指定幼儿园Kid，指定服务器上的班级视频文件列表
-- ClassVideo_GetList_By 12511,39
--
/*select * from classapp..class_video 
		where kid = 14933 
			and net = 39 and uploaddatetime>='2013-03-01' 
*/
-- =============================================
CREATE PROCEDURE [dbo].[ClassVideo_GetList_By] 
	@kid int,
	@net int
AS
BEGIN
	SET NOCOUNT ON             
	select filepath, [filename] 	 
		into #invalid_data_temp
		from classapp..class_video 
		where kid = @kid 
			and net = 39 and uploaddatetime>='2013-03-01' 
			
    --统一格式'a/../c/'
	update #invalid_data_temp set filepath = Replace(filepath,'\','/')
	update #invalid_data_temp set filepath = Replace(filepath,'//','/')
	update #invalid_data_temp set filepath = Replace(filepath,'//','/')
	update #invalid_data_temp set filepath = Replace(filepath,'//','/')
	update #invalid_data_temp set filepath = substring(filepath,2,len(filepath)-1) where filepath like '/%'
	update #invalid_data_temp set filepath = filepath+'/'  where filepath not like '%/'
	
	select filepath,[filename] 
		from #invalid_data_temp
	drop table #invalid_data_temp
END





GO

USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetTea_UpPhotoByPage]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-12-5  
-- Description: 分页读取在园剪影
-- Memo:use ngbapp  
exec GetTea_UpPhotoByPage 2151,2
*/  
--  
CREATE PROC [dbo].[GetTea_UpPhotoByPage]
	@gbid bigint,
	@page int
AS
BEGIN  
	SET NOCOUNT ON   	
	exec	sp_MutiGridViewByPager
		@fromstring = 'tea_UpPhoto   
   where gbid=@D1 and deletetag=1',      --数据集
		@selectstring = 
		'photo_desc,m_path,updatetime',      --查询字段
		@returnstring = 
		'photo_desc,m_path,updatetime',      --返回字段
		@pageSize = 10,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' updatetime desc',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @gbid	

END	

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页读取在园剪影' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetTea_UpPhotoByPage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetTea_UpPhotoByPage', @level2type=N'PARAMETER',@level2name=N'@gbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetTea_UpPhotoByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO

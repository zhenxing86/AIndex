USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[Get_TeaUpPhoto]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-09-07
-- Description:	
-- Memo:  exec [Get_TeaUpPhoto] 50,1
*/
CREATE PROC [dbo].[Get_TeaUpPhoto]
@gbid int,
@type int
AS
select photoid,gbid,photo_desc,m_path,updatetime,pictype
   from
   tea_UpPhoto
    where gbid = @gbid
    and pictype=@type
   and deletetag=1
   

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'获取在园剪影' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Get_TeaUpPhoto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Get_TeaUpPhoto', @level2type=N'PARAMETER',@level2name=N'@gbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tea_UpPhoto的pictype' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Get_TeaUpPhoto', @level2type=N'PARAMETER',@level2name=N'@type'
GO

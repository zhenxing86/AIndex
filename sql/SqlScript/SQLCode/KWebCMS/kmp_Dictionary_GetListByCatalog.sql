USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Dictionary_GetListByCatalog]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 2010-10-24
-- Description:
-- =============================================
CREATE  PROCEDURE [dbo].[kmp_Dictionary_GetListByCatalog]
@catalog int,
@kid int
AS
BEGIN
	SELECT  a.ID,Caption,Code,[Catalog],kid from kmp..T_Dictionary  a left join  (select *  from T_DictionarySetting where kid=@kid)b on a.id=b.dic_id  where a.[catalog]=@catalog 
END

GO

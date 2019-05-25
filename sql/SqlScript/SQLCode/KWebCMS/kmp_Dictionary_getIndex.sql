USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Dictionary_getIndex]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- alter date: <alter Date,,>
-- Description:	<Description,,>
--[kmp_Dictionary_getIndex] 33,10341
-- =============================================
CREATE PROCEDURE [dbo].[kmp_Dictionary_getIndex]
@catalog int,
@kid int
AS
BEGIN

if(exists(select 1 from theme_kids where kid=@kid))
begin
	SET @kid=12511
end

	SELECT  a.gid,a.gname,'','',@kid from BasicData..grade  a inner join 
 (select *  from T_DictionarySetting where kid=@kid)b on a.gid=b.dic_id  
 order by a.[order]
END


GO

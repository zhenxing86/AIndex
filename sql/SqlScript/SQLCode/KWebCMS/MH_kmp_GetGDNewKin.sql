USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_GetGDNewKin]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-01
-- Description:	GetGDNewKin
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_GetGDNewKin]
AS
BEGIN	
	select top 10 id as kin_id, name as kin_name,city as kin_city,url as kin_url, actiondate as kin_createdate 
	From kmp..v_NewKinList where privince=245 order by id desc
END




GO

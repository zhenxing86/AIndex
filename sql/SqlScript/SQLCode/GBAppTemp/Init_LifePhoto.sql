USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[Init_LifePhoto]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[Init_LifePhoto] 
@gbid int
 AS
	update lifephoto set m_photo='null|null|null|null|null|null|null|null|null|null|null|null'
,photo_desc='|||||||||||'
where gbid=@gbid


GO

USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_homebook_weekByhomebookid]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[rep_homebook_weekByhomebookid]
@homebookid int,
@id_index int
AS

--exec reportapp..[init_homebook_ByhomebookidV2] @homebookid
insert into reportapp..homebook_log(hbid)values(@homebookid)

GO

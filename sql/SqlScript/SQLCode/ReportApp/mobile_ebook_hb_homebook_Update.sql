USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[mobile_ebook_hb_homebook_Update]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[mobile_ebook_hb_homebook_Update]
@gbid int,
@uid int,
@parent_point varchar(500),
@parent_word varchar(max)
as

update GBApp..celllist set parent_point=@parent_point,parent_word=@parent_word
where gbid=@gbid and userid=@uid 



GO

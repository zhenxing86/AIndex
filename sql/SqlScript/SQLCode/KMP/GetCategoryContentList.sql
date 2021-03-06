USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetCategoryContentList]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   PROCEDURE [dbo].[GetCategoryContentList]
@categoryTreeID int
AS

select 'ContentDocShow.aspx?contentID='+ cast(contentID as varchar) ContentID, subject , categorytreeid from categorycontent where categorytreeid = @categoryTreeID and RecordID is not null
union
select 'ContentShow.aspx?contentID='+ cast(contentID as varchar) ContentID, subject , categorytreeid from categorycontent where categorytreeid = @categoryTreeID and RecordID is null
union
select 'ContentAttachsShow.aspx?AttachID=' + cast(attachID as varchar) ContentID, descript, categorytreeid from categoryattachs where categorytreeid = @categoryTreeID

GO

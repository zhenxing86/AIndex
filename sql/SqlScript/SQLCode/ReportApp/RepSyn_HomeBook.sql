USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[RepSyn_HomeBook]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








--select * From reportapp..rep_homebook
-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2011-08-19>
-- Description:	
--exec [RepSyn_HomeBook]  '2011-08-14','2011-08-07'
-- =============================================
create PROCEDURE [dbo].[RepSyn_HomeBook]  
@splitdate_t datetime,
@splitdate_l datetime
AS
BEGIN
	declare @classid int
	declare @thisweeknum int
	declare @lastweeknum int
	declare @tnbid int

			declare hbookrs insensitive cursor for 
			select cid From basicdata..class where deletetag=1 and iscurrent=1
			open hbookrs
			fetch next from hbookrs into @classid
			while @@fetch_status=0
			begin
				select @thisweeknum=0
				select @lastweeknum=0
				insert into ReportApp..rep_homebook(classid,thisweeknum,lastweeknum,bookid)values(@classid,@thisweeknum,@lastweeknum,0)

				fetch next from hbookrs into @classid
			end
			close hbookrs
			deallocate hbookrs
END







GO

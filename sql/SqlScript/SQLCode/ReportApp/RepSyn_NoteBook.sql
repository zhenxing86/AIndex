USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[RepSyn_NoteBook]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * From ebook..tnb_teachingnotebook
--select * from rep_notebook where thisweeknum>1 or lastweeknum>1
-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	
--exec [RepSyn_NoteBook]  '2011-08-14','2011-08-07'
-- =============================================
CREATE PROCEDURE [dbo].[RepSyn_NoteBook]    
@splitdate_t datetime,  
@splitdate_l datetime  
AS  
BEGIN  
 declare @userid int  
 declare @thisweeknum int  
 declare @lastweeknum int  
 declare @tnbid int  
  
   declare nbookrs insensitive cursor for   
   select userid,teachingnotebookid From ebook..tnb_teachingnotebook  
   open nbookrs  
   fetch next from nbookrs into @userid,@tnbid  
   while @@fetch_status=0  
   begin  
    select @thisweeknum=count(chapterid) from ebook..TNB_Chapter where teachingnotebookid=@tnbid and createdate>=@splitdate_t and deletetag = 1
    select @lastweeknum=count(chapterid) from ebook..TNB_Chapter where teachingnotebookid=@tnbid and createdate between @splitdate_l and @splitdate_t and deletetag = 1
    insert into ReportApp..rep_notebook(userid,thisweeknum,lastweeknum,bookid)values(@userid,@thisweeknum,@lastweeknum,0)  
  
    fetch next from nbookrs into @userid,@tnbid  
   end  
   close nbookrs  
   deallocate nbookrs  
END  

GO

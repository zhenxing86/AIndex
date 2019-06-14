USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_read_Article_Add]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rep_read_Article_Add]
  @userid int,
  @articleid int
AS
BEGIN

insert into  dbo.rep_read_article(userid,articleid)
select @userid,@articleid   
		where not exists
		(
			select 1 from rep_read_article 
				where userid=@userid 
					and articleid=@articleid
		)

END


GO

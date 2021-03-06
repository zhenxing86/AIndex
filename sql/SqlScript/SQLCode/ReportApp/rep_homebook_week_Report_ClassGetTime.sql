USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_homebook_week_Report_ClassGetTime]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rep_homebook_week_Report_ClassGetTime]
@term varchar(20),
@kid int
AS
--declare @cid varchar(30)
--select @cid=cid from BasicData..class where kid=@kid and deletetag=1 and grade<>38

select distinct title,id_index from rep_homebook_week r 
inner join BasicData..class c on r.classid=c.cid
where c.kid=@kid and deletetag=1 and grade<>38
and term=@term order by id_index

GO

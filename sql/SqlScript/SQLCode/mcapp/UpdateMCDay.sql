USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[UpdateMCDay]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateMCDay]
@stuid int,
@tw varchar(50),
@zz varchar(50),
@cdate varchar(50)
as

	update stu_mc_day
		set tw=@tw,zz=@zz,cdate=@cdate,adate=getdate()
			where stuid=@stuid
		

GO

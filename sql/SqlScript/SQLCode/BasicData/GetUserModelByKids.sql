USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetUserModelByKids]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserModelByKids]
@kid int
AS
BEGIN
  select userid,account,[password],usertype,kid from [user]
	 where kid=@kid and usertype in(97,98) order by usertype desc
END

GO

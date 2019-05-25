USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[Teacher_Update]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		liaoxin
-- Create date: 2011-7-22
-- Description:	修改老师基本资料
-- =============================================
CREATE PROCEDURE [dbo].[Teacher_Update]
@userid int,
@gw varchar(50),
@post varchar(50),
@education varchar(50),
@employmentinfo varchar(50),
@politicalface varchar(50),
@kinschooltag int
AS
BEGIN
   
  update teacher  set title=@gw,post=@post,education=@education,employmentform=@employmentinfo,
  politicalface=@politicalface,kinschooltag=@kinschooltag where userid=@userid
  
	--if(@gw='园长')
	--begin
	--	update [user] set usertype=97 where userid=@userid
	--end
	--else if(@gw='管理员')
	--begin
	--	update [user] set usertype=98 where userid=@userid
	--end

  IF(@@ERROR<>0)
  BEGIN
  RETURN -1
  END
  ELSE
  BEGIN
  RETURN 1
  END
	
END







GO

USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_TemUserClass_Add]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		lx
-- Create date: 2011-5-28
-- Description:	加入班级
-- =============================================
CREATE PROCEDURE [dbo].[BasicData_TemUserClass_Add]
@cid int,
@userid int,
@reason varchar(200)
AS
BEGIN
     DECLARE @returnvalue int
     
     --没有加入
     IF NOT EXISTS(SELECT * FROM tem_user_class  WHERE userid=@userid)
       BEGIN
       INSERT INTO tem_user_class(cid,userid,reason)  VALUES(@cid,@userid,@reason) 
       SET @returnvalue=@userid
       END
     --不允许重复加入   
     ELSE
       BEGIN
       SET @returnvalue=-1
     END
       
     
     IF @@ERROR<>0
      BEGIN
        SET    @returnvalue=-2
       RETURN  @returnvalue
      END
     ELSE
      BEGIN
       RETURN  @returnvalue
      END  
END





GO

USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_UserClass_Add]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[BasicData_UserClass_Add]
@cid int,
@userid int
AS
BEGIN
     DECLARE @returnvalue int,@did int,@kid int 
     
     --没有加入
     IF NOT EXISTS(SELECT * FROM tem_user_class WHERE userid=@userid)
       BEGIN
       INSERT INTO user_class(cid,userid)  VALUES(@cid,@userid) 
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

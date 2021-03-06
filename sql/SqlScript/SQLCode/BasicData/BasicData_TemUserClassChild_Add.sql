USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_TemUserClassChild_Add]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create  PROCEDURE  [dbo].[BasicData_TemUserClassChild_Add]
@cid int,
@userid int,
@reason varchar(200),
@kid int
AS
BEGIN
     DECLARE @returnvalue int
     
     --没有加入
     IF NOT EXISTS(SELECT * FROM tem_user_class  WHERE userid=@userid)
       BEGIN
       INSERT INTO tem_user_kindergarten(userid,kid) VALUES(@userid,@kid)
       
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

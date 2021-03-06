USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_kindergarten_Add]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	lx
-- Create date:2011-5-26
-- Description:老师创建并且加入幼儿园
-- EXEC 
-- =============================================
CREATE PROCEDURE [dbo].[BasicData_kindergarten_Add]
@userid int,
@kname nvarchar(50),
@provice int,
@city int,
@area int,
@telephone nvarchar(50),
@qq varchar(50)
AS
BEGIN
    DECLARE @CurrentKid int,@did int,@did2 int
      INSERT INTO kindergarten(kname,privince,city,area,actiondate,telephone,qq) VALUES (@kname,@provice,@city,@area,GETDATE(),@telephone,@qq)
      SET @CurrentKid=ident_current('kindergarten') 
      
      update [user] set kid = @CurrentKid where userid = @userid
    
       INSERT INTO department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES(@kname,0,1,1,@CurrentKid,GETDATE())
       
       SET @did=ident_current('department') 
      
       INSERT INTO department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES('行政部',@did,1,1,@CurrentKid,GETDATE())
       
       SET @did2=ident_current('department') 
       
       INSERT INTO department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES('保育组',@did2,1,1,@CurrentKid,GETDATE())
        INSERT INTO department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES('财务组',@did2,1,1,@CurrentKid,GETDATE())
        INSERT INTO department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES('教学组',@did2,1,1,@CurrentKid,GETDATE())
       
         INSERT INTO department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES('小班部',@did,1,1,@CurrentKid,GETDATE())
       
       INSERT INTO department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES('中班部',@did,1,1,@CurrentKid,GETDATE())
       
       INSERT INTO department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES('大班部',@did,1,1,@CurrentKid,GETDATE())
       
      update teacher set did=@did where userid=@userid
      
      INSERT INTO KWebCMS..site_config(siteid,shortname,guestopen) values (@CurrentKid,@kname,0)
    
   
    
    IF @@ERROR<>0
    BEGIN
      RETURN (0)
    END    
    ELSE
    BEGIN
      RETURN  @CurrentKid
    END
    
END

GO

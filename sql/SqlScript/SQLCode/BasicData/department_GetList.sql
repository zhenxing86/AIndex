USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[department_GetList]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询部门记录信息 
--项目名称：OpenApp
--说明：
--时间：2011-5-19 9:28:39
------------------------------------
CREATE PROCEDURE [dbo].[department_GetList] 
@kid int
 AS 

--if(not exists(select 1 from department where kid=@kid))
--begin
--	declare @name nvarchar(50)
--	declare @did int
--	declare @did2 int
--	select @name=kname from kindergarten where kid=@kid
--		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
--       VALUES(@name,0,1,1,@kid,GETDATE())
       
--       SET @did=@@IDENTITY
      
--       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
--       VALUES('行政部',@did,1,1,@kid,GETDATE())
       
--       SET @did2=@@IDENTITY
       
--       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('保育组',@did2,1,1,@kid,GETDATE())
--       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('财务组',@did2,2,1,@kid,GETDATE())
--       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('教学组',@did2,3,1,@kid,GETDATE())       
--       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('小班部',@did,4,1,@kid,GETDATE())       
--       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('中班部',@did,5,1,@kid,GETDATE())       
--       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('大班部',@did,6,1,@kid,GETDATE())

--end

	SELECT 
	did,dname,superior
	 FROM [department]
	 WHERE kid=@kid and deletetag=1 
	 ORDER BY [order] asc, did asc, superior ASC

GO

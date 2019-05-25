USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------

------------------------------------
create PROCEDURE [dbo].[basicdata_user_GetModel]
@userid int
 AS 

begin

SELECT 1, [userid],[username],[kid],[account],[pwd]
  FROM [basicdata_user] u
  WHERE u.userid=@userid 
  
end

GO

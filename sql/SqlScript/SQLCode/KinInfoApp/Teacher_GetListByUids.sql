USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[Teacher_GetListByUids]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- [Teacher_GetListByUids] 12511,0
CREATE PROCEDURE [dbo].[Teacher_GetListByUids]
@kid int,
@uids varchar(100)
as 


exec('select userid,name 
from  BasicData..[user] 
where kid='+@kid+' and userid in ('+@uids+')')

GO

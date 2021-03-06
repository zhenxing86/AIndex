USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetMoreKinList]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,更多幼儿园访问报表2>
-- =============================================
CREATE PROCEDURE [dbo].[GetMoreKinList] 
AS
BEGIN
	SET NOCOUNT ON;
select t2.id, t2.url, t2.name, t2.kindesc, t2.theme, t2.ispublish,
(select counts from siteaccesscount where kid = t2.id) as accesscount
from t_kindergarten t2  where t2.status = 1 and t2.ispublish = 1
 order by accesscount desc
END




GO

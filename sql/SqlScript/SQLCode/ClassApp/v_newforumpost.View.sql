USE [ClassApp]
GO
/****** Object:  View [dbo].[v_newforumpost]    Script Date: 05/14/2013 14:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_newforumpost]
AS
SELECT     title, author, classid, createdatetime, 0 AS isblogpost, parentid, kid,
                          (SELECT     title
                            FROM          dbo.class_forum
                            WHERE      (classforumid = t1.parentid)) AS parentTitle
FROM         dbo.class_forum AS t1
WHERE     (status = 1) AND (parentid <> 0)
GO

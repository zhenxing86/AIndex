USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_typeSingle]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[faq_typeSingle]
        (
        @typeID int
 )
AS
SELECT 
   typeID,typeName,fatherID
FROM 
   faq_type
WHERE
   typeID=@typeID AND status=1


GO

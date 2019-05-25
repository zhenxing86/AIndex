USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[options_GetListByQuestionId]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
-- =============================================      
 
/*      
memo: exec options_GetListByQuestionId 1
*/      
-- =============================================      
create PROCEDURE [dbo].[options_GetListByQuestionId]
@questionid int
AS            
BEGIN     
select id,content,score from options where questionid=@questionid

END 

GO

USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_class_forum_GetListBypage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--最新班级论坛回复的主题
--liaoxin
--2011-1-10
CREATE PROCEDURE [dbo].[blog_class_forum_GetListBypage]
@kid int,@page int,@size int,@parentid int 

AS
BEGIN
     DECLARE @prep int,@ignore int
		SET @prep = (@page-1) * @size+1
		SET @ignore=@page*@size
     
      select title,author,classid,isblogpost,parentid,parentTitle,createdatetime from (select title,author,classid,isblogpost,parentid,parentTitle,createdatetime,row_number() over(order by createdatetime desc) as num from  classapp.dbo.v_newforumpost where kid=@kid) a
      where num between @prep and  @ignore
      order by createdatetime desc
   
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_class_forum_GetListBypage', @level2type=N'PARAMETER',@level2name=N'@page'
GO

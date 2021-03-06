USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_content_GetListByGrade]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-04-20
-- Description:	GetListByGrade
-- =============================================
create PROCEDURE [dbo].[Blog_course_content_GetListByGrade]
@gradeid int,
@page int,
@size int
AS
BEGIN	
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT id FROM resourceapp..course_content
		WHERE gradeid=@gradeid
		ORDER BY orderno DESC,id DESC

		SET ROWCOUNT @size
		SELECT c.id,coursetypeid,subtypeno,'subtitle'=st.title,'coursetitle'=c.title,gradeid,'gradetitle'=g.title,'typetitle'=t.title,filepath,filename,thumbpath,thumbfilename,orderno,viewcount,createdatetime,level,status
		FROM resourceapp..course_content c,resourceapp..course_grade g,resourceapp..course_type t,@tmptable,resourceapp..course_subtype st
		WHERE row > @ignore AND c.[id]=tmptableid AND c.coursetypeid=t.id AND c.gradeid=g.id AND subtypeno=subtypeid AND gradeid=@gradeid
		ORDER BY row ASC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT c.id,coursetypeid,subtypeno,'subtitle'=st.title,'coursetitle'=c.title,gradeid,'gradetitle'=g.title,'typetitle'=t.title,filepath,filename,thumbpath,thumbfilename,orderno,viewcount,createdatetime,level,status
		FROM resourceapp..course_content c,resourceapp..course_grade g,resourceapp..course_type t,resourceapp..course_subtype st
		WHERE c.coursetypeid=t.id AND c.gradeid=g.id AND subtypeno=subtypeid AND gradeid=@gradeid
		ORDER BY orderno DESC,id DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT c.id,coursetypeid,subtypeno,'subtitle'=st.title,'coursetitle'=c.title,gradeid,'gradetitle'=g.title,'typetitle'=t.title,filepath,filename,thumbpath,thumbfilename,orderno,viewcount,createdatetime,level,status
		FROM resourceapp..course_content c,resourceapp..course_grade g,resourceapp..course_type t,resourceapp..course_subtype st
		WHERE c.coursetypeid=t.id AND c.gradeid=g.id AND subtypeno=subtypeid AND gradeid=@gradeid
		ORDER BY orderno DESC,id DESC	
	END	
END












GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Blog_course_content_GetListByGrade', @level2type=N'PARAMETER',@level2name=N'@page'
GO

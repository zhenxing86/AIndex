USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vipsetlog_GetListByName]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[vipsetlog_GetListByName]
@name nvarchar(20),
@page int,
@size int
AS
BEGIN
    IF(@page>1)
    BEGIN
        DECLARE @count int
        DECLARE @ignore int
        
        SET @count=@page*@size
        SET @ignore=@count-@size
        
        DECLARE @temptable TABLE
        (
            row int identity(1,1) primary key,
            temp_id int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT v.id FROM vipsetlog v
		LEFT JOIN kmp..T_Child c ON v.userid=c.userid 
		LEFT JOIN site s ON c.KindergartenID=s.siteid 
		LEFT JOIN kmp..T_Class a ON c.ClassID=a.ID
		WHERE c.name LIKE '%'+@name+'%'
		ORDER BY actiondatetime DESC
        
        SET ROWCOUNT @size
        SELECT v.[id],v.[userid],[startdate],[enddate],[actiondatetime],[dredgestatus],
		c.Mobile,c.name as username,s.name as sitename,a.name as classname,u.username
        FROM @temptable 
		LEFT JOIN vipsetlog v ON v.id=temp_id
		LEFT JOIN kmp..T_Child c ON v.userid=c.userid 
		LEFT JOIN site s ON c.KindergartenID=s.siteid 
		LEFT JOIN kmp..T_Class a ON c.ClassID=a.ID
        LEFT JOIN ZGYEYCMS_Right..sac_user u ON v.operator=u.[user_id]
        WHERE row>@ignore
		ORDER BY actiondatetime DESC
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT v.[id],v.[userid],[startdate],[enddate],[actiondatetime],[dredgestatus],
		c.Mobile,c.name as username,s.name as sitename,a.name as classname,u.username
        FROM vipsetlog v 
		LEFT JOIN kmp..T_Child c ON v.userid=c.userid 
		LEFT JOIN site s ON c.KindergartenID=s.siteid 
		LEFT JOIN kmp..T_Class a ON c.ClassID=a.ID
        LEFT JOIN ZGYEYCMS_Right..sac_user u ON v.operator=u.[user_id]
		WHERE c.name LIKE '%'+@name+'%'
		ORDER BY actiondatetime DESC
    END
    ELSE
    BEGIN
        SELECT v.[id],v.[userid],[startdate],[enddate],[actiondatetime],[dredgestatus],
		c.Mobile,c.name as username,s.name as sitename,a.name as classname,u.username
        FROM vipsetlog v 
		LEFT JOIN kmp..T_Child c ON v.userid=c.userid 
		LEFT JOIN site s ON c.KindergartenID=s.siteid 
		LEFT JOIN kmp..T_Class a ON c.ClassID=a.ID
        LEFT JOIN ZGYEYCMS_Right..sac_user u ON v.operator=u.[user_id]
		WHERE c.name LIKE '%'+@name+'%'
		ORDER BY actiondatetime DESC
    END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'vipsetlog_GetListByName', @level2type=N'PARAMETER',@level2name=N'@page'
GO

USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[zxbm_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[zxbm_GetList]
@siteid int,
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
        SELECT bmid FROM zxbm
		WHERE siteid=@siteid  order by createdatetime desc
        
        SET ROWCOUNT @size
        SELECT [bmid],[siteid]
      ,[name]
      ,[sex]
      ,[birthday]
      ,[fname]
      ,[fjob]
      ,[fphone]
      ,[mname]
      ,[mjob]
      ,[mphone]
      ,[address]
      ,[oldkin]
      ,[joinclass]
      ,[memo]
      
      ,[createdatetime]
,[homephone],[fzw],[mzw]
  FROM [KWebCMS].[dbo].[zxbm],@temptable
        WHERE bmid=temp_id AND row>@ignore  order by createdatetime desc
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT [bmid],[siteid]
      ,[name]
      ,[sex]
      ,[birthday]
      ,[fname]
      ,[fjob]
      ,[fphone]
      ,[mname]
      ,[mjob]
      ,[mphone]
      ,[address]
      ,[oldkin]
      ,[joinclass]
      ,[memo]
      
      ,[createdatetime],[homephone],[fzw],[mzw]
  FROM [KWebCMS].[dbo].[zxbm]
		WHERE siteid=@siteid order by createdatetime desc
    END
    ELSE
    BEGIN
        SELECT [bmid],[siteid]
      ,[name]
      ,[sex]
      ,[birthday]
      ,[fname]
      ,[fjob]
      ,[fphone]
      ,[mname]
      ,[mjob]
      ,[mphone]
      ,[address]
      ,[oldkin]
      ,[joinclass]
      ,[memo]
      
      ,[createdatetime],[homephone],[fzw],[mzw]
  FROM [KWebCMS].[dbo].[zxbm]
		WHERE siteid=@siteid
    END
  
END







GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'zxbm_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'zxbm_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO

USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_enlistonline_getNameListByKid]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[cms_enlistonline_getNameListByKid]  
 @kid int  
AS  
BEGIN  
 select name from syscolumns where  id=object_id('enlistonline') and name not in (select prams from enlistonline_templet where siteid=@kid and deletetag=1)  
END  
GO

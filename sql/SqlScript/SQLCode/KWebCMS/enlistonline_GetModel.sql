USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonline_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[enlistonline_GetModel]  
@id int  
AS  
BEGIN  
    SELECT [id],[siteid],[name],[sex],[birthday],[contactphone],[contactaddress],[memo],[createdatetime],classname,nativeplace,nation,ffamily,fname,funit,fphone,sfamily,sname,sunit,sphone,tfamily,tname,tunit,tphone,  
 fofamily,foname,founit,fophone,credentials,allergy,enlistdatetime,physicalexamination,medicalhistory,operator,autograph ,kname 
    FROM enlistonline  
    WHERE id=@id  
END  
GO

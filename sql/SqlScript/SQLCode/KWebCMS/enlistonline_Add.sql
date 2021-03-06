USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonline_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE PROCEDURE [dbo].[enlistonline_Add]  
@siteid int,  
@name nvarchar(50)='',  
@sex bit,  
@birthday datetime,  
@contactphone nvarchar(50)='',  
@contactaddress nvarchar(200)='',  
@memo nvarchar(500)='',  
@classname nvarchar(50)='',  
@nativeplace nvarchar(50)='',  
@nation nvarchar(50)='',  
@ffamily nvarchar(50)='',  
@fname nvarchar(50)='',  
@funit nvarchar(200)='',  
@fphone nvarchar(50)='',  
@sfamily nvarchar(50)='',  
@sname nvarchar(50)='',  
@sunit nvarchar(200)='',  
@sphone nvarchar(50)='',  
@tfamily nvarchar(50)='',  
@tname nvarchar(50)='',  
@tunit nvarchar(200)='',  
@tphone nvarchar(50)='',  
@fofamily nvarchar(50)='',  
@foname nvarchar(50)='',  
@founit nvarchar(200)='',  
@fophone nvarchar(50)='',  
@credentials nvarchar(50)='',  
@allergy nvarchar(50)='',  
@enlistdatetime nvarchar(50)='',  
@physicalexamination nvarchar(50)='',  
@medicalhistory nvarchar(100)='',  
@operator nvarchar(50)='',  
@autograph nvarchar(50)=''  
AS  
BEGIN  

    INSERT INTO enlistonline([siteid],[name],[sex],[birthday],[contactphone],[contactaddress],[memo],[createdatetime],  
 classname,nativeplace,nation,ffamily,fname,funit,fphone,sfamily,sname,sunit,sphone,tfamily,tname,tunit,tphone,  
 fofamily,foname,founit,fophone,credentials,allergy,enlistdatetime,physicalexamination,medicalhistory,operator,autograph)  
    VALUES(@siteid,@name,@sex,@birthday,@contactphone,@contactaddress,@memo,GETDATE(),  
 @classname,@nativeplace,@nation,@ffamily,@fname,@funit,@fphone,@sfamily,@sname,@sunit,@sphone,@tfamily,@tname,@tunit,@tphone,  
 @fofamily,@foname,@founit,@fophone,@credentials,@allergy,@enlistdatetime,@physicalexamination,@medicalhistory,@operator,@autograph)   
  
    IF @@ERROR <> 0  
    BEGIN  
        RETURN 0  
    END  
    ELSE  
    BEGIN  
        RETURN @@IDENTITY  
    END  
END  
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'enlistonline_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生日' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'enlistonline_Add', @level2type=N'PARAMETER',@level2name=N'@birthday'
GO

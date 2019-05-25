USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[getEquipmentInfolist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getEquipmentInfolist]  
@kid int  
as  
  
 SELECT [devid]  
      ,[kid]  
      ,[sno]  
      ,[scode]  
      ,[maddr]  
      ,[saddr]  
      ,[adupt]  
      ,[msms]  
      ,[tsms]  
      ,[psms]  
      ,[interval]  
      ,[wifi]  
      ,[photo]  
      ,[firmw]  
      ,[daddr]  
      ,[pcfirmw]  
      ,[pcdaddr],[showphoto],cardone,playcname 
  FROM [mcapp].[dbo].[driveinfo]  
GO

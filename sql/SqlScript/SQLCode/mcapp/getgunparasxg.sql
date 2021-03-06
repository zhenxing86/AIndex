USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[getgunparasxg]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
    
    
    
CREATE PROCEDURE [dbo].[getgunparasxg]    
@kid int    
,@devid nvarchar(50)    
 AS     
     
 SELECT [id]    
      ,[kid]    
      ,[serial_no]    
      ,[devid]    
      ,[paras]    
      ,[paras_values]    
      ,[adate]    
      ,[status]    
  FROM [mcapp].[dbo].[gun_para_xg]    
  WHERE kid=@kid and devid=@devid and ([status]=0  or [status]=1 ) and adate>=DATEADD(day,-7,GETDATE())
  
  update [mcapp].[dbo].[gun_para_xg] set status=-1 where kid=@kid and adate<DATEADD(day,-7,GETDATE()) and ([status]=0  or [status]=1 ) 
GO

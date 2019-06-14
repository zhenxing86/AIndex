USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[getgunparascx]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
CREATE PROCEDURE [dbo].[getgunparascx]  
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
  FROM [mcapp].[dbo].[gun_para_cx]  
  WHERE kid=@kid and devid=@devid and ([status]=0  or [status]=1 )  
GO

USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Fee_Type_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter PROCEDURE [dbo].[kmp_Fee_Type_GetList]  
@kid int  
AS  
  
BEGIN  

Declare @microweb bit
if Exists (Select * From blogapp..permissionsetting Where kid = @kid and ptype = 62)
  Select @microweb = 1
else 
  Select @microweb = 0

 SELECT   
 f.fee_type_id,f.fee_type_name,f.default_price,f.free_month,  
 'kid'=@kid,  
 'price'='',  
 'end_date'=Case When @microweb = 1 Then dateadd(mm, 1, getdate()) Else k.expiretime End,  
 'actiondate'=k.ontime,  
 'comments'=''  
 FROM zgyey_om..Fee_Type f,ossapp..kinbaseinfo k  
 where k.kid=@kid  
   
END  
GO

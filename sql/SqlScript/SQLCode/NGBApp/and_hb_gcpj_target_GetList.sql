USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_gcpj_target_GetList]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      xie
-- Create date: 2014-10-24  
-- Description: 手机客户端获取某个月的观察与评价的目录内容(Web) 
-- Memo:   BasicData.dbo.class where kid=12511
and_hb_gcpj_target_GetList 55906,'2014-0',0  

*/     
CREATE Procedure [dbo].[and_hb_gcpj_target_GetList]
@cid Int,  
@term Varchar(50),   
@pos Int  
as  
Declare @kid Int  
Select @kid = kid From BasicData.dbo.class Where cid = @cid  

Select target From NGBApp.dbo.monthtarget   
  Where grade In (Select b.gtype From BasicData.dbo.class a, BasicData.dbo.grade b   
                    Where a.grade = b.gid and a.cid = @cid)   
    and months In (Select Months From NGBApp.dbo.fn_GetMonAdvList(@term, @kid) Where pos = @pos)  
  Order by orderno

GO

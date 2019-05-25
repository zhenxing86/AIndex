USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[Get_ParentPay]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie      
-- Create date: 2014-07-09      
-- Description: 根据kid获取ngbapp..homebook所有的家园联系册      
-- Memo:      
Get_ParentPay 11061    
*/   
CREATE proc [dbo].[Get_ParentPay]
@kid int 
as
begin
	select parentpay 
	 from ossapp..kinbaseinfo 
	  where kid=@kid and parentpay !='无定版本' and parentpay is not null
	
end
GO

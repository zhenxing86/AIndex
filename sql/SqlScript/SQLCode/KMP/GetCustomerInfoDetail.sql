USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerInfoDetail]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,客户情况明细>
-- =============================================
create PROCEDURE [dbo].[GetCustomerInfoDetail] 
	@where varchar(200)
AS
BEGIN
	SET NOCOUNT ON;

select 
t.id, t.name as 幼儿园名, mt.market as 市场跟踪,
dbo.DictionaryCaptionFromID(kai.Contractstatus) as 当前联系状态,
dbo.DictionaryCaptionFromID(kai.Customer_Desc) as 客户情况,
dbo.DictionaryCaptionFromID(kai.Register_Source) as 注册来源,
dbo.DictionaryCaptionFromID(kai.Real_Source) as 真实注册来源,
dbo.DictionaryCaptionFromID(kai.Agent_Desc) as 代理商情况,
kai.Reg_Domain_DateTime as 注册域名时间,
kai.Domain_Price 域名价格,
mt.contentmemo as 内容跟踪, mt.updatetime as 更新时间

from t_kindergarten t 
left join markettrace mt on t.id = mt.kid
left join kindergarten_attach_info kai on t.id = kai.kid

where t.status = 1 and kai.contractstatus= 100
order by mt.updatetime desc

END


GO

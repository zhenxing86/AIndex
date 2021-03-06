USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerInfo]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,客户情况>
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomerInfo] 

AS
BEGIN
	SET NOCOUNT ON;

select 
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.contractstatus= 100) as 未联系#当前联系状态#未联系,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.contractstatus= 101) as 已联系未回复#当前联系状态#已联系未回复,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.contractstatus= 102) as 联系上未直接沟通#当前联系状态#联系上未直接沟通,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.contractstatus= 103) as 已取得联系#当前联系状态#已取得联系,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Customer_Desc= 104) as 测试假客户#客户情况#测试假客户,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Customer_Desc= 105) as 不积极#客户情况#不积极,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Customer_Desc= 107) as 非常积极#客户情况#非常积极,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Customer_Desc= 106) as 正常#客户情况#正常,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Content_Desc= 126) as 资料没上传#资料上传情况#资料没上传,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Content_Desc= 127) as 资料基本完成#资料上传情况#资料基本完成,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Content_Desc= 128) as 更新过资料#资料上传情况#更新过资料,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Agent_Desc= 124) as 无代理商#代理商情况#无,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Agent_Desc= 111) as 临沂#代理商情况#临沂,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Agent_Desc= 112) as 成都#代理商情况#成都,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Agent_Desc= 113) as 长沙#代理商情况#长沙,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Agent_Desc= 114) as 齐齐哈尔#代理商情况#齐齐哈尔,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Agent_Desc= 115) as 福州#代理商情况#福州,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Agent_Desc= 116) as 其它#代理商情况#其它,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Real_source= 117) as 无参与调查#真实注册来源#无参与调查,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Real_source= 118) as 通过QQ群#真实注册来源#通过QQQQ群,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Real_source= 119) as 通过电子邮件#真实注册来源#通过电子邮件,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Real_source= 120) as 通过朋友介绍#真实注册来源#通过朋友介绍,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Real_source= 121) as 通过论坛#真实注册来源#通过论坛,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Real_source= 122) as 通过网络搜索#真实注册来源#通过网络搜索,
(select count(t1.kid) from kindergarten_attach_info t1 left join t_kindergarten t2 on t1.kid = t2.id where t2.status = 1 and t1.Real_source= 123) as 其它途径#真实注册来源#其它途径

END

GO

USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_MarketTrace_GetListByType]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-08-11
-- Description:	客户情况搜索 
-- =============================================
CREATE PROCEDURE [dbo].[kmp_MarketTrace_GetListByType] --111,1,10
@searchtype int,
@page int,
@size int
AS
BEGIN
	IF @page>1
	BEGIN
		DECLARE @count int
		DECLARE @ignore int
		SET @count=@page*@size
		SET @ignore=@count-@size

		DECLARE @tempTable TABLE
		(
			row int primary key identity(1,1),
			tempid int
		)
		
		SET ROWCOUNT @count
		INSERT INTO @tempTable SELECT m.kid FROM zgyey_om..MarketTrace m,zgyey_om..kindergarten_attach_info k,site s
		WHERE m.Kid=k.KID AND m.Kid=s.siteid 
		AND (ContractStatus=@searchtype OR Customer_Desc=@searchtype OR Content_Desc=@searchtype 
		OR Register_Source=@searchtype OR Real_Source=@searchtype OR Agent_Desc=@searchtype OR KinStatus=@searchtype
		--OR [name] LIKE '%'+@sitename+'%'
		--OR k.UpdateTime BETWEEN @regstartdatetime AND @regenddatetime
		)
		ORDER BY m.Kid DESC

		SET ROWCOUNT @size
		SELECT m.Kid,[name],Market,ContentMemo,
		'MarketDateTime'=m.UpdateTime,
		'ContractStatus'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.ContractStatus),
		'CustomerDesc'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Customer_Desc),
		'ContentDesc'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Content_Desc),
		'RegisterSource'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Register_Source),
		'RealSource'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Real_Source),
		'AgentDesc'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Agent_Desc),
		'RegDomainDateTime'=s.regdatetime,
		'DomainPrice'=m.actionuser,
		'AttachDateTime'=k.UpdateTime,
		KinStatus,s.sitedns
		FROM zgyey_om..MarketTrace m,zgyey_om..kindergarten_attach_info k,site s,@tempTable
		WHERE m.Kid=k.KID AND m.Kid=s.siteid AND m.Kid=tempid AND row>@ignore
		ORDER BY m.Kid DESC
	END
	ELSE IF @page=1
	BEGIN
		SET ROWCOUNT @size
		SELECT m.Kid,[name],Market,ContentMemo,
		'MarketDateTime'=m.UpdateTime,
		'ContractStatus'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.ContractStatus),
		'CustomerDesc'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Customer_Desc),
		'ContentDesc'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Content_Desc),
		'RegisterSource'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Register_Source),
		'RealSource'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Real_Source),
		'AgentDesc'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Agent_Desc),
		'RegDomainDateTime'=s.regdatetime,
		'DomainPrice'=m.actionuser,
		'AttachDateTime'=k.UpdateTime,
		KinStatus,s.sitedns
		FROM zgyey_om..MarketTrace m,zgyey_om..kindergarten_attach_info k,site s
		WHERE m.Kid=k.KID AND m.Kid=s.siteid 
		AND (ContractStatus=@searchtype OR Customer_Desc=@searchtype OR Content_Desc=@searchtype 
		OR Register_Source=@searchtype OR Real_Source=@searchtype OR Agent_Desc=@searchtype OR KinStatus=@searchtype
		--OR [name] LIKE '%'+@sitename+'%'
		--OR k.UpdateTime BETWEEN @regstartdatetime AND @regenddatetime
		)
		ORDER BY m.Kid DESC
	END
	ELSE
	BEGIN
		SELECT m.Kid,[name],Market,ContentMemo,
		'MarketDateTime'=m.UpdateTime,
		'ContractStatus'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.ContractStatus),
		'CustomerDesc'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Customer_Desc),
		'ContentDesc'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Content_Desc),
		'RegisterSource'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Register_Source),
		'RealSource'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Real_Source),
		'AgentDesc'=(SELECT Caption FROM zgyey_om..T_Dictionary WHERE ID=k.Agent_Desc),
		'RegDomainDateTime'=s.regdatetime,
		'DomainPrice'=m.actionuser,
		'AttachDateTime'=k.UpdateTime,
		KinStatus,s.sitedns
		FROM zgyey_om..MarketTrace m,zgyey_om..kindergarten_attach_info k,site s
		WHERE m.Kid=k.KID AND m.Kid=s.siteid 
		AND ( ContractStatus=@searchtype OR Customer_Desc=@searchtype OR Content_Desc=@searchtype 
		OR Register_Source=@searchtype OR Real_Source=@searchtype OR Agent_Desc=@searchtype OR KinStatus=@searchtype
		--OR [name] LIKE '%'+@sitename+'%'
		--OR k.UpdateTime BETWEEN @regstartdatetime AND @regenddatetime
	    )
		ORDER BY m.Kid DESC
	END
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_MarketTrace_GetListByType', @level2type=N'PARAMETER',@level2name=N'@page'
GO

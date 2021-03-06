USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_MarketTrace_GetListBySearch]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-08-11
-- Description:	客户情况搜索 
-- =============================================
CREATE PROCEDURE [dbo].[kmp_MarketTrace_GetListBySearch]
@searchtype int,
@siteid int,
@searchkey int,
@sitename nvarchar(50),
@regstartdatetime datetime,
@regenddatetime datetime,
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
		INSERT INTO @tempTable SELECT s.siteid FROM site s 
			--left join zgyey_om..MarketTrace m on s.siteid=m.kid
			-- left join zgyey_om..kindergarten_attach_info k on m.kid=k.kid
		WHERE --m.Kid=k.KID AND m.Kid=s.siteid 
		--AND (m.Kid=@siteid OR ContractStatus=@searchkey OR Customer_Desc=@searchkey OR Content_Desc=@searchkey 
		--OR Register_Source=@searchkey OR Real_Source=@searchkey OR Agent_Desc=@searchkey OR KinStatus=@searchkey
		--OR [name] LIKE '%'+@sitename+'%'
		--OR s.regdatetime BETWEEN @regstartdatetime AND @regenddatetime
		--) 

		s.regdatetime BETWEEN @regstartdatetime AND @regenddatetime
		ORDER BY s.siteid DESC

		SET ROWCOUNT @size
		SELECT s.siteid,[name],Market,ContentMemo,
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
		FROM @tempTable t left join site s on t.tempid=s.siteid 
	left join zgyey_om..MarketTrace m on s.siteid=m.kid
	left join zgyey_om..kindergarten_attach_info k on m.kid=k.kid
		WHERE row>@ignore
		ORDER BY s.siteid DESC
	END
	ELSE IF @page=1
	BEGIN
		SET ROWCOUNT @size
		SELECT s.siteid,[name],Market,ContentMemo,
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
		FROM site s 
			left join zgyey_om..MarketTrace m on s.siteid=m.kid
			 left join zgyey_om..kindergarten_attach_info k on m.kid=k.kid
		WHERE --m.Kid=k.KID AND m.Kid=s.siteid 
		--AND (m.Kid=@siteid OR ContractStatus=@searchkey OR Customer_Desc=@searchkey OR Content_Desc=@searchkey 
		--OR Register_Source=@searchkey OR Real_Source=@searchkey OR Agent_Desc=@searchkey OR KinStatus=@searchkey
		--OR [name] LIKE '%'+@sitename+'%'
		--OR s.regdatetime BETWEEN @regstartdatetime AND @regenddatetime
	--	) 
	--and 
	s.regdatetime BETWEEN @regstartdatetime AND @regenddatetime
		ORDER BY s.siteid DESC
	END
	ELSE
	BEGIN
		SELECT s.siteid,[name],Market,ContentMemo,
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
		
		FROM site s 
			left join zgyey_om..MarketTrace m on s.siteid=m.kid
			 left join zgyey_om..kindergarten_attach_info k on m.kid=k.kid
		WHERE --m.Kid=k.KID AND m.Kid=s.siteid 
		--AND (m.Kid=@siteid OR ContractStatus=@searchkey OR Customer_Desc=@searchkey OR Content_Desc=@searchkey 
		--OR Register_Source=@searchkey OR Real_Source=@searchkey OR Agent_Desc=@searchkey OR KinStatus=@searchkey
		--OR [name] LIKE '%'+@sitename+'%'
		--OR s.regdatetime BETWEEN @regstartdatetime AND @regenddatetime
		--) 
		--and 
			s.regdatetime BETWEEN @regstartdatetime AND @regenddatetime
		ORDER BY s.siteid DESC
	END
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_MarketTrace_GetListBySearch', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_MarketTrace_GetListBySearch', @level2type=N'PARAMETER',@level2name=N'@page'
GO

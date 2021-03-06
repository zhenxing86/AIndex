USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[feestandard_payinfo_GetList]    Script Date: 02/12/2014 17:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
ALTER PROCEDURE [dbo].[feestandard_payinfo_GetList]
@kid int
 AS 


;WITH temp AS
	(
	select
		substring(case when a2>0 then ',05,801' else '' end
			+case when a3>0 then ',05,802' else '' end
			+case when a4>0 then ',05,803' else '' end
			+case when a5>0 then ',05,804' else '' end
			+case when a6>0 then ',05,805' else '' end
			+case when a7>0 then ',05,806' else '' end
			+case when a8>0 then ',05,807' else '' end
			+case when a9>0 then ',05,808' else '' end
			+case when a10>0 then ',05,809' else '' end
			+case when a11>0 then ',05,810' else '' end
			+case when a12>0 then ',05,811' else '' end
			+case when a13>0 then ',05,812' else '' end
			,4,100)
			payitem
		,substring(case when a2>0 then ',801' else '' end
			+case when a3>0 then ',802' else '' end
			+case when a4>0 then ',803' else '' end
			+case when a5>0 then ',804' else '' end
			+case when a6>0 then ',805' else '' end
			+case when a7>0 then ',806' else '' end
			+case when a8>0 then ',807' else '' end
			+case when a9>0 then ',808' else '' end
			+case when a10>0 then ',809' else '' end
			+case when a11>0 then ',810' else '' end
			+case when a12>0 then ',811' else '' end
			+case when a13>0 then ',812' else '' end
			,2,100)
			payitemid
		,proxyprice amount,ID
		from feestandard
			where kid=@kid
)

select ROW_NUMBER() over(order by len(payitem)) payid
	,CONVERT(varchar,ROW_NUMBER() over(order by len(payitem)))+payitem payitem
	,payitemid,amount,ID
	 from temp
	where len(payitem)>0
	 order by len(payitem)


USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[ChangeCellset]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--select * from homebook where hbid=1902

--[ChangeCellset] 11061,2

CREATE PROCEDURE [dbo].[ChangeCellset]
@kid int,
@cellsetid int
 AS 	
declare @term nvarchar(10)
set @term='2013-1'

update t1 set t1.cellsetid=@cellsetid
from homebook t1 left join basicdata..class t2
on t1.classid=t2.cid
where t1.term=@term and t2.kid=@kid

update t1 set t1.cellsetid=@cellsetid
from growthbook t1 left join homebook t2
on t1.hbid=t2.hbid left join basicdata..class t3
on t2.classid=t3.cid
where t1.term=@term and t3.kid=@kid

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN (-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END








GO

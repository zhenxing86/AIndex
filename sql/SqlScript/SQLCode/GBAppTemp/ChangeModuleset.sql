USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[ChangeModuleset]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--[ChangeModuleset] 11061,1

CREATE PROCEDURE [dbo].[ChangeModuleset]
@kid int,
@modulesetid int
 AS 	
declare @term nvarchar(10)
set @term='2013-1'

/*
declare @term nvarchar(10)
set @term='2012-1'
select t1.* from homebook t1 left join basicdata..class t2
on t1.classid=t2.cid
where t1.term=@term and t2.kid=11061

declare @term nvarchar(10)
set @term='2012-1'
select t1.* from growthbook t1 left join homebook t2
on t1.hbid=t2.hbid left join basicdata..class t3
on t2.classid=t3.cid
where t1.term=@term and t3.kid=11061

--update homebook set modulesetid=@modulesetid where hbid=@hbid
--update growthbook set modulesetid=@modulesetid where hbid=@hbid
*/
update t1 set t1.modulesetid=@modulesetid
from homebook t1 left join basicdata..class t2
on t1.classid=t2.cid
where t1.term=@term and t2.kid=@kid

update t1 set t1.modulesetid=@modulesetid
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

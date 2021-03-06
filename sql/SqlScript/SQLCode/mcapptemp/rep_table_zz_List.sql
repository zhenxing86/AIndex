USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_table_zz_List]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*  
-- Author:    
-- Create date: 
-- Description:   
-- Memo:  
*/ 
CREATE PROCEDURE [dbo].[rep_table_zz_List]   
@kid int  
,@cid int  
,@checktime1 datetime  
,@zzid int  
 AS      
BEGIN      
	SET NOCOUNT ON  

	;WITH CET AS  
	(  
		SELECT TOP 8  
					RIGHT(CONVERT(varchar(20),StartT,102),5) +'-'   
				 +RIGHT( CONVERT(varchar(20),dateadd(dd,-1,EndT),102),5) weekdate,   
					StartT, EndT  
			FROM BasicData.dbo.WeekList   
			where StartT <= @checktime1  
			order by StartT desc  
	)    
	SELECT rm.kid, rm.cid, rm.cname, rm.userid, rm.uname, rm.checktime,
				rm.temperature, rm.result, c.weekdate, zc.Isweak  
	FROM CET c    
		left JOIN mcapp.dbo.rep_mc_child_checked_detail rm   
			on rm.checktime > = c.StartT   
			and rm.checktime < c.EndT 
		left join mcapp.dbo.zz_counter zc
			on rm.userid = zc.userid 
	WHERE rm.kid = @kid    
		and (cid=@cid or @cid=-1)   
		and ','+result+',' like '%,'+convert(varchar,@zzid)+',%'  
	order by checktime desc   

END


GO

USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[nopaykin_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[nopaykin_GetListTag]
 @page int
,@size int
,@privince int
,@city int
,@FirstTime datetime
,@LastTime datetime
 AS 



if(@FirstTime = '')
BEGIN
set @FirstTime=convert(datetime,'1900-01-01')
End


if(@LastTime = '')
BEGIN
set @LastTime=convert(datetime,'2090-01-01')
End





declare @pcount int

select @pcount=count(1) from dbo.kinbaseinfo k where linkstate='待跟进' and status='试用期'
and (privince=@privince or @privince='')
and (city=@city or @city='')
and regdatetime between @FirstTime and @LastTime





IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		if(@pcount<@ignore)
		begin
			set @page=@pcount/@size
			if(@pcount%@size<>0)
			begin
				set @page=@page+1
			end
			SET @prep=@size*@page
			SET @ignore=@prep-@size
		end
		
		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT  kid from dbo.kinbaseinfo k where linkstate='待跟进' and status='试用期' 
and (privince=@privince or @privince='')
and (city=@city or @city='')
and regdatetime between @FirstTime and @LastTime 
order by kid desc

SET ROWCOUNT @size
			
select @pcount,kid,kname,netaddress,0,0,regdatetime
,(select Title from basicdata..area where ID=privince) 
,(select Title from basicdata..area where ID=city) 
,(select top 1 tel from kinlinks l where l.kid=k.kid)
,(select top 1 qq from kinlinks l where l.kid=k.kid)
,deletetag
			FROM 
				@tmptable AS tmptable		
			INNER JOIN kinbaseinfo k
			ON  tmptable.tmptableid=k.kid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size


select @pcount,kid,kname,netaddress,0,0,regdatetime
,(select Title from basicdata..area where ID=privince) 
,(select Title from basicdata..area where ID=city) 
,(select top 1 tel from kinlinks l where l.kid=k.kid)
,(select top 1 qq from kinlinks l where l.kid=k.kid)
,deletetag
 from dbo.kinbaseinfo k where linkstate='待跟进' and status='试用期'
and (privince=@privince or @privince='')
and (city=@city or @city='')
 and regdatetime between @FirstTime and @LastTime
 order by kid desc

end


GO

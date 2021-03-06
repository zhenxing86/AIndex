USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[smsbase_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[smsbase_GetList]
 @page int
,@size int
,@ordertype int
,@kname varchar(300)
,@kid varchar(100)
 AS 



declare @curyear int
declare @curmonth int
set @curyear=datepart(year,getdate())
set @curmonth=datepart(month,getdate())



declare @pcount int


select  @pcount=count(1) from reportapp..rep_smscount t1 inner join kwebcms..site_config t2 on t1.kid=t2.siteid
where [year]=@curyear and [month]=@curmonth and kname like '%'+@kname+'%' and (kid=@kid or @kid='') 





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
			
if(@ordertype=1)
begin
INSERT INTO @tmptable(tmptableid)
select t1.kid from reportapp..rep_smscount t1 inner join kwebcms..site_config t2 on t1.kid=t2.siteid
where [year]=@curyear and [month]=@curmonth and kname like '%'+@kname+'%' and (kid=@kid or @kid='') 
order by smsnum desc
end

else if (@ordertype=2)
begin
INSERT INTO @tmptable(tmptableid)
select kid from reportapp..rep_smscount t1 inner join kwebcms..site_config t2 on t1.kid=t2.siteid
where [year]=@curyear and [month]=@curmonth and kname like '%'+@kname+'%' and (kid=@kid or @kid='') 
order by smscount desc
end


			SET ROWCOUNT @size
			SELECT 
				 @pcount,kid,kname,smscount,smsnum FROM 
				@tmptable AS tmptable		
			inner join reportapp..rep_smscount t1
			ON  tmptable.tmptableid=t1.kid	
			inner join kwebcms..site_config t2 on tmptable.tmptableid=t2.siteid
			WHERE
				row>@ignore  and [year]=@curyear and [month]=@curmonth and kname like '%'+@kname+'%' and (kid=@kid or @kid='') 

end
else
begin
SET ROWCOUNT @size

if(@ordertype=1)
begin
select @pcount,kid,kname,smscount,smsnum from reportapp..rep_smscount t1 inner join kwebcms..site_config t2 on t1.kid=t2.siteid
where [year]=@curyear and [month]=@curmonth and kname like '%'+@kname+'%' and (kid=@kid or @kid='') 
order by smsnum desc
end

else if (@ordertype=2)
begin
select @pcount,kid,kname,smscount,smsnum from reportapp..rep_smscount t1 inner join kwebcms..site_config t2 on t1.kid=t2.siteid
where [year]=@curyear and [month]=@curmonth
order by smscount desc
end

end


GO

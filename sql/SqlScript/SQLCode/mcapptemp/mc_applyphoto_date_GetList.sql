USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_applyphoto_date_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[mc_applyphoto_date_GetList] 
@mc_pid int
,@kid int
,@page int
,@size int
 AS 
--分页存储过程


declare @pcount int--总行数

select @pcount=count(1) from mc_applyphoto_date d
inner join mc_applyphoto a on a.mc_pid=d.mc_pid
where d.mc_pid=@mc_pid and kid=@kid


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
			photodate datetime
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(photodate)
			select photodate from mc_applyphoto_date d
			inner join mc_applyphoto a on a.mc_pid=d.mc_pid
				where d.mc_pid=@mc_pid and kid=@kid order by photodate


			SET ROWCOUNT @size
			SELECT @pcount,photodate
					FROM  @tmptable AS tmptable	
								
				WHERE
					row>@ignore 

end
else
begin
SET ROWCOUNT @size

select @pcount,photodate from mc_applyphoto_date d
inner join mc_applyphoto a on a.mc_pid=d.mc_pid
where d.mc_pid=@mc_pid and kid=@kid order by photodate

end



GO

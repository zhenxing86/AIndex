USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[GetGroupTeacherTrain]    Script Date: 08/10/2013 10:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetGroupTeacherTrain]
@kid int
,@page int
,@size int
,@uname varchar(100)
,@timetype int
,@level int
as 



declare @pcount int

select @pcount=count(1) from group_teachertrain g
left join BasicData..user_baseinfo u on u.userid=g.userid 
where kid=@kid and deletetag=1
and [name] like '%'+@uname+'%' and (@timetype=timetype or @timetype=-1)
and (@level=[level] or @level=-1)

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			select ID from group_teachertrain g 
left join BasicData..user_baseinfo u on u.userid=g.userid 
where kid=@kid and deletetag=1 
and [name] like '%'+@uname+'%' and (@timetype=timetype or @timetype=-1)
and (@level=[level] or @level=-1)
order by u.userid asc,[level] desc


			SET ROWCOUNT @size
			SELECT 
				@pcount,ID,g.userid,u.[name]
,timetype
,(select Caption from BasicData..Dict d where d.ID=timetype)
,[level]
,(select Caption from BasicData..Dict d where d.ID=[level])
			FROM 
				@tmptable AS tmptable		
			INNER JOIN group_teachertrain g
			ON  tmptable.tmptableid=g.ID 
inner join BasicData..user_baseinfo u on u.userid=g.userid 

	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount,ID,g.userid,u.[name]
,timetype
,(select Caption from BasicData..Dict d where d.ID=timetype)
,[level]
,(select Caption from BasicData..Dict d where d.ID=[level])
FROM group_teachertrain g
inner join BasicData..user_baseinfo u on u.userid=g.userid 

where kid=@kid and g.deletetag=1 

and [name] like '%'+@uname+'%' and (@timetype=timetype or @timetype=-1)
and (@level=[level] or @level=-1)

order by userid asc,[level] desc





end
GO

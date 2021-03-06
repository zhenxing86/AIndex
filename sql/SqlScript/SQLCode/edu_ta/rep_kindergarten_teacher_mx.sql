USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teacher_mx]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[rep_kindergarten_teacher_mx]
@id int
,@aid int
,@kid int
,@did int
,@name varchar(50)
,@page int
,@size int
AS



declare @pcount int





select @pcount=count(1) from rep_kininfo r 
where  r.usertype=1 and t_did=@did 





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
select r.uid from  rep_kininfo r 
where  r.usertype=1 and t_did=@did 






		


			SET ROWCOUNT @size
			SELECT 
				@pcount,r.uid,r.[uname]
,case when r.gender=2 then '女' else '男' end sex
,r.t_education
,r.t_title
,r.t_post
,dbo.FUN_GetAge(r.birthday),
(select title from BasicData..Area where ID=u_privince)+
(select title from BasicData..Area where ID=u_city)+
(select title from BasicData..Area where ID=u_residence) area,t_politicalface
			FROM 
				@tmptable AS tmptable	
inner  join rep_kininfo r on r.uid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size





select @pcount,r.uid,r.[uname]
,case when r.gender=2 then '女' else '男' end sex
,r.t_education
,r.t_title
,r.t_post
,dbo.FUN_GetAge(r.birthday),
(select title from BasicData..Area where ID=u_privince)+
(select title from BasicData..Area where ID=u_city)+
(select title from BasicData..Area where ID=u_residence) area,t_politicalface
 from  rep_kininfo r 
where r.usertype=1 and t_did=@did




end


GO

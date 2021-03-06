USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_TripUser_GetListByPage]    Script Date: 08/10/2013 10:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/3/2 17:35:53
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_TripUser_GetListByPage]
@tid int
,@page int
,@size int
 AS 

	


declare @pcount int


SELECT 
	@pcount=count(1)
	 FROM [SchoolBus_TripUser] t
inner join BasicData..user_baseinfo u on t.userid=u.userid 
where tid=@tid 


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
			SELECT  id   FROM [SchoolBus_TripUser] t
inner join BasicData..user_baseinfo u on t.userid=u.userid 
where tid=@tid 


			SET ROWCOUNT @size
			SELECT 
				@pcount,t.id,tid,t.userid,inuserid,intime,parent_confirm,confirm_time,u.[name],cname,gname
		FROM 
				@tmptable AS tmptable		
			INNER JOIN [SchoolBus_TripUser] t
			ON  tmptable.tmptableid=t.id 	
inner join BasicData..user_baseinfo u on t.userid=u.userid 
inner join BasicData..user_class uc on uc.userid=u.userid 
inner join BasicData..class c on c.cid=uc.cid 
inner join BasicData..grade g on g.gid=c.grade 
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount,t.id,tid,t.userid,inuserid,intime,parent_confirm,confirm_time,u.[name],cname,gname
	 FROM [SchoolBus_TripUser] t
inner join BasicData..user_baseinfo u on t.userid=u.userid 
inner join BasicData..user_class uc on uc.userid=u.userid 
inner join BasicData..class c on c.cid=uc.cid 
inner join BasicData..grade g on g.gid=c.grade 
where tid=@tid 


end
GO

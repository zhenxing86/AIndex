USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetClassVideoListByUserID]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：分页取视频信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:18:06
------------------------------------
CREATE PROCEDURE [dbo].[class_GetClassVideoListByUserID] 
@classid int,
@userid int,
@page int,
@size int
 
 AS

		DECLARE @kid int	
		DECLARE @usertype int
		SELECT @kid=kid FROM BasicData.dbo.class WHERE cid=@classid
		SELECT @usertype=usertype FROM BasicData.dbo.[user] WHERE userid=@userid
		IF(@usertype=0)
		BEGIN
			SELECT @classid=cid FROM BasicData.dbo.user_class WHERE userid=@userid
		END
		DECLARE @tmpvideo TABLE
		(
			--定义临时表
			id int IDENTITY (1, 1),
			videoid int,
			classid int,
			title nvarchar(100),
			uploaddatetime datetime,
			isbbzx int,
			code nvarchar(100)
		)
		insert into @tmpvideo(videoid,classid,title,uploaddatetime,isbbzx,code) select t1.cid,t1.cid,[cname],getdate(),1,t2.code from BasicData.dbo.class t1 left join basicdata.dbo.personalize_class t2 on t1.cid=t2.cid where t1.cid=@classid
--		insert into @tmpvideo(videoid,classid,title,uploaddatetime,isbbzx,code) select id,id,[name],getdate(),1,code from BasicData.dbo.class  where kid=@kid and deletetag=1 and CharIndex('中国宝宝会议室',Memo ,1)>0
		insert into @tmpvideo(videoid,classid,title,uploaddatetime,isbbzx,code) SELECT videoid,classid,title,uploaddatetime,0,'' FROM class_video WHERE	classid=@classid and status=1 order by uploaddatetime desc

		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT
				id
			FROM
				@tmpvideo
			ORDER BY
				uploaddatetime DESC


			SET ROWCOUNT @size
			SELECT
				videoid,classid,title,uploaddatetime,isbbzx,code
			FROM
				@tmptable as tmptable
			INNER JOIN
				@tmpvideo t1
			ON
				tmptable.tmptableid = t1.id
			WHERE
				row > @ignore
			ORDER BY
				t1.uploaddatetime DESC





GO

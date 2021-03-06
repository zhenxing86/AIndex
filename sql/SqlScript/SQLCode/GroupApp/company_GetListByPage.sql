USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_GetListByPage]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询商家信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 16:48:04
------------------------------------
CREATE PROCEDURE [dbo].[company_GetListByPage]
@companycategoryid int,
@page int,
@size int
 AS 
IF(@page>1)
BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
END	

		DECLARE @commenttable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			companyid bigint,
			commentcount int	
		)

		DECLARE @accesstable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			companyid bigint,
			accesscount int
		)

		DECLARE @activityproduct TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			companyid bigint,
			newlevel int
		)

		DECLARE @appraisetable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			companyid bigint,
			appraisecount float
		)

INSERT INTO @commenttable(companyid,commentcount) SELECT companyid,((SELECT count(1) FROM  product t3 inner join productcomment t4 ON t3.productid=t4.productid  WHERE t3.companyid=t1.companyid AND t3.status=1 and t4.status=1)
+(SELECT count(1) FROM companycomment t5 WHERE  t5.companyid=t1.companyid and t5.status=1)) as commentcount FROM company t1 WHERE t1.status=1

INSERT INTO @accesstable(companyid,accesscount) SELECT t1.companyid, count(distinct(t2.fromip)) AS accesscount FROM company t1 inner join accesslog t2 on t1.companyid=t2.companyid WHERE t1.status=1 and t2.accessdatetime between dateadd(mm,-1,getdate()) and getdate() group by t1.companyid

INSERT INTO @activityproduct(companyid,newlevel) select t1.companyid,(case when datediff(dd,(case when t2.createdatetime>t3.createdatetime then t2.createdatetime else t3.createdatetime end),getdate())<7 then 1 
						 when datediff(dd,(case when t2.createdatetime>t3.createdatetime then t2.createdatetime else t3.createdatetime end),getdate())<30 then 2
						 else 3 end) as newlevel  from company t1 left join companyactivity t2 on (t1.companyid=t2.companyid and t2.status=1) left join product t3 on (t1.companyid=t3.companyid and t3.status=1) WHERE t1.status=1

INSERT INTO @appraisetable(companyid,appraisecount) SELECT companyid,(((SELECT count(1) FROM companyappraise WHERE status=1 and [level]=4 and userid>0 and companyid=t1.companyid)+(SELECT count(1) FROM productappraise t2 inner join product t3 on t2.productid=t3.productid where t2.status=1 and t3.status=1 and t3.companyid=t1.companyid and t2.level=4 and t2.userid>0 ))*(0.40)+((SELECT count(1) FROM companyappraise WHERE status=1 and [level]=5 and userid>0 and companyid=t1.companyid)+(SELECT count(1) FROM productappraise t2 inner join product t3 on t2.productid=t3.productid where t2.status=1 and t3.status=1 and t3.companyid=t1.companyid and t2.level=5 and t2.userid>0))*(0.60)) as appraisecount
FROM company t1 WHERE t1.status=1

IF(@companycategoryid=0)
BEGIN
	IF(@page>1)
		BEGIN

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT t1.companyid FROM company t1 WHERE companystatus=1 and status=1
			ORDER BY  t1.orderno desc, 
							((select count(1)+1 from @commenttable where commentcount>(select commentcount from @commenttable where companyid=t1.companyid))*(-0.25)
							+(select count(1)+1 from @accesstable where accesscount>(select accesscount from @accesstable where companyid=t1.companyid ))*(-0.15)
							+(select min(newlevel) from @activityproduct where companyid=t1.companyid)*(-0.20)
							+(select count(1)+1 from @appraisetable where appraisecount>(select appraisecount from @appraisetable where companyid=t1.companyid))*(-0.40)) desc 
		


			SET ROWCOUNT @size
			SELECT t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,
			  			t2.source,t2.title
			FROM 
				@tmptable AS tmptable
			INNER JOIN 
				company t1 ON tmptable.tmptableid=t1.companyid
			INNER JOIN 
				companycategory t2 ON t1.companycategoryid=t2.companycategoryid
			WHERE 
				 row >  @ignore
				 ORDER BY  t1.orderno desc, 
							((select count(1)+1 from @commenttable where commentcount>(select commentcount from @commenttable where companyid=t1.companyid ))*(-0.25)
--							(select count(productcommentid) from product t3 inner join productcomment t4 on t3.productid=t4.productid  where t3.companyid=t1.companyid)+(select count(companycommentid) from companycomment where  companyid=t1.companyid)
							+(select count(1)+1 from @accesstable where accesscount>(select accesscount from @accesstable where companyid=t1.companyid ))*(-0.15)
							+(select min(newlevel) from @activityproduct where companyid=t1.companyid)*(-0.20)
							+(select count(1)+1 from @appraisetable where appraisecount>(select appraisecount from @appraisetable where companyid=t1.companyid))*(-0.40)) desc 
		
		END
		ELSE
		BEGIN
			SET ROWCOUNT @size
			SELECT 
			t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,
			t2.source,t2.title
			 FROM [company] t1 INNER JOIN companycategory t2 ON t1.companycategoryid=t2.companycategoryid where t1.companystatus=1 and t1.status=1
			 order by t1.orderno desc, 
							((select count(1)+1 from @commenttable where commentcount>(select commentcount from @commenttable where companyid=t1.companyid))*(-0.25)
							+(select count(1)+1 from @accesstable where accesscount>(select accesscount from @accesstable where companyid=t1.companyid ))*(-0.15)
							+(select min(newlevel) from @activityproduct where companyid=t1.companyid)*(-0.20)
							+(select count(1)+1 from @appraisetable where appraisecount>(select appraisecount from @appraisetable where companyid=t1.companyid))*(-0.40)) desc 
		END
END
ELSE
BEGIN
		IF(@page>1)
		BEGIN

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT t1.companyid FROM company t1 WHERE t1.companystatus=1 and t1.status=1 and (t1.companycategoryid=@companycategoryid or t1.companycategoryid in (SELECT companycategoryid FROM companycategory WHERE parentid=@companycategoryid))
			ORDER BY t1.orderno desc,
							((select count(1)+1 from @commenttable where commentcount>(select commentcount from @commenttable where companyid=t1.companyid))*(-0.25)
							+(select count(1)+1 from @accesstable where accesscount>(select accesscount from @accesstable where companyid=t1.companyid ))*(-0.15)
							+(select min(newlevel) from @activityproduct where companyid=t1.companyid)*(-0.20)
							+(select count(1)+1 from @appraisetable where appraisecount>(select appraisecount from @appraisetable where companyid=t1.companyid))*(-0.40)) desc 



			SET ROWCOUNT @size
			SELECT t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,
			  			t2.source,t2.title
			FROM 
				@tmptable AS tmptable
			INNER JOIN 
				company t1 ON tmptable.tmptableid=t1.companyid
			INNER JOIN 
				companycategory t2 ON t1.companycategoryid=t2.companycategoryid
			WHERE 
				row >  @ignore ORDER BY t1.orderno desc,
							((select count(1)+1 from @commenttable where commentcount>(select commentcount from @commenttable where companyid=t1.companyid))*(-0.25)
							+(select count(1)+1 from @accesstable where accesscount>(select accesscount from @accesstable where companyid=t1.companyid ))*(-0.15)
							+(select min(newlevel) from @activityproduct where companyid=t1.companyid)*(-0.20)
							+(select count(1)+1 from @appraisetable where appraisecount>(select appraisecount from @appraisetable where companyid=t1.companyid))*(-0.40)) desc 

		
		END
		ELSE
		BEGIN
			SET ROWCOUNT @size
			SELECT 
			t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,
			t2.source,t2.title
			 FROM [company] t1 INNER JOIN companycategory t2 ON t1.companycategoryid=t2.companycategoryid where t1.companystatus=1 and t1.status=1 and (t1.companycategoryid=@companycategoryid or t1.companycategoryid in (SELECT companycategoryid FROM companycategory WHERE parentid=@companycategoryid))
			 order by t1.orderno desc,
							((select count(1)+1 from @commenttable where commentcount>(select commentcount from @commenttable where companyid=t1.companyid))*(-0.25)
							+(select count(1)+1 from @accesstable where accesscount>(select accesscount from @accesstable where companyid=t1.companyid ))*(-0.15)
							+(select min(newlevel) from @activityproduct where companyid=t1.companyid)*(-0.20)
							+(select count(1)+1 from @appraisetable where appraisecount>(select appraisecount from @appraisetable where companyid=t1.companyid))*(-0.40)) desc 

		END
END
--IF(@page>1)
--BEGIN
--		DECLARE @prep int,@ignore int
--		
--		SET @prep = @size * @page
--		SET @ignore=@prep - @size
--
--		DECLARE @tmptable TABLE
--		(
--			--定义临时表
--			row int IDENTITY (1, 1),
--			tmptableid bigint
--		)
--END	
--
--IF(@companycategoryid=0)
--BEGIN
--	IF(@page>1)
--		BEGIN
--
--			SET ROWCOUNT @prep
--			INSERT INTO @tmptable(tmptableid)
--			SELECT companyid FROM company WHERE companystatus=1 ORDER BY activitycount*5+productscount*3+companyappraisecount*2+companycommentcount*2+viewcount desc
--
--			SET ROWCOUNT @size
--			SELECT t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,
--			  			t2.source,t2.title
--			FROM 
--				@tmptable AS tmptable
--			INNER JOIN 
--				company t1 ON tmptable.tmptableid=t1.companyid
--			INNER JOIN 
--				companycategory t2 ON t1.companycategoryid=t2.companycategoryid
--			WHERE 
--				row >  @ignore ORDER BY t1.activitycount*5+t1.productscount*3+t1.companyappraisecount*2+t1.companycommentcount*2+t1.viewcount desc
--		
--		END
--		ELSE
--		BEGIN
--			SET ROWCOUNT @size
--			SELECT 
--			t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,
--			t2.source,t2.title
--			 FROM [company] t1 INNER JOIN companycategory t2 ON t1.companycategoryid=t2.companycategoryid where companystatus=1 order by t1.activitycount*5+t1.productscount*3+t1.companyappraisecount*2+t1.companycommentcount*2+t1.viewcount desc
--		END
--END
--ELSE
--BEGIN
--		IF(@page>1)
--		BEGIN
--
--			SET ROWCOUNT @prep
--			INSERT INTO @tmptable(tmptableid)
--			SELECT companyid FROM company WHERE companystatus=1 and (companycategoryid=@companycategoryid or companycategoryid in (SELECT companycategoryid FROM companycategory WHERE parentid=@companycategoryid))  ORDER BY viewcount desc
--
--			SET ROWCOUNT @size
--			SELECT t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,
--			  			t2.source,t2.title
--			FROM 
--				@tmptable AS tmptable
--			INNER JOIN 
--				company t1 ON tmptable.tmptableid=t1.companyid
--			INNER JOIN 
--				companycategory t2 ON t1.companycategoryid=t2.companycategoryid
--			WHERE 
--				row >  @ignore ORDER BY t1.activitycount*5+t1.productscount*3+t1.companyappraisecount*2+t1.companycommentcount*2+t1.viewcount desc 
--		
--		END
--		ELSE
--		BEGIN
--			SET ROWCOUNT @size
--			SELECT 
--			t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,
--			t2.source,t2.title
--			 FROM [company] t1 INNER JOIN companycategory t2 ON t1.companycategoryid=t2.companycategoryid where t1.companystatus=1 and (t1.companycategoryid=@companycategoryid or t1.companycategoryid in (SELECT companycategoryid FROM companycategory WHERE parentid=@companycategoryid)) order by t1.activitycount*5+t1.productscount*3+t1.companyappraisecount*2+t1.companycommentcount*2+t1.viewcount desc
--		END
--END

GO

USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[init_gartenlist]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_gartenlist]
@areaid int
as

insert into gartenlist(kid,kname,sitedns,mingyuan,orderby,areaid,regdatetime)
select k.kid,k.kname,s.sitedns,'',0,[dbo].[GetKinArea](k.privince,k.city,k.area,k.residence),s.regdatetime from BasicData..kindergarten k
left join kwebcms..site s on s.siteid=k.kid 
left join gartenlist x on x.kid=k.kid
where  k.city=@areaid and x.kid is null




GO

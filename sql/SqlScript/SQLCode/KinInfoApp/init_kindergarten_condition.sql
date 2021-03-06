USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[init_kindergarten_condition]    Script Date: 08/10/2013 10:26:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_kindergarten_condition]

as 


insert into KinInfoApp..kindergarten_condition(kid,kname,kurl,isgood)
select kid,kname,sitedns,0 from edu_ta..gartenlist g where not exists (
select kid from KinInfoApp..kindergarten_condition c where c.kid=g.kid
) 

insert into KinInfoApp..kindergarten_condition(kid,kname,kurl,isgood)
select kid,kname,sitedns,0 from edu_jn..gartenlist g where  not exists (
select kid from KinInfoApp..kindergarten_condition c where c.kid=g.kid
)
GO

USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_netregist_list]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_netregist_list]
@regftime datetime
,@regltime datetime
 AS 

select '' 每月注册幼儿园数,'' 该月真实注册幼儿园,'' 该月注册幼儿园收费数,'' 明确拒绝数,'' 联系不上数,'' 待跟进数 

select count(ID) 注册数,convert(varchar(7),regdatetime,120) 月份  from 
kinbaseinfo group by convert(varchar(7),regdatetime,120)

select count(ID) 正常缴费,convert(varchar(7),regdatetime,120) 月份  from 
kinbaseinfo where status='正常缴费' group by convert(varchar(7),regdatetime,120)

--select * from kinbaseinfo



GO

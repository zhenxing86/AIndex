USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[UP_Sms_smsmessage_GetSender]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UP_Sms_smsmessage_GetSender] 
@strWhere varchar (100)
AS

	declare @sqlstr varchar (500)
	--select @sqlstr='	select userid as id,name,(select top 1 mobile from sms_usermobile where userid=t_child.userid) as mobile  from t_child '+@strwhere
	select @sqlstr=' select t_child.userid as id ,t_child.name,dbo.DictionaryCaptionFromID(gender) as gender,birthday,(select top 1 mobile from sms_usermobile where userid=t_child.userid) as mobile ,t_class.name as classname  from t_child left join t_class on t_child.classid=t_class.id '+@strwhere
	execute (@sqlstr)
GO

USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[I_GetData]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[I_GetData] 
@operflag varchar (40)=null,
@id varchar (10)=null,
@Tagid int=null,
@Sourid int =null,
@tagstr varchar (1000)=null

AS

declare @sqlstr varchar (2000)
declare @kid int
begin
	if @operflag='getgroupinfo'
		select id,name,remark from sms_group where userid=@id and status=0

	if @operflag='getgroupdetail'
		select name,remark from sms_group where id=@id

	if @operflag='getgroupinfo'
		select id,name from sms_group where status=0 and  userid=@id order by id 

	if @operflag='getlxrinfo'
--		select a.id,a.name,a.recmobile,b.name as groupname,a.ddate
--		from sms_lxrinfo a,sms_group b
--		where a.groupid=b.id and b.userid=@id and a.status=0 and b.status=0
		select @sqlstr='select a.id,a.name,a.recmobile,b.name as groupname,a.ddate from sms_lxrinfo a,sms_group b 	where a.groupid=b.id and b.userid='+cast(@id as varchar (10))+' and a.status=0 and b.status=0 '+@tagstr
		execute (@sqlstr)

	if @operflag='getlxrinfobyid'
		select * from sms_lxrinfo where id=@id and status=0

	if @operflag='getclassgroup'
		if exists(select usertype=98 from t_users where id=@id)		
			--是管理员
			begin
				select @kid=kindergartenid from t_users a,T_Staffer b where a.id=b.userid and b.status=1 and a.id=@id
				
				select a.id,a.name,1 as flag from t_class a where a.kindergartenid=@kid  union 
				select id,name,2 as flag from sms_group where status=0 and userid=@id
				order by flag,id

			end
		else
			--非管理员
			select a.id,a.name,1 as flag from t_class a,T_StafferClass b where b.userid=@id and a.id=b.classid union 
			select id,name,2 as flag from sms_group where status=0 and userid=@id
			order by flag,id

	if @operflag='getclassMb'
		select userid as id,name,mobile from t_child where classid=@id

	if @operflag='getgroupMB'
		select id,name,recmobile as mobile  from sms_lxrinfo where groupid=@id

	if @operflag='getseekcontent'
		if (exists (select usertype=100 from t_users where id=@id))
			--是管理员
			begin
				select id,title as name,superior as parid,1 as flag from t_area
				union
				select id,name,area as parid,2 as flag from t_kindergarten
				union 
				select id, name,kindergartenid as parid,3 as flag from t_class
				union 
				select id,name,kindergartenid as parid,4 as flag from t_department
				order by flag,id
			end
		else
			begin
				select @kid=kindergartenid from t_staffer where userid=@id
				select id,name,'' as parid,3 as flag from t_class where kindergartenid=@kid
				union
				select id,name,'' as parid,4 as flag  from t_department where kindergartenid=@kid
				order by  flag,id
			end
		
				

end
GO

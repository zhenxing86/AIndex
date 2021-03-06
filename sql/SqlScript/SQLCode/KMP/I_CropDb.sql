USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[I_CropDb]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************
开发人员：   Idealxb
开发日期：   2005.04.18
功能描述：   集中数据处理功能  (集合)
参数说明：

@operflag   	in   功能标识长符
@TagId     	in   目标ＩＤ
@SourId        	in   源ID
@ResultDesc	out 返回结果   0 正常   非0 　异常
@ResultDesc     out 返回结果相关描述  
@Sourstr	in    源字符串

******************************************************************************/
CREATE PROCEDURE [dbo].[I_CropDb]
@operflag varchar (20),
@TagId int=null,
@SourId int =null,
@Result int output,
@ResultDesc varchar (50) output,
@Sourstr varchar (2000) =null,
@Tagstr varchar(2000)=null,
@appstr varchar (1000)=null
AS


begin

	if @operflag='groupadd'
		begin
			insert into sms_group (userid,name,Remark) values (@TagId,@Sourstr,@Tagstr)
			select @resultdesc=''			
		end

	if @operflag='groupdel'
		begin
			update sms_group set status=1 where id=@TagId
		end

	if @operflag='groupmodi'
		begin
			update sms_group set name=@Sourstr,remark=@Tagstr where id=@SourId
		end

	if @operflag='addlxr'
		begin
			insert into sms_lxrinfo (name,sex,smsNum,groupid,ddate,status,recmobile) values (@Sourstr,@appstr,@SourId,@TagId,getdate(),0,@Tagstr)
		end

	if @operflag='lxrdel'
		begin
			update sms_lxrinfo set status=1 where id=@TagId
		end


end
GO

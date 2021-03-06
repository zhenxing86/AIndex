USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[TeacherDetails_ADD]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--鐢ㄩ€旓細澧炲姞涓€鏉¤褰?
--椤圭洰鍚嶇О锛?
--璇存槑锛?
--鏃堕棿锛?012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[TeacherDetails_ADD]
  @uid int,
 @ename varchar(50),
 @cardtype varchar(50),
 @cardno varchar(50),
 @hometown varchar(500),
 @country varchar(50),
 @nativeplace varchar(50),
 @overseas varchar(50),
 @householdtype varchar(50),
 @householdaddress varchar(2000),
 @establishment varchar(50),
 @isedu varchar(20),
 @teacherno varchar(50),
 @workdate varchar(50),
 @healthinfo varchar(200),
 @income varchar(100),
 @social varchar(20),
 @pension varchar(20),
 @medical varchar(20),
 @nation varchar(20)
,@address nvarchar(500)
,@lastyearinfo nvarchar(20)
,@basemoney int
,@lastyearmoney int
,@ishousingreserve nvarchar(20)
,@isteachercert nvarchar(20)
,@issuingauthority nvarchar(20)
,@teachercerttype nvarchar(20)
,@islostinsurance nvarchar(20)
,@isbusinessinsurance nvarchar(20)
,@isbirthinsurance nvarchar(20)
,@otherallowances nvarchar(20)
,@achievements nvarchar(20)
 AS 

declare @pcount int
select @pcount=count(1) from [TeacherDetails] where [uid] = @uid

if (@pcount>0)
begin

	UPDATE [TeacherDetails] SET 
 
 [ename] = @ename,
 [cardtype] = @cardtype,
 [cardno] = @cardno,
 [hometown] = @hometown,
 [country] = @country,
 [nativeplace] = @nativeplace,
 [overseas] = @overseas,
 [householdtype] = @householdtype,
 [householdaddress] = @householdaddress,
 [establishment] = @establishment,
 [isedu] = @isedu,
 [teacherno] = @teacherno,
 [workdate] = @workdate,
 [healthinfo] = @healthinfo,
 [income] = @income,
 [social] = @social,
 [pension] = @pension,
 [medical] = @medical,
 nation=@nation
 ,[address]=@address
      ,[lastyearinfo]=@lastyearinfo
      ,[basemoney]=@basemoney
      ,[lastyearmoney]=@lastyearmoney
      ,[ishousingreserve]=@ishousingreserve
      ,[isteachercert]=@isteachercert
      ,[issuingauthority]=@issuingauthority
      ,[teachercerttype]=@teachercerttype
      ,[islostinsurance]=@islostinsurance
      ,[isbusinessinsurance]=@isbusinessinsurance
      ,[isbirthinsurance]=@isbirthinsurance
      ,[otherallowances]=@otherallowances
      ,[achievements]=@achievements
 
 
 	 WHERE  [uid] = @uid

end
else
begin

	INSERT INTO [TeacherDetails](
  [uid],
 [ename],
 [cardtype],
 [cardno],
 [hometown],
 [country],
 [nativeplace],
 [overseas],
 [householdtype],
 [householdaddress],
 [establishment],
 [isedu],
 [teacherno],
 [workdate],
 [healthinfo],
 [income],
 [social],
 [pension],
 [medical],
nation
 ,[address]
      ,[lastyearinfo]
      ,[basemoney]
      ,[lastyearmoney]
      ,[ishousingreserve]
      ,[isteachercert]
      ,[issuingauthority]
      ,[teachercerttype]
      ,[islostinsurance]
      ,[isbusinessinsurance]
      ,[isbirthinsurance]
      ,[otherallowances]
      ,[achievements]
	)VALUES(
	
  @uid,
 @ename,
 @cardtype,
 @cardno,
 @hometown,
 @country,
 @nativeplace,
 @overseas,
 @householdtype,
 @householdaddress,
 @establishment,
 @isedu,
 @teacherno,
 @workdate,
 @healthinfo,
 @income,
 @social,
 @pension,
 @medical,
@nation
 	,@address
      ,@lastyearinfo
      ,@basemoney
      ,@lastyearmoney
      ,@ishousingreserve
      ,@isteachercert
      ,@issuingauthority
      ,@teachercerttype
      ,@islostinsurance
      ,@isbusinessinsurance
      ,@isbirthinsurance
      ,@otherallowances
      ,@achievements
	)
end
	RETURN @uid





GO

USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[ChildDetails_ADD]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description:   
-- Memo:    
------------------------------------  
CREATE PROCEDURE [dbo].[ChildDetails_ADD]  
  @uid int,  
 @ename varchar(50),  
 @cardtype varchar(50),  
 @cardno varchar(50),  
 @hometown varchar(500),  
 @householdtype varchar(50),  
 @householdaddress varchar(2000),  
 @isone varchar(20),  
 @isstay varchar(20),  
 @iscity varchar(20),  
 @isdis varchar(20),  
 @distype varchar(20),  
 @isboarding varchar(20),  
 @isonly varchar(20),  
 @isdown varchar(20),  
 @isaccept varchar(20),  
 @parentname1 varchar(20),  
 @parentcardno1 varchar(50),  
 @parentname2 varchar(20),  
 @parentcardno2 varchar(50),  
 @nation varchar(50),  
 @overseas varchar(50),  
 @country varchar(50),  
 @cardtype1 varchar(50),  
 @cardtype2 varchar(50),  
 @address nvarchar(350),  
 @profession varchar(50),
 @education varchar(50),
 @income varchar(50)
   
 AS   
  
declare @pcount int  
select @pcount=count(1) from [ChildDetails] where [uid] = @uid  
  
if (@pcount>0)  
begin  
  
UPDATE [ChildDetails] SET   
 [ename] = @ename,  
 [cardtype] = @cardtype,  
 [cardno] = @cardno,  
 [hometown] = @hometown,  
 [householdtype] = @householdtype,  
 [householdaddress] = @householdaddress,  
 [isone] = @isone,  
 [isstay] = @isstay,  
 [iscity] = @iscity,  
 [isdis] = @isdis,  
 [distype] = @distype,  
 [isboarding] = @isboarding,  
 [isonly] = @isonly,  
 [isdown] = @isdown,  
 [isaccept] = @isaccept,  
 [parentname1] = @parentname1,  
 [parentcardno1] = @parentcardno1,  
 [parentname2] = @parentname2,  
 [parentcardno2] = @parentcardno2,  
nation=@nation,  
overseas=@overseas,  
country=@country,  
cardtype1=@cardtype1,  
cardtype2=@cardtype2,  
[address]=@address,
 profession=@profession,
education= @education,
income= @income
   WHERE  [uid] = @uid  
  
end  
  
else  
begin  
  
 INSERT INTO [ChildDetails](  
  [uid],  
 [ename],  
 [cardtype],  
 [cardno],  
 [hometown],  
 [householdtype],  
 [householdaddress],  
 [isone],  
 [isstay],  
 [iscity],  
 [isdis],  
 [distype],  
 [isboarding],  
 [isonly],  
 [isdown],  
 [isaccept],  
 [parentname1],  
 [parentcardno1],  
 [parentname2],  
 [parentcardno2],  
nation,  
overseas,  
country,  
cardtype1,  
cardtype2,  
[address],  
 profession,
education,
 income
 
 )VALUES(  
   
  @uid,  
 @ename,  
 @cardtype,  
 @cardno,  
 @hometown,  
 @householdtype,  
 @householdaddress,  
 @isone,  
 @isstay,  
 @iscity,  
 @isdis,  
 @distype,  
 @isboarding,  
 @isonly,  
 @isdown,  
 @isaccept,  
 @parentname1,  
 @parentcardno1,  
 @parentname2,  
 @parentcardno2,  
 @nation,  
@overseas,  
@country,  
@cardtype1,  
@cardtype2,   
@address,
 @profession,
 @education,
 @income

 )  
  
  
  
end  
 RETURN @uid  
  
  
GO

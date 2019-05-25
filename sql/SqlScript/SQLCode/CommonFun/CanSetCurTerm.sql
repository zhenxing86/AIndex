USE CommonFun
GO
/****** Object:  StoredProcedure [dbo].[CanSetCurTerm]    Script Date: 07/02/2014 17:27:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------
-- Author:      xie
-- Create date: 2014-07-02 
-- Description: 根据时间和kid判断是否有设置当前学期的权限
-- Paradef:  
@result int=0 --不用升学期，1：--要升学期，但还没有升学期。2：要升学期，并且已经升学期。

如果当前学期已经设置，就不能设置；
1、如果当前学期（term='xxxx-1'）还没有设置，并且
1）当前时间还没有到春节（下学期），并且离春节相差不大于2个月；容许设置下学期。
2）如果不满足1），则不容许设置下学期

2、如果当前学期（term='xxxx-0'）还没有设置，并且
1）当前时间还没有到9月1日（上学期），并且离9月1日相差不大于2个月；容许设置下学期。
2）如果不满足1），则不容许设置下学期
-- Memo:  
 declare @t_date datetime,@date datetime='2014-09-30 10:00:00',@ret int=0,@term_s nvarchar(10)=''
 select @term_s = fn_dbo.getCurrentTerm(17709,@date,1)  
 select @term_s
 
 set @date='2014-07-31 10:00:00'
 set @ret =0
 select dbo.fn_getCurrentTerm(17709,@date,1)  

declare @t_date datetime,@date datetime='2014-06-30 10:00:00',@ret int=0
 exec @ret=CanSetCurTerm 17709,@date
 select @ret
 
 set @t_date = Month(dateadd(MONTH,2,@date))
 select 1 from BasicData.dbo.kid_term   
	  where bgndate <= @t_date
	   and enddate >= @t_date
	   and kid = 17709 
------------------------------------*/
alter PROCEDURE [dbo].[CanSetCurTerm]
@kid int
,@date datetime
 AS 

begin 
  
Begin tran       
 BEGIN TRY  
 
	DECLARE @type int,@term nvarchar(10)='1',@next_term nvarchar(10)='1',
	@t_date datetime,@result int=0 --不用升学期
	
	set @t_date = dateadd(mm,2,@date)
	select @term = CommonFun.dbo.fn_getCurrentTerm(@kid,@date,0)
	select @next_term = CommonFun.dbo.fn_getCurrentTerm(@kid,@t_date,0)
	
	IF @term<>@next_term --要升学期
	begin 
		if not exists --要升学期，但还没有升学期。
		(
		 select 1 from BasicData.dbo.kid_term   
		  where bgndate <= @t_date
		   and enddate >= @t_date
		   and kid = @kid 
		) 
		begin 
			set @result=1
		end
		else--要升学期，并且已经升学期。
		begin
			set @result=2
		end
	end 
	
	  
 Commit tran                                  
 End Try          
 Begin Catch    
    select ERROR_LINE() as Line,   
  ERROR_MESSAGE() as message1,   
  ERROR_NUMBER() as number,   
  ERROR_PROCEDURE() as proc1,   
  ERROR_SEVERITY() as severity,   
  ERROR_STATE() as state1     
    Rollback tran          
 end Catch  
	  
	RETURN @result 
	
	
end

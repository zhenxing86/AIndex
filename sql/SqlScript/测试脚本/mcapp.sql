
2014-08-21

--初始化数据
select * from basicdata..dict_xml where catalog='缺勤原因'
--事假、病假、未刷卡、其他

--declare @code int= 1,@Caption nvarchar(50)='事假',@Catalog nvarchar(50)='缺勤原因',@orderby int=1
--declare @code int= 2,@Caption nvarchar(50)='病假',@Catalog nvarchar(50)='缺勤原因',@orderby int=2
--declare @code int= 3,@Caption nvarchar(50)='未打卡',@Catalog nvarchar(50)='缺勤原因',@orderby int=3
--declare @code int= 99,@Caption nvarchar(50)='其他',@Catalog nvarchar(50)='缺勤原因',@orderby int=99
insert into basicdata..dict_xml(Code,Caption,[Catalog],OrderBy) select @code,@Caption,@Catalog,@OrderBy




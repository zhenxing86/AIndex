




insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,kid)
values( type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,kid)

alter table kmapp..HomeMenu add module_id int 

create table kmapp..HomeMenuModule 
(
id int identity(1,1) primary key,
name nvarchar(200),
remark nvarchar(200),
crtdate datetime default(getdate()),
role int,
deletetag int default(1)
)

create table kmapp..HomeMenuKindergarten 
(
id int identity(1,1) primary key,
kid int,
role int,
module_id int,
crtdate datetime default(getdate()),
)

kmapp..HomeMenu  module_id

--家长普通版 ( 阅读\健康\班级\成长)
select * from kmapp..HomeMenu h  where kid =0 and role=2
--家长借阅版 (借阅服务\本月书单\本园藏书\借阅公约)
select * from kmapp..HomeMenu h  where kid =-2 and role=2  --图片还没有提供
--园长/老师阅读综合版(阅读\健康\班级\微网站)   --开了阅读系统的需要将老师、家长都开。
select * from kmapp..HomeMenu h  where kid =-3 and role=0
--园长/老师借阅专用版(图书管理\本月书单\借阅管理\借阅服务)
select * from kmapp..HomeMenu h  where kid =-4 and role=0

insert into kmapp..HomeMenuModule(name,remark,role)
values('家长普通版','包含 阅读\健康\班级\成长',2)
insert into kmapp..HomeMenuModule(name,remark,role)
values('家长借阅版','包含 借阅服务\本月书单\本园藏书\借阅公约',2)

insert into kmapp..HomeMenuModule(name,remark,role)
values('园长阅读综合版','包含 阅读\健康\班级\微网站',0)
insert into kmapp..HomeMenuModule(name,remark,role)
values('老师阅读综合版','包含 阅读\健康\班级\微网站',1)

insert into kmapp..HomeMenuModule(name,remark,role)
values('园长借阅专用版','包含 图书管理\本月书单\借阅管理\借阅服务',0)
insert into kmapp..HomeMenuModule(name,remark,role)
values('老师借阅专用版','包含 图书管理\本月书单\借阅管理\借阅服务',1)


insert into kmapp..HomeMenuModule(name,remark,role)   --7
values('家长普通版V2','包含 微网站\成长评估\阅读\班级',2)


insert into kmapp..HomeMenuModule(name,remark,role)   --8
values('家长普通版V3','包含 阅读、家园联系、班级、微网站',2)
insert into kmapp..HomeMenuModule(name,remark,role)   --9
values('园长综合版V2','包含 阅读、家园联系、班级、微网站',0)
insert into kmapp..HomeMenuModule(name,remark,role)   --10
values('老师综合版V2','包含 阅读、家园联系、班级、微网站',1)


insert into kmapp..HomeMenuModule(name,remark,role)   --11
values('校医版','包含 晨检报表、异常确认、健康、每周食谱',3)

三、单独增加校医角色登录时光树后的导航。可以支持校医在时光树端发表上传每周食谱，查看晨检报告，对晨检异常确认等与幼儿保健与健康相关的功能。
      屏蔽与校医无关的功能入口，如家园沟通，教学文档等。让保健医生登录时光树后与校医工作相关的功能导航更清晰。
      
      
      

阅读、家园联系、班级、微网站
阅读\健康\班级\成长

select * from kmapp..HomeMenuModule 
select * from kmapp..OptionsTab where kid=0


fn_RoleGetList
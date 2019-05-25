use ossapp
go

----------------给客服分配 开通阅读的权限----------------
--ossapp..users_read_Exist

select * from ossapp..users where bid=0 and name='颜小艳'
SELECT userid FROM ossapp..users_read WHERE userid=374  


--insert into ossapp..users_read values(374)

--permissionsetting_log_add

select * from BlogApp..permissionsetting where kid= 29312
select l.*,l.douserid,u.name from applogs..permissionsetting_log l inner join ossapp..users u on l.douserid=u.ID where kid in(
31959,34627,34548,30196,32385,13636,37012,36227,29312,34147,36069,36382,36544,34148,37445,34096,36115,35218
) order by pid desc
select * from ossapp..users where id=365


select douserid,CONVERT(varchar(10),dotime,120),kid,u.name,min(l.dotime)dotime from applogs..permissionsetting_log l 
inner join ossapp..users u on l.douserid=u.ID
where l.dotime>='2018-01-01' and l.dotype=0
group by douserid,CONVERT(varchar(10),dotime,120),kid,u.name
having COUNT(1)>4


select * from applogs..permissionsetting_log where kid=3720 and ptype=157 order by dotime desc

select l.*,l.douserid,u.name from applogs..permissionsetting_log l inner join ossapp..users u on l.douserid=u.ID 
where kid = 23713
order by pid desc


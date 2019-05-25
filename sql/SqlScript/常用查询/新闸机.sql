use mcapp
go

--闸机控制器列表
zj_device_getlist 0,'',1,10

--心跳记录
zj_runstatus_getlist '223168004',1,10

--刷卡记录
zj_cardrecord_getlist '223168004',1,10

--远程维护记录
zj_operation_getlist '223168004',1,10

--操作列表
zj_opsetting_getlist

--控制命令插入
zj_operation_add

闸机控制界面用的过程


------------------------
服务端环信离园播报(提供给只使用一体机且需要在时光树客户端接收环信离园播报这类客户使用)
保存到这个表, kid和离园时间
mcapp..hx_setting

select count(1) from mcapp..kindergarten
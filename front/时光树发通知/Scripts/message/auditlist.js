$(function () {

    var instance = Layzr({
        normal: 'data-src',
        threshold: 10
    })

    var msgs = {
        messages: []
    }
    var auditData = {
        message: {},
        receiver: '',
        teachers: [],
        classes: []
    }

    Vue.component('Msg', {
        template: '#msg',
        props: ['message'],
        data: function () {
            return {
                teachers: [],
                classes: []
            }
        },
        methods: {
            detail: function () {
                auditData = {
                    message: this.message,
                    receiver: this.receiver,
                    teachers: this.teachers,
                    classes: this.classes
                }
                router.go({ name: 'aduit' })
            }
        },
        computed: {
            receiver: function () {
                var temp = []
                if (this.teachers.length > 0)
                    temp.push('老师' + this.teachers.length + '人')
                temp = temp.concat(this.classes)
                return (temp.join(',') || '加载中...')
            },
        },
        ready: function () {
            $.ajax({
                url: '/message/GetReceivers',
                data: {
                    taskid: this.message.taskid,
                    kid: document.querySelector('#kid').value,
                    messagetype: this.message.type,
                    state: this.message.state
                },
                success: function (data) {
                    var teachers = []
                    var classes = []
                    for (var i = 0; i < data.read.length; i++) {
                        for (var j = 0; j < data.read[i].member.length; j++) {
                            if (data.read[i].member[j].usertype == 1) {
                                teachers.push(data.read[i].member[j])
                            } else {
                                if (classes.indexOf(data.read[i].name) < 0) {
                                    classes.push(data.read[i].name)
                                }
                            }
                        }
                    }
                    for (var i = 0; i < data.unread.length; i++) {
                        for (var j = 0; j < data.unread[i].member.length; j++) {
                            if (data.unread[i].member[j].usertype == 1) {
                                teachers.push(data.unread[i].member[j])
                            } else {
                                if (classes.indexOf(data.unread[i].name) < 0) {
                                    classes.push(data.unread[i].name)
                                }
                            }
                        }
                    }
                    this.teachers = teachers
                    this.classes = classes
                }.bind(this)
            })
        }
    })
    Vue.component('MsgImg', {
        template: '#msg-img',
        props: ['imgs'],
        methods: {
            show: function (index) {
                var temp = [];
                for (var i = 0; i < this.imgs.length; i++) {
                    temp.push(this.imgs[i].url);
                }
                zyapp().com.showImgs(temp[index], temp, index);
            }
        }
    })
    Vue.component('MsgImg2', {
        template: '#msg-img2',
        props: ['imgs'],
        methods: {
            show: function (index) {
                var temp = [];
                for (var i = 0; i < this.imgs.length; i++) {
                    temp.push(this.imgs[i].url);
                }
                zyapp().com.showImgs(temp[index], temp, index);
            }
        }
    })
    Vue.component('MsgAudio', {
        template: '#msg-audio',
        data: function () {
            return {
                length: '',
                playing: false
            }
        },
        props: ['audio'],
        methods: {
            play: function () {
                var a = this.$el.querySelector('audio')
                if (this.playing) {
                    a.pause();
                    a.currentTime = 0;
                } else {
                    a.play();
                }
                this.playing = !this.playing;
            },
            ended: function () {
                var a = this.$el.querySelector('audio')
                a.pause();
                a.currentTime = 0;
                this.playing = !this.playing;
            },
            loadedmetadata: function () {
                var a = this.$el.querySelector('audio')
                var t = parseInt(a.duration);
                this.length = !!t ? (t + '\"') : '&nbsp;'
            },
            loaderror: function () {
                this.audio = '';
                this.length = '';
            }
        }
    })

    Vue.component('MsgAudio2', {
        template: '#msg-audio2',
        data: function () {
            return {
                length: '',
                playing: false
            }
        },
        props: ['audio'],
        methods: {
            play: function () {
                var a = this.$el.querySelector('audio')
                if (!!parseInt(a.duration)) {
                    if (this.playing) {
                        a.pause();
                        a.currentTime = 0;
                    } else {
                        a.play();
                    }
                    this.playing = !this.playing;
                }
            },
            ended: function () {
                var a = this.$el.querySelector('audio')
                a.pause();
                a.currentTime = 0;
                this.playing = !this.playing;
            },
            loadedmetadata: function () {
                var a = this.$el.querySelector('audio')
                var t = parseInt(a.duration);
                this.length = !!t ? (t + '\"') : '&nbsp;'
            },
            loaderror: function () {
                this.audio = '';
                this.length = '';
            }
        }
    })

    Vue.component('MsgVideo', {
        template: '#msg-video',
        props: ['video'],
        methods: {
            play: function () {
                zyapp().com.playVideo(this.video);
            }
        }
    })

    Vue.component('MsgVideo2', {
        template: '#msg-video2',
        props: ['video'],
        methods: {
            play: function () {
                zyapp().com.playVideo(this.video);
            }
        }
    })

    Vue.component('SelectList', {
        template: '#select-list',
        props: ['groups'],
        data: function () {
        },
        methods: {
            toggle: function (i) {
                this.groups[i].open = !this.groups[i].open
            }
        }
    })

    Vue.component('Confirm', {
        template: '#confirm',
        props: ['show', 'info', 'yes', 'no', 'yestext', 'notext'],
        watch: {
            'show': function (val, oldVal) {
                if (val)
                    document.body.classList.add('overflow')
                else
                    document.body.classList.remove('overflow')
            }
        },
        ready: function () {
            if (this.show)
                document.body.classList.add('overflow')
        },
        beforeDestroy: function () {
            document.body.classList.remove('overflow')
        }
    })

    Vue.filter('dateformat2', function (value) {
        return formatDate(new Date(value.replace(/-/g, '/')), 'M月d日')
    })
    Vue.filter('dateformat', function (value) {
        var today = new Date()
        var yesterday = new Date(today.getTime() - 1000 * 60 * 60 * 24)
        if (value.indexOf(formatDate(today, "yyyy-MM-dd")) >= 0) {
            return formatDate(new Date(value.replace(/-/g, '/')), 'HH:mm:ss')
        } else if (value.indexOf(formatDate(yesterday, "yyyy-MM-dd")) >= 0) {
            return '昨天 ' + formatDate(new Date(value.replace(/-/g, '/')), 'HH:mm:ss')
        }
        else {
            return formatDate(new Date(value.replace(/-/g, '/')), 'yyyy-MM-dd HH:mm:ss')
        }
    })

    Vue.filter('dateformat3', function (value) {
        return formatDate(new Date(value.replace(/-/g, '/')), 'yyyy-MM-dd HH:mm')
    })

    function formatDate(date, format) {
        var paddNum = function (num) {
            num += "";
            return num.replace(/^(\d)$/, "0$1");
        }
        var week = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六']
        //指定格式字符
        var cfg = {
            yyyy: date.getFullYear() //年 : 4位
            , yy: date.getFullYear().toString().substring(2)//年 : 2位
            , M: date.getMonth() + 1  //月 : 如果1位的时候不补0
            , MM: paddNum(date.getMonth() + 1) //月 : 如果1位的时候补0
            , d: date.getDate()   //日 : 如果1位的时候不补0
            , dd: paddNum(date.getDate())//日 : 如果1位的时候补0
            , hh: paddNum(date.getHours() % 12)  //时
            , HH: paddNum(date.getHours())  //时
            , mm: paddNum(date.getMinutes()) //分
            , ss: paddNum(date.getSeconds()) //秒
            , w: week[date.getDay()] //星期
        }
        format || (format = "yyyy-MM-dd HH:mm:ss");
        return format.replace(/([a-z])(\1)*/ig, function (m) {
            return cfg[m];
        });
    }


    var main = Vue.extend({
        template: '#main',
        data: function () {
            return {
                messages: [],
                getting: false,
                nomore: false
            }
        },
        methods: {
            getmore: function ($event) {
                instance
                    .update()
                    .check()
                    .handlers(true)
                var a = $event.target;
                if (a.scrollTop + a.clientHeight + 50 > a.scrollHeight && !this.getting && !this.nomore) {
                    this.getting = true
                    getMore(this)
                }
            }
        },
        ready: function () {
            getMore(this)
        }
    })

    var audit = Vue.extend({
        template: '#aduit',
        data: function () {
            return {
                message: auditData.message,
                receiver: auditData.receiver,
                teachers: auditData.teachers,
                classes: auditData.classes,
                open: false,
                auditing: false,
                confirm: { isShow: false, info: '', yesText: '确定', noText: '取消' },
                setState: 0
            }
        },
        computed: {
            receivers: function () {
                var temp = []
                for (var i = 0; i < this.classes.length; i++) {
                    temp.push(this.classes[i])
                }
                for (var i = 0; i < this.teachers.length; i++) {
                    temp.push(this.teachers[i].name)
                }
                return temp
            }
        },
        methods: {
            toggle: function () {
                this.open = !this.open
            },
            pass: function () {
                this.setState = 1
                this.confirm = { isShow: true, info: '确认审核通过？', yesText: '确定', noText: '取消' }
            },
            reject: function () {
                this.setState = 2
                this.confirm = { isShow: true, info: '确认审核不通过？', yesText: '确定', noText: '取消' }
            },
            yes: function () {
                if (this.auditing) return
                this.auditing = true
                this.confirm.info = '正在提交审核结果...'
                $.ajax({
                    url: '/message/auditMessage',
                    data: {
                        taskid: this.message.taskid,
                        uid: document.querySelector('#uid').value,
                        messagetype: this.message.type,
                        state: this.setState
                    },
                    success: function (data) {
                        $.ajax({
                            url: '/message/MessageGetModel',
                            data: {
                                uid: document.querySelector('#uid').value,
                                taskid: this.message.taskid,
                                messagetype: this.message.type,
                                state: this.setState
                            },
                            success: function (data) {
                                this.confirm.isShow = false
                                this.auditing = false
                                if (!!data) {
                                    this.confirm = { isShow: true, info: '操作成功', yesText: '', noText: '确定' }
                                    this.message.state = data.state
                                } else {
                                    this.confirm = { isShow: true, info: '操作失败，请重试', yesText: '', noText: '确定' }
                                }
                            }.bind(this)
                        })
                    }.bind(this)
                    , error: function () {
                        this.confirm.isShow = false
                        this.confirm = { isShow: true, info: '操作失败，请重试', yesText: '', noText: '确定' }
                    }.bind(this)
                })
            },
            no: function () {
                if (!this.auditing)
                    this.confirm.isShow = false
            }
        },
        route: {
            activate: function () {
                document.querySelector('.content').style.overflow = 'hidden'
            },
            deactivate: function () {
                document.querySelector('.content').style.overflow = 'auto'
            }
        }
    })

    var App = Vue.extend({})
    var router = new VueRouter()
    router.map({
        '/': {
            component: main,
            subRoutes: {
                '/aduit': {
                    name: 'aduit',
                    component: audit
                }
            }
        }
    })
    router.start(App, '#app')

    function getMore(context) {
        $.ajax({
            url: '/message/sendhistorydata',
            data: { aftertime: document.querySelector('#aftertime').value, uid: document.querySelector('#uid').value },
            success: function (data) {
                if (!!!data[0] || data.length == 0) {
                    this.nomore = true
                    return
                }
                msgs.messages = msgs.messages.concat(data)
                document.querySelector('#aftertime').value = data[data.length - 1].writetime
                this.messages = msgs.messages
                setTimeout(function () {
                    instance
                        .update()
                        .check()
                        .handlers(true)
                }, 10)
            }.bind(context),
            complete: function () {
                this.getting = false
            }.bind(context)
        })
    }
})
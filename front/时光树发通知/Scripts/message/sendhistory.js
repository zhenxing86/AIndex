$(function () {

    var instance = Layzr({
        normal: 'data-src',
        threshold: 10
    })

    var msgs = {
        messages: []
    };

    var receiverParam = {
        taskid: 0,
        kid: document.querySelector('#kid').value,
        messagetype: 1,
        state: 1
    }
    Vue.component('Msg', {
        template: '#msg',
        props: ['message'],
        methods: {

            detail: function (taskid, type, state) {
                //zyapp().com.newWindow('/message/message?uid={uid}&kid={kid}&role={role}&taskid=' + taskid)
                zyapp().com.newWindow('/message/message?uid=' + document.querySelector('#uid').value
                    + '&kid=' + document.querySelector('#uid').value
                    + '&role=' + document.querySelector('#role').value
                    + '&taskid=' + taskid
                    + '&messagetype=' + type
                    + "&state=" + state)
            },
            receiver: function (taskid, type, state) {
                receiverParam = {
                    kid: receiverParam.kid,
                    taskid: taskid,
                    messagetype: type,
                    state: state
                }
                router.go({ name: 'receiver' })
            }
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
    Vue.component('MsgVideo', {
        template: '#msg-video',
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
                nomore: false,
                onlyMe: false
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
        watch: {
            'onlyMe': function (val, oldVal) {
                var temp = []
                var sender = document.querySelector('#uid').value
                for (var i = 0; i < msgs.messages.length; i++) {
                    if (msgs.messages[i].sender == sender || !val) {
                        temp.push(msgs.messages[i])
                    }
                }
                this.messages = temp
                if (temp.length < 3) {
                    getMore(this)
                }
                if (val)
                    zyapp().com.rightBtn(1, '查看全部', 'onlyMe')
                else
                    zyapp().com.rightBtn(1, '只看自己', 'onlyMe')
            }
        },
        ready: function () {
            getMore(this)
            $(window).on('onlyMe', function () {
                this.onlyMe = !this.onlyMe
            }.bind(this))
        },
        route: {
            data: function () {
                if (document.querySelector('#role').value == 0) {
                    if (this.onlyMe)
                        zyapp().com.rightBtn(1, '查看全部', 'onlyMe')
                    else
                        zyapp().com.rightBtn(1, '只看自己', 'onlyMe')
                }
            }
        }
    })



    var receiver = Vue.extend({
        template: '#selector',
        data: function () {
            return {
                read: [],
                unread: [],
                tab: 'read'
            }
        },
        methods: {
            shift: function (tab) {
                this.tab = tab
            }
        },
        route: {
            data: function () {
                zyapp().com.rightBtn(0)
                $.ajax({
                    url: '/message/GetReceivers',
                    data: JSON.parse(JSON.stringify(receiverParam)),
                    success: function (data) {
                        this.read = data.read
                        this.unread = data.unread
                        if (this.read.length == 0 && this.unread.length > 0) {
                            this.tab = 'unread'
                        }
                    }.bind(this)
                })
            },
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
                '/receiver': {
                    name: 'receiver',
                    component: receiver
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
                console.log(document.querySelector('#aftertime').value)
                if (!!!data[0] || data.length == 0) {
                    this.nomore = true
                    return
                }
                msgs.messages = msgs.messages.concat(data)
                document.querySelector('#aftertime').value = data[data.length - 1].writetime
                if (!this.onlyMe) {
                    if (this.messages.length < 3) {
                        getMore(this)
                    }
                    this.messages = msgs.messages
                }
                else {
                    var temp = []
                    var sender = document.querySelector('#uid').value
                    for (var i = 0; i < msgs.messages.length; i++) {
                        if (msgs.messages[i].sender == sender) {
                            temp.push(msgs.messages[i])
                        }
                    }
                    if ((temp.length - this.messages.length) == 0 || temp.length < 3) {
                        getMore(this)
                    }
                    this.messages = temp
                }
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
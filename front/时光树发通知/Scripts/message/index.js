$(function () {
    Vue.filter('isMobileIllegal', function (value) {
        return !/^1[3|4|5|7|8]\d{9}$/.test(value)
    })
    var options = {
        students: [],
        teachers: [],
        surpluscnt: document.querySelector('#surpluscnt').value || 0,
        smsLen: document.querySelector('#smsLen').value || 0
    }

    var message = {
        kid: document.querySelector('#kid').value,
        sender: document.querySelector('#uid').value,
        smstype: document.querySelector('#smstype').value,
        imgs: [],
        audio: '',
        content: '',
        video: '',
        time: null,
        receipt: 1,
        teachers: [],
        students: [],
        istime: 0,
        sendtime: '',
        messagetype: 0,
        checked: false
    }
    var tempMessage = JSON.parse(JSON.stringify(message))

    Vue.component('ImgEditor', {
        template: '#img-editor',
        props: ['imgs', 'maxcnt', 'uploadimgs'],
        methods: {
            show: function (index) {
                var temp = [];
                for (var i = 0; i < this.imgs.length; i++) {
                    temp.push(this.imgs[i].url);
                }
                zyapp().com.delImgs(temp[index], temp, index, 'updateimgs');
            }
        },
        ready: function () {
        }
    })

    Vue.component('AudioEditor', {
        template: '#audio-editor',
        props: ['audio'],
        data: function () {
            return {
                playing: false,
                length: '',
                confirm: {
                    isShow: false,
                    info: '是否删除该音频'
                }
            }
        },
        methods: {
            play: function () {
                var a = this.$el.querySelector('audio')
                if (this.playing) {
                    a.pause()
                    a.currentTime = 0
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
                var t = parseInt(a.duration)
                this.length = !!t ? (t + '\"') : '&nbsp;'
            },
            loaderror: function () {
                this.audio = '';
                this.length = '';
            },
            del: function () {
                this.confirm.isShow = true
            },
            yes: function () {
                router.app.$children[0].$set('audio', '')
                message.audio = '';
                this.confirm.isShow = false
            },
            no: function () {
                this.confirm.isShow = false
            }
        }
    })
    Vue.component('VideoEditor', {
        template: '#video-editor',
        props: ['video', 'uploadvideo'],
        data: function () {
            return {
                confirm: {
                    isShow: false,
                    info: '是否删除该视频'
                }
            }
        },
        methods: {
            play: function () {
                zyapp().com.playVideo(this.video);
            },
            del: function () {
                this.confirm.isShow = true
            },
            yes: function () {
                router.app.$children[0].$set('video', '')
                message.video = ''
                this.confirm.isShow = false
            },
            no: function () {
                this.confirm.isShow = false
            }
        }
    })

    Vue.component('Foot', {
        template: '#foot',
        props: ['tab', 'record', 'uploadimgs', 'maxcnt']
    })

    Vue.component('SelectList', {
        template: '#select-list',
        props: ['groups'],
        data: function () {
            return { messagetype: message.messagetype }
        },
        computed: {
            needVip: function () {
                for (var i = 0; i < this.groups.length; i++) {
                    for (var j = 0; j < this.groups[i].member.length; j++) {
                        if (this.groups[i].member[j].isvip != -1) {
                            return true
                        }
                    }
                }
                return false
            },
            selectedcnt: function () {
                var t = 0
                for (var i = 0; i < this.groups.length; i++) {
                    t += this.groups[i].selectedcnt
                }
                return t
            },
            //total: function () {
            //    var t = 0
            //    for (var i = 0; i < this.groups.length; i++) {
            //        t += this.groups[i].member.length
            //    }
            //    return t
            //},
            canSmsCount: function () {
                var t = 0
                for (var i = 0; i < this.groups.length; i++) {
                    t += this.groups[i].canSmsCount
                }
                return t
            }
        },
        methods: {
            select: function (i, j) {
                if (message.messagetype > 0 || checkMobileFormat(this.groups[i].member[j].mobile) && this.groups[i].member[j].isvip != 0) {
                    this.groups[i].member[j].selected = !this.groups[i].member[j].selected
                    this.groups[i].member[j].selected ? this.groups[i].selectedcnt++ : this.groups[i].selectedcnt--
                }
            },
            selectgroup: function (i) {
                var b = this.groups[i].selectedcnt == (message.messagetype > 0 ? this.groups[i].member.length : this.groups[i].canSmsCount)
                for (var j = 0; j < this.groups[i].member.length; j++) {
                    if (message.messagetype > 0 || checkMobileFormat(this.groups[i].member[j].mobile) && this.groups[i].member[j].isvip != 0) {
                        this.groups[i].member[j].selected = !b
                    }
                }
                this.groups[i].selectedcnt = b ? 0 : (message.messagetype > 0 ? this.groups[i].member.length : this.groups[i].canSmsCount)
            },
            //selectall: function () {
            //    var b = this.selectedcnt == (message.messagetype > 0 ? this.total : this.canSmsCount)
            //    for (var i = 0; i < this.groups.length; i++) {
            //        for (var j = 0; j < this.groups[i].member.length; j++) {
            //            if (message.messagetype > 0 || checkMobileFormat(this.groups[i].member[j].mobile) && this.groups[i].member[j].isvip != 0) {
            //                this.groups[i].member[j].selected = !b
            //            }
            //        }
            //        this.groups[i].selectedcnt = b ? 0 : (message.messagetype > 0 ? this.groups[i].member.length : this.groups[i].canSmsCount)
            //    }
            //    this.selectedcnt = b ? 0 : (message.messagetype > 0 ? this.total : this.canSmsCount)
            //},
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
    var main = Vue.extend({
        template: '#main',
        data: function () {
            return {
                canSendSMS: document.querySelector('#openWebSms').value,
                entrance: [
                    { route: 'message', title: '发消息', icon: 'icon-info', isShow: true },
                    { route: 'sms', title: '手机短信', icon: 'icon-message', isShow: document.querySelector('#openWebSms').value == 1 },
                    { route: 'picture', title: '发图片', icon: 'icon-photo', isShow: true },
                    { route: 'video', title: '发视频', icon: 'icon-video', isShow: true }
//                    {route: 'message', title: '发链接', icon: 'icon-link', isShow: false}
                ]
            }
        },
        methods: {
            history: function () {
                zyapp().com.newWindow('/message/sendhistory?uid={uid}&kid={kid}&role={role}')
            }
        },
        ready: function () {
            zyapp().com.rightBtn(0)
            zyapp().com.setTitle('发通知')
        },
        route: {
            data: function () {
                message = JSON.parse(JSON.stringify(tempMessage))
            }
        }
    })
    var picture = Vue.extend({
        template: '#picture-message-editor',
        data: function () {
            return {
                tab: { audio: true, word: true, img: false },
                imgs: message.imgs,
                audio: message.audio,
                content: message.content,
                maxcnt: 9
            }
        },
        computed: {},
        methods: {
            uploadimgs: function () {
                zyapp().com.uploadImgs(this.maxcnt - this.imgs.length, 'insertimgs');
            },
            record: function () {
                zyapp().com.record('recorded');
            }
        },
        ready: function () {
            zyapp().com.setTitle("发图片")
            zyapp().com.rightBtn(1, '下一步', 'next')
        },
        beforeDestroy: function () {
            message.content = this.content
            message.audio = this.audio
            message.messagetype = 2
        }
    })

    var text = Vue.extend({
        template: '#text-message-editor',
        data: function () {
            return {
                tab: { audio: true, word: false, img: true },
                imgs: message.imgs,
                audio: message.audio,
                content: message.content,
                maxcnt: 9
            }
        },
        computed: {},
        methods: {
            uploadimgs: function () {
                zyapp().com.uploadImgs(this.maxcnt - this.imgs.length, 'insertimgs');
            },
            record: function () {
                zyapp().com.record('recorded');
            }
        },
        ready: function () {
            zyapp().com.rightBtn(1, '下一步', 'next')
        },
        beforeDestroy: function () {
            message.content = this.content
            message.audio = this.audio
            message.messagetype = 1
        }
    })

    var sms = Vue.extend({
        template: '#sms-editor',
        data: function () {
            return {
                smsLen: options.smsLen,
                tab: { audio: false, word: false, img: false },
                content: message.content,
                surpluscnt: options.surpluscnt
            }
        },
        computed: {
            enablecnt: function () {
                return this.smsLen - this.content.length;
            }
        },
        ready: function () {
            zyapp().com.setTitle("手机短信")
            zyapp().com.rightBtn(1, '下一步', 'next')
        },
        beforeDestroy: function () {
            message.content = this.content
            message.messagetype = 0
        }
    })

    var video = Vue.extend({
        template: '#video-message-editor',
        data: function () {
            return {
                video: message.video,
                tab: { audio: false, word: true, img: false },
                content: message.content,
                confirm: {
                    isShow: false,
                    info: '是否删除视频'
                }
            }
        },
        computed: {},
        methods: {
            uploadvideo: function () {
                zyapp().com.video('videoed')
            },
            del: function () {
                this.confirm.info = '是否删除视频'
                this.confirm.isShow = true
            },
            yes: function () {
                this.video = ''
                message.video = ''
                this.confirm.isShow = false
            },
            no: function () {
                this.confirm.isShow = false
            }
        },
        ready: function () {
            zyapp().com.setTitle("发视频")
            zyapp().com.rightBtn(1, '下一步', 'next');
        },
        beforeDestroy: function () {
            message.content = this.content
            message.video = this.video
            message.messagetype = 3
        }
    })

    var def_tab = 'students'
    var selector = Vue.extend({
        template: '#selector',
        data: function () {
            return {
                students: JSON.parse(JSON.stringify(options.students)),
                teachers: JSON.parse(JSON.stringify(options.teachers)),
                tab: def_tab,
                onlysendchild: document.querySelector('#onlySendChild').value,
                time: message.sendtime,
                sendding: false,
                confirm: { isShow: false, info: '', yesText: '确定', noText: '取消' },
                beforeSend: { isShow: false, info: '', yesText: '确定', noText: '取消' }
            }
        },
        methods: {
            shift: function (tab) {
                this.tab = tab
            },
            settime: function () {
                if (!!this.time) {
                    this.time = ''
                } else {
                    var now = formatDate(new Date(), 'yyyy-MM-dd HH:mm:ss')
                    var min = now
                    var max = formatDate(new Date(2099, 11, 31), 'yyyy-MM-dd HH:mm:ss')
                    zyapp().com.datetimePicker('datetime', now, min, max, 'settime')
                }
            },
            yes: function () {
                if (message.messagetype == 0) {
                    sendSMS(this)
                    this.confirm.isShow = false
                } else {
                    router.go({ path: 'selector/receipt' })
                }
            },
            no: function () {
                this.confirm.isShow = false
                if (this.confirm.info.indexOf('选择') >= 0) {
                    history.go(-2)
                    setTimeout(function () { location.reload() }, 500)
                }
            },
            send: function () {
                if (message.messagetype == 0) {
                    if (this.sendding) return
                    this.sendding = true
                    if (!checkMsg(this)) {
                        this.sendding = false
                        return
                    }
                    sendSMS(this)
                } else {
                    if (!checkMsg(this))
                        return
                    router.go({ path: 'selector/receipt' })
                }
            },
            dontSend: function () {
                this.beforeSend.isShow = false
            },
        },
        ready: function () {
            zyapp().com.setTitle("选择接收人")
            zyapp().com.rightBtn(1, '发送', 'next')
        },
        beforeDestroy: function () {
            message.checked = false
        }
    })
    var content = Vue.extend({
        template: '#text-editor',
        data: function () {
            return {
                content: message.content
            }
        },
        ready: function () {
            zyapp().com.rightBtn(1, '确定', 'next')
        }
    })
    var receipt = Vue.extend({
        template: '#receipt',
        data: function () {
            return {
                receipt: message.receipt,
                sendding: false
            }
        },
        methods: {
            select: function (receipt) {
                this.receipt = receipt
                message.receipt = receipt
            },
            send: function () {
                sendMsg(this)
            }
        },
        ready: function () {
            document.body.classList.add('overflow')
            zyapp().com.rightBtn(0, '', '')
        },
        beforeDestroy: function () {
            document.body.classList.remove('overflow')
            zyapp().com.rightBtn(1, '发送', 'next')
        }
    })
    var App = Vue.extend({})
    var router = new VueRouter()
    router.map({
        '/': {
            component: main
        },
        '/message': {
            name: 'message',
            component: text
        },
        '/sms': {
            name: 'sms',
            component: sms
        },
        '/picture': {
            name: 'picture',
            component: picture
        },
        '/video': {
            name: 'video',
            component: video
        },
        '/selector': {
            component: selector,
            subRoutes: {
                '/receipt': {
                    component: receipt
                }
            }
        },
        '/content': {
            component: content
        }
    })
    router.start(App, '#app')



    $(window).on('next', function () {
        var route = location.hash.replace('#!', '')
        for (var i = 0; i < options.students.length; i++) {
            if (options.students[i].name == '借阅会员' && route == '/sms') {
                options.students[i].isShow = false
            } else {
                options.students[i].isShow = true
            }
        }
        switch (route) {
            case '/picture':
                if (!!!message.imgs.length) {
                    zyapp().com.alert('没有图片内容')
                    return
                }
                router.go({ path: 'selector' })
                break
            case '/video':
                if (!!!message.video) {
                    zyapp().com.alert('没有视频内容')
                    return
                }
                router.go({ path: 'selector' })
                break
            case '/message':
                if (!!!document.querySelector('textarea').value && !!!message.audio.length && !!!message.imgs.length) {
                    zyapp().com.alert('内容不能为空')
                    document.querySelector('textarea').focus()
                    return
                }
                router.go({ path: 'selector' })
                break;
            case '/sms':
                if (!!!document.querySelector('textarea').value) {
                    zyapp().com.alert('内容不能为空')
                    document.querySelector('textarea').focus()
                    return
                }
                if (this.app.$children[0].enablecnt < 0) {
                    zyapp().com.alert('内容长度超过限制')
                    document.querySelector('textarea').focus()
                    return
                }
                router.go({ path: 'selector' })
                break
            case '/selector':
                message.students = []
                message.teachers = []
                for (var i = 0; i < this.app.$children[0].teachers.length; i++) {
                    for (var j = 0; j < this.app.$children[0].teachers[i].member.length; j++)
                        if (this.app.$children[0].teachers[i].member[j].selected)
                            message.teachers.push(this.app.$children[0].teachers[i].member[j].userid)
                }
                for (var i = 0; i < this.app.$children[0].students.length; i++) {
                    for (var j = 0; j < this.app.$children[0].students[i].member.length; j++)
                        if (this.app.$children[0].students[i].member[j].selected && message.students.indexOf(this.app.$children[0].students[i].member[j].userid) < 0)
                            message.students.push(this.app.$children[0].students[i].member[j].userid)
                }
                var info = ''
                var cnt = message.teachers.length + message.students.length
                if (cnt > 0)
                    info = '您选择了' + cnt + '人，现在发送吗？'
                else
                    info = '请选择接受人后再发送'
                this.app.$children[0].$set('beforeSend', { isShow: true, info: info, yesText: cnt > 0 ? '发送' : '', noText: cnt > 0 ? '稍等' : '好的' })

                break
            case '/content':
                message.content = document.querySelector('textarea').value
                history.back()
                this.app.$children[0].$set('content', message.content)
                break
        }
    }.bind(router))

    $(window).on('recorded', function (event, data) {
        var temp = (data && data.result && data.result.url) || ''
        this.app.$children[0].$set('audio', temp)
        message.audio = temp
    }.bind(router))

    $(window).on('insertimgs', function (event, data) {
        var temp = (data.result && data.result.imgs) || {}
        for (var i = 0; i < temp.length; i++) {
            message.imgs.push({ url: temp[i] })
        }
        this.app.$children[0].$set('imgs', message.imgs)
    }.bind(router))

    $(window).on('updateimgs', function (event, data) {
        var temp = (data.result && data.result.imgs) || {};
        message.imgs = [];
        for (var i = 0; i < temp.length; i++) {
            message.imgs.push({ url: temp[i] });
        }
        this.app.$children[0].$set('imgs', message.imgs);
    }.bind(router))
    $(window).on('videoed', function (event, data) {
        var temp = (data.result && data.result.url) || '';
        this.app.$children[0].$set('video', temp);
        message.video = temp;
    }.bind(router))
    $(window).on('settime', function (event, data) {
        var temp = (data.result && data.result.value) || '';
        this.app.$children[0].$set('time', formatDate(new Date(temp.replace(/-/g, '/')), 'yyyy-MM-dd HH:mm'));
        message.sendtime = temp;
    }.bind(router))

    function buildQueryString() {
        var m = JSON.parse(JSON.stringify(message))

        var temp = []
        for (var i = 0; i < m.imgs.length; i++) {
            temp.push(m.imgs[i].url)
        }
        var s = []
        for (var i = 0; i < m.students.length; i++) {
            if (s.indexOf(m.students[i]) == -1) s.push(m.students[i])
        }
        m.students = s.sort(function (a, b) { return a - b }).join(',')

        var t = []
        for (var i = 0; i < m.teachers.length; i++) {
            if (t.indexOf(m.teachers[i]) == -1) t.push(m.teachers[i])
        }
        m.teachers = t.sort(function (a, b) { return a - b }).join(',')

        return {
            content: m.content,
            imgs: temp.join(','),
            audio: m.audio,
            video: m.video,
            uid: m.sender,
            kid: m.kid,
            students: m.students,
            teachers: m.teachers,
            needAudit: m.messagetype == 0 ? document.querySelector('#auditSms').value : document.querySelector('#appAuditSms').value,
            role: document.querySelector('#role').value || 1,
            smstype: (document.querySelector('#role').value || 1) == 0 ? 2 : 1,
            messagetype: m.messagetype,
            istime: !!m.sendtime ? 1 : 0,
            sendtime: m.sendtime
        }
    }

    function checkMsg(context) {
        if (message.checked)
            return true
        var checked = false;
        if (message.students.length + message.teachers.length == 0) {
            context.beforeSend.isShow = false
            zyapp().com.alert('请选择接收人')
            context.sendding = false
        }
        else {
            context.beforeSend = { isShow: true, info: '正在检查消息内容...', yesText: '', noText: '' }
            var d = buildQueryString()
            $.ajax({
                url: '/Message/CheckMsg',
                data: d,
                async: false,
                type: 'POST',
                success: function (data) {
                    context.beforeSend.isShow = false
                    if (data.result == -1) {
                        zyapp().com.alert('内容存在非法关键字【' + data.info + '】')
                    } else if (data.result == -2) {
                        if (d.messagetype == 0) {
                            context.confirm = { isShow: true, info: '您已经发送过相同内容的短信，是否继续发送？', yesText: '确定', noText: '取消' }
                        }
                        else {
                            context.confirm = { isShow: true, info: '您已经发送过相同内容的消息，是否继续发送？', yesText: '确定', noText: '取消' }
                        }
                    } else {
                        checked = true
                    }
                }.bind(context),
                error: function () {
                    checked = true
                    context.beforeSend.isShow = false
                }
            })
        }
        message.checked = checked
        return checked
    }

    //function confirmMsg(context) {
    //    var d = buildQueryString()
    //    context.confirmInfo = "已选择" + personcount + "人<br>"
    //}

    function sendSMS(context) {
        var d = buildQueryString()
        $.ajax({
            url: '/message/SendSMS',
            data: d,
            type: 'POST',
            success: function (data) {
                //1成功，2短信不足，3待审核
                if (data.result == 1) {
                    var personcount = !!d.students ? d.students.split(',').length : 0 + !!d.teachers ? d.teachers.split(',').length : 0,
                        nosend = personcount - data.sendCount,
                        nomobile = nosend - data.notVip,
                        msg = "选择" + personcount + "人,"
                                + "已发" + data.sendCount + "人,"
                                + "未发" + nosend + "人"
                    //+ "无手机号：" + nomobile + "人,"
                    //+ "未开VIP:" + data.notVip + "人"
                    context.confirm = { isShow: true, info: msg, yesText: '', noText: '确定' }
                } else if (data.result == 2) {
                    zyapp().com.alert('短信数量不足，请联系客服充值！')
                } else if (data.result == 3) {
                    zyapp().com.toast('已经提交，需要园长审核后才能发送！')
                    zyapp().com.newWindow('/message/sendhistory?uid={uid}&kid={kid}&role={role}')
                    history.go(-2)
                    setTimeout(function () { location.reload() }, 500)
                } else {
                    zyapp().com.alert('发送失败')
                }
            },
            error: function (e) {
                zyapp().com.alert('发送失败')
            },
            complete: function () {
                context.sendding = false
            }.bind(context)
        })
    }

    function sendMsg(context) {
        if (context.sendding) return
        context.sendding = true
        var d = buildQueryString()
        $.ajax({
            url: '/message/SendAndNotice',
            data: d,
            type: 'POST',
            success: function (data) {
                if (data == 1) {
                    zyapp().com.toast('发送成功')
                    zyapp().com.newWindow('/message/sendhistory?uid={uid}&kid={kid}&role={role}')
                    history.go(-3)
                } else if (data == 3) {
                    zyapp().com.toast('已经提交，需要园长审核后才能发送！')
                    zyapp().com.newWindow('/message/sendhistory?uid={uid}&kid={kid}&role={role}')
                    history.go(-3)
                }
            },
            error: function () {
                zyapp().com.alert('发送失败')
            },
            complete: function () {
                context.sendding = false
            }.bind(context)
        })
    }

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

    $.ajax({
        url: '/message/StudentList',
        data: { uid: document.querySelector('#uid').value, kid: document.querySelector('#kid').value },
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                data[i].canSmsCount = 0
                data[i].mobileIllegalCount = 0
                for (var j = 0; j < data[i].member.length; j++) {
                    if (!checkMobileFormat(data[i].member[j].mobile)) {
                        data[i].mobileIllegalCount++
                    }
                    if (checkMobileFormat(data[i].member[j].mobile) && data[i].member[j].isvip != 0) {
                        data[i].canSmsCount++
                    }
                }
            }
            if (location.hash.indexOf('selector')) {
                router.app.$children[0].$set('students', data)
            }
            var def_selected = (document.querySelector('#def_receivers').value || "").split(',')
            for (var i = 0; i < data.length; i++) {
                for (var j = 0; j < data[i].member.length; j++) {
                    if (def_selected.indexOf(data[i].member[j].userid + '') >= 0) {
                        data[i].open = true
                        data[i].selectedcnt++
                        data[i].member[j].selected = true
                        message.students.push(data[i].member[j].userid)
                    }
                }
            }
            tempMessage = JSON.parse(JSON.stringify(message))
            options.students = data
            for (var i = 0; i < options.students.length; i++) {
                options.students[i].isShow = true
            }
        }
    })
    $.ajax({
        url: '/message/TeacherList',
        data: { uid: document.querySelector('#uid').value, kid: document.querySelector('#kid').value },
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                data[i].canSmsCount = 0
                data[i].mobileIllegalCount = 0
                for (var j = 0; j < data[i].member.length; j++) {
                    if (!checkMobileFormat(data[i].member[j].mobile)) {
                        data[i].mobileIllegalCount++
                    }
                    if (checkMobileFormat(data[i].member[j].mobile) && data[i].member[j].isvip != 0) {
                        data[i].canSmsCount++
                    }
                }
            }
            if (location.hash.indexOf('selector')) {
                router.app.$children[0].$set('teachers', data)
            }
            var def_selected = (document.querySelector('#def_receivers').value || "").split(',')
            var only_stu = document.querySelector('#onlySendChild').value == '1'
            for (var i = 0; i < data.length; i++) {
                for (var j = 0; j < data[i].member.length; j++) {
                    if (def_selected.indexOf(data[i].member[j].userid + '') >= 0) {
                        data[i].open = true
                        data[i].selectedcnt++
                        data[i].member[j].selected = true
                        message.teachers.push(data[i].member[j].userid)
                        document.querySelector('#onlySendChild').value = '0'
                    } else {
                        if (only_stu) {
                            data[i].member.splice(j--, 1)
                        }
                    }
                }
                if (data[i].selectedcnt > 0) {
                    def_tab = 'teachers'
                }
                if (data[i].selectedcnt == 0 && only_stu) {
                    data.splice(i--, 1)
                }
            }
            tempMessage = JSON.parse(JSON.stringify(message))
            options.teachers = data
            for (var i = 0; i < options.teachers.length; i++) {
                options.teachers[i].isShow = true
            }
        }
    })

    function checkMobileFormat(value) {
        return /^1[3|4|5|7|8]\d{9}$/.test(value)
    }
})
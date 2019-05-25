$(function () {

    Vue.component('vContent', {
        template: '#v-content',
        props: ['assess'],
        mounted: function () {
            console.log(this.assess)
        }
    })
    Vue.component('vImg', {
        template: '#v-img',
        props: ['assess']
    })
    Vue.component('vAudio', {
        template: '#v-audio',
        data: function () {
            return {
                playing: false,
                length: ''
            }
        },
        props: ['assess'],
        watch: {
            'playing': function (val) {
                if (val) {
                    this.$el.querySelector('.sprite').classList.add('on')
                } else {
                    this.$el.querySelector('.sprite').classList.remove('on')
                }
            }
        },
        methods: {
            play: function () {
                var a = this.$el.querySelector('audio')
                if (!!parseInt(a.duration)) {
                    if (this.playing) {
                        a.pause()
                        a.currentTime = 0
                    } else {
                        a.play()
                    }
                    this.playing = !this.playing
                }
            },
            ended: function () {
                var a = this.$el.querySelector('audio')
                a.pause()
                a.currentTime = 0
                this.playing = !this.playing
                console.log(this.playing)
            },
            loadedmetadata: function () {
                var a = this.$el.querySelector('audio')
                var t = parseInt(a.duration)
                this.length = !!t ? (t + '\"') : ''
            },
            loaderror: function () {
                this.audio = '';
                this.length = '';
            }
        }
    })
    Vue.component('vVideo', {
        template: '#v-video',
        props: ['assess'],
        methods: {
            play: function () {
                alert(1)
                zyapp().com.playVideo(this.assess.body)
            }
        }
    })
    Vue.component('box', {
        template: '#box',
        data: function () {
            return {
                isAddListShow: false
            }
        },
        props: ['assess', 'ind', 'del'],
        methods: {
            add: function () {
                this.isAddListShow = true
            },
            close: function () {
                this.isAddListShow = false
            },
            addContent: function (index) {
                this.close()
                router.push({ name: 'eContent', params: { ind: index } })
            },
            addImg: function (index) {
                this.close()
                router.push({ name: 'eImg', params: { ind: index } })
            },
            addAudio: function (index) {
                this.close()
                router.push({ name: 'eAudio', params: { ind: index } })
            },
            addVideo: function (index) {
                this.close()
                router.push({ name: 'eVideo', params: { ind: index } })
            }
        }
    })

    var eContent = Vue.extend({
        template: '#e-content',
        data: function () {
            return {
                assess: {
                    ID: 0,
                    activity_id: $('#activity_id').val(),
                    ctype: 0,
                    body: '',
                    describe: '',
                    orderno: 0,
                    state: 1
                }
            }
        },
        mounted: function () {
            this.init()
        },
        beforeDestroy: function () {
            $(window).off('insertAssess')
            zyapp().com.rightBtn(1, '保存', 'submit')
        },
        methods: {
            init: function () {
                zyapp().com.rightBtn(1, '确定', 'insertAssess')
                $(window).on('insertAssess', function () {
                    if (!this.assess.body) {
                        zyapp().com.alert('内容不能为空')
                        return
                    }
                    this.$emit('insertAssess', (this.$route.params.ind || 0) + 1, this.assess)
                    history.back()
                }.bind(this))
                this.$el.querySelector('textarea').focus()
            }
        }
    })

    var eImg = Vue.extend({
        template: '#e-img',
        data: function () {
            return {
                assess: {
                    ID: 0,
                    activity_id: $('#activity_id').val(),
                    ctype: 1,
                    body: '',
                    describe: '',
                    orderno: 0,
                    state: 1
                }
            }
        },
        mounted: function () {
            this.init()
        },
        beforeDestroy: function () {
            $(window).off('insertAssess')
            $(window).off('uploadSingleImg')
            zyapp().com.rightBtn(1, '保存', 'submit')
        },
        methods: {
            init: function () {
                zyapp().com.rightBtn(1, '确定', 'insertAssess')
                $(window).on('insertAssess', function () {
                    if (!this.assess.body) {
                        zyapp().com.alert('图片不能为空')
                        return
                    }
                    this.$emit('insertAssess', (this.$route.params.ind || 0) + 1, this.assess)
                    history.back()
                }.bind(this))
                $(window).on('uploadSingleImg', function (event, data) {
                    this.assess.body = data.result.url
                    this.$el.querySelector('textarea').focus()
                }.bind(this))
            },
            uploadSingleImg: function () {
                zyapp().com.uploadSingleImg('', 0, 'uploadSingleImg')
            }
        }
    })

    var eAudio = Vue.extend({
        template: '#e-audio',
        data: function () {
            return {
                assess: {
                    ID: 0,
                    activity_id: $('#activity_id').val(),
                    ctype: 2,
                    body: '',
                    describe: '',
                    orderno: 0,
                    state: 1
                },
                playing: false,
                length: '',
            }
        },
        watch: {
            'playing': function (val) {
                if (val) {
                    this.$el.querySelector('.sprite').classList.add('on')
                } else {
                    this.$el.querySelector('.sprite').classList.remove('on')
                }
            }
        },
        mounted: function () {
            this.init()
        },
        beforeDestroy: function () {
            $(window).off('insertAssess')
            $(window).off('record')
            zyapp().com.rightBtn(1, '保存', 'submit')
        },
        methods: {
            init: function () {
                zyapp().com.rightBtn(1, '确定', 'insertAssess')
                $(window).on('insertAssess', function () {
                    if (!this.assess.body) {
                        zyapp().com.alert('音频不能为空')
                        return
                    }
                    this.$emit('insertAssess', (this.$route.params.ind || 0) + 1, this.assess)
                    history.back()
                }.bind(this))
                $(window).on('record', function (event, data) {
                    this.assess.body = data.result.url
                }.bind(this))
            },
            record: function () {
                zyapp().com.record('record')
            },
            play: function () {
                var a = this.$el.querySelector('audio')
                if (!!parseInt(a.duration)) {
                    if (this.playing) {
                        a.pause()
                        a.currentTime = 0
                    } else {
                        a.play()
                    }
                    this.playing = !this.playing
                }
            },
            ended: function () {
                var a = this.$el.querySelector('audio')
                a.pause()
                a.currentTime = 0
                this.playing = !this.playing
                console.log(this.playing)
            },
            loadedmetadata: function () {
                var a = this.$el.querySelector('audio')
                var t = parseInt(a.duration)
                this.length = !!t ? (t + '\"') : ''
            },
            loaderror: function () {
                this.audio = '';
                this.length = '';
            },
            del: function () {
                this.assess.body = ''
                this.assess.describe = ''
            }
        }
    })

    var eVideo = Vue.extend({
        template: '#e-video',
        data: function () {
            return {
                assess: {
                    ID: 0,
                    activity_id: $('#activity_id').val(),
                    ctype: 3,
                    body: '',
                    describe: '',
                    orderno: 0,
                    state: 1
                }
            }
        },
        mounted: function () {
            this.init()
        },
        beforeDestroy: function () {
            $(window).off('insertAssess')
            $(window).off('video')
            zyapp().com.rightBtn(1, '保存', 'submit')
        },
        methods: {
            init: function () {
                zyapp().com.rightBtn(1, '确定', 'insertAssess')
                $(window).on('insertAssess', function () {
                    if (!this.assess.body) {
                        zyapp().com.alert('视频不能为空')
                        return
                    }
                    this.$emit('insertAssess', (this.$route.params.ind || 0) + 1, this.assess)
                    history.back()
                }.bind(this))
                $(window).on('video', function (event, data) {
                    this.assess.body = data.result.url
                }.bind(this))
            },
            video: function () {
                zyapp().com.video('video')
            },
            play: function () {
                alert(1)
                zyapp().com.playVideo(this.assess.body)
            }
        }
    })

    var main = Vue.extend({
        template: '#main',
        data: function () {
            return {
                activity: '',
                viewpoint: '',
                assessList: [],
                delIDs: [],
                sendedCnt: 0
            }
        },
        components: ['box'],
        mounted: function () {
            this.init()
        },
        methods: {
            init: function () {
                zyapp().com.rightBtn(1, '保存', 'submit')
                $(window).on('submit', function () {
                    if (!this.assessList.length) {
                        zyapp().com.alert('没有内容')
                        return
                    }
                    this.beforeSend()
                    for (var i = 0; i < this.delIDs.length; i++) {
                        $.post({
                            url: '/courserecord/course_assess_delete',
                            data: { ID: this.delIDs[i] }
                        })
                    }
                    for (var i = 0; i < this.assessList.length; i++) {
                        $.post({
                            url: '/courserecord/course_assess_save',
                            data: this.assessList[i]
                        }).done(function () {
                            this.sendedCnt += 1
                            if (this.sendedCnt == this.assessList.length) {
                                zyapp().com.toast('保存成功')
                            }
                        }.bind(this))
                    }
                }.bind(this))
                console.log('init')
                $.get({
                    url: '/courserecord/course_activity_assess_GetModel',
                    data: { activity_id: $('#activity_id').val() }
                }).done(function (data) {
                    this.activity = data.activity
                    this.viewpoint = data.viewpoint
                    this.assessList = data.assessList
                }.bind(this))
            },
            insertAssess: function (index, obj) {
                this.assessList.splice(index, 0, obj)
            },
            del: function (index) {
                if (this.assessList[index].ID != 0) {
                    this.delIDs.push(this.assessList[index].ID)
                }
                this.assessList.splice(index, 1)
            },
            addContent: function (index) {
                router.push({ name: 'eContent', params: { ind: index } })
            },
            addImg: function (index) {
                router.push({ name: 'eImg', params: { ind: index } })
            },
            addAudio: function (index) {
                router.push({ name: 'eAudio', params: { ind: index } })
            },
            addVideo: function (index) {
                router.push({ name: 'eVideo', params: { ind: index } })
            },
            beforeSend: function () {
                this.sendedCnt = 0
                for (var i = 0; i < this.assessList.length; i++) {
                    this.assessList[i].orderno = i + 1
                }
            }
        }
    })

    var router = new VueRouter({
        mode: 'hash',
        routes: [{
            path: '/',
            name: 'main',
            redirect: '/main'
        }, {
            path: '/main',
            component: main,
            children: [{
                path: '/eContent/:ind',
                name: 'eContent',
                component: eContent
            }, {
                path: '/eImg/:ind',
                name: 'eImg',
                component: eImg
            }, {
                path: '/eAudio/:ind',
                name: 'eAudio',
                component: eAudio
            }, {
                path: '/eVideo/:ind',
                name: 'eVideo',
                component: eVideo
            }]
        }]
    })

    var app = new Vue({
        router: router
    }).$mount('#app')
})
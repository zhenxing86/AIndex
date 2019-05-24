$(function () {

    Vue.component('MsgImg', {
        template: '#msg-img',
        props: ['imgs'],
        methods: {
            show: function (index) {
                var temp = [];
                for (var i = 0; i < this.imgs.length; i++) {
                    temp.push(this.imgs[i].url.replace(/!.*/g, ''));
                }
                zyapp().com.showImgs(temp[index], temp, index, 'updateimgs');
            }
        }
    })

    Vue.component('MsgAudio', {
        template: '#msg-audio',
        props: ['audio'],
        data: function () {
            return {
                playing: false,
                length: '',
            }
        },
        methods: {
            play: function () {
                var a = this.$el.querySelector('audio');
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
                var a = this.$el.querySelector('audio');
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

    var vm = new Vue({
        el: '#app',
        data: {
            message: {
                taskid: 0,
                content: '',
                imgs: [],
                audios: [],
                videos: []
            }
        }
    })
    $.ajax({
        url: '/message/MessageGetModel',
        data: {
            uid: document.querySelector('#uid').value,
            taskid: document.querySelector('#taskid').value,
            messagetype: document.querySelector('#messagetype').value,
            state: document.querySelector('#state').value
        },
        success: function (data) {
            this.message = data
        }.bind(vm)
    })


})
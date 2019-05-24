; $(function () {
    'use strict';
    var option = {
        kid: 0,
        grade: -1,
        cid: -1,
        username: '',
        callback: function (userid, username) {
            
        }
    }
    var PersonSL = function (settings) {
        option = $.extend({}, settings || {})
        if (option.id) {
            $.ajax({
                url: '/common/selectperson',
                data: { kid: option.kid },
                type: 'post',
                success: function (data) {
                    $('#' + option.id).html(data)
                }
            })
        }
    }
    
    $(document).on('click', '#__personList__ input[type="radio"]', function () {
        var userid = $(this).val(), username = $(this).next('span').text() //$(this).closest('label').find('span').text()

        console.log('userid:' + userid)
        console.log('username:' + username)
        option && option.callback && option.callback(userid, username)
        history.back()
    })

    $(document).on('click', '#__selectperson__ div[data-action]', function () {
        console.log($(this).data('action'))
        switch ($(this).data('action')) {
            case 'getGrade':
                getGrade.call(this)
                break
            case 'getClass':
                getClass.call(this)
                break
            case 'getUserName':
                getUserName.call(this)
                break
        }
    })
    $(document).on('click', '#__queryPerson__', function () {
        queryPerson.call(this)
    })
    var getGrade = function () {
        var $this = $(this)
        $.ajax({
            type: 'get',
            url: '/common/getGradeList',
            data: { kid: option.kid },
            cache: true,
            success: function (data) {
                if (data && typeof data === 'object') {
                    var lst = data.map(function (item) {
                        return { label: item.gname, value: item.grade }
                    })
                    $.picker(lst, {
                        onConfirm: function (result) {
                            console.log(result)
                            if (option.grade != result[0].value) {
                                $this.find('.cell-ft').html(result[0].label).addClass('black')
                                $('#__grade__').val(result[0].value)
                                $('#__cid__').closest('cell').find('cell-ft').text('')
                                $('#__cid__').val(-1)

                                option.grade = result[0].value
                                option.cid = -1
                            }
                        },
                        id: 'pickerGrade' + new Date().getTime()
                    })
                }
            }
        })
    }

    var getClass = function () {
        var $this = $(this)
        if (option.grade <= 0) return
        $.ajax({
            type: 'get',
            url: '/common/getClassList',
            data: { kid: option.kid, grade: option.grade },
            cache: true,
            success: function (data) {
                if (data && typeof data === 'object') {
                    var lst = data.map(function (item) {
                        return { label: item.cname, value: item.cid }
                    })
                    $.picker(lst, {
                        onConfirm: function (result) {
                            console.log(result)
                            if (option.cid != result[0].value) {
                                $this.find('.cell-ft').html(result[0].label).addClass('black')
                                $('#__cid__').val(result[0].value)
                                option.cid = result[0].value
                            }
                        },
                        id: 'pickerClass' + new Date().getTime()
                    })
                }
            }
        })
    }

    var getUserName = function() {
        var $this = $(this)
        inputView.call(this, '__username__', '姓名', $('#__username__').val())
    }

    var inputView = function (name, title, defaultValue) {
        var $this = $(this)
        var prompt = $.prompt('请输入' + title, defaultValue, function (text) {
            if (!text) { $.alert('请填写' + title); return; }
            $this.find('.cell-ft').text(text).addClass('black');
            $('input[name="' + name + '"]').val(text)
            prompt.remove();
        })
    }

    var queryPerson = function () {
        $.submit({
            url: '/common/personList',
            type: 'POST',
            data: {
                kid: option.kid,
                grade: option.grade,
                cid: option.cid,
                username: option.username || ''
            },
            success: function (data) {
                $('#__personList__').html(data)
            }
        })
    }

    window.PersonSL = PersonSL
    return PersonSL
});
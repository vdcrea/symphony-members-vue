import api from '../Api'

export default {
    data() {
        return {
            display: false,
            blocked: false
        }
    },
    methods: {
        getAccess(){
            this.$http({
                url: api.access,
                method: 'GET'
            }).then(function (res) {
                this.display = true
                this.blocked = res.data.blocked
                if (res.data.blocked) {
                    this.res.messages = res.data.messages
                }
            }, function (err) {
                console.log(err)
            });
        }
    },
    created() {
        this.getAccess()
    }
}

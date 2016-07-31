export default {
    data () {
        return {
            fields: {
                checkPassword: false
            }
        }
    },
    computed: {
        passwordTyped() {
            if (this.fields.password) {
                return true
            } else {
                this.fields.checkPassword = false
                return false
            }
        }
    }
}

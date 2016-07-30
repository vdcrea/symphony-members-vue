<template lang="html">
    <div class="public">
        <div class="columns">
            <div class="column"
                v-if="display">
                <div class="padding">
                    <h1 class="title is-1"
                        v-text="$route.name"></h1>
                    <h3 class="subtitle is-3">Public</h3>
                </div>
            </div>
        </div>
    </div>
</template>


<script>
import api from '../Api'
import {
    setUser
} from '../vuex/actions'

export default {
    data () {
        return {
            display: false
        }
    },
    vuex: {
        actions: {
            setUser: setUser
        }
    },
    methods: {
        getMemberFromCookie() {
            this.$http({
                url: api.member,
                method: 'GET'
            }).then(function (res) {
                if (res.data.event.success) {
                    this.setUser(res.data.user)
                    localStorage.setItem('email', res.data.user.email)
                    this.$router.go({ name: 'Dashboard'})
                } else {
                    this.display = true
                }
            }, function (err) {
                console.log(err)
            });
        }
    },
    created() {
        this.getMemberFromCookie()
    }
}
</script>

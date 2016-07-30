<template lang="html">
    <div class="activation">
        <div v-if="display"
            class="columns">
            <div class="column is-6-tablet is-offset-3-tablet is-4-desktop is-offset-4-desktop">
                <div class="padding">

                    <h1 class="title is-3"
                        v-text="$route.name"></h1>

                    <div class="notification is-primary"
                        v-for="err in res.messages"
                        transition="alert"
                        stagger="200">
                        <button class="delete"
                            @click="closeAlert($index)"></button>
                        <span v-html="err.message"></span>
                    </div>

                </div>
            </div>
        </div>
    </div>
</template>



<script>
import api from '../../Api'
import {
    setUser
} from '../../vuex/actions'

export default {
    data () {
        return {
            display: false,
            res: {
                messages: []
            }
        }
    },
    vuex: {
        actions: {
            setUser: setUser
        }
    },
    methods: {
        closeAlert(i) {
            this.res.messages.splice(i,1);
        },
        postActivation() {
            var postActivationData = {
                members_section_id: api.memberSection,
                fields: {
                    email: this.$route.params.email,
                    activation: this.$route.params.code
                },
                action: {
                    members_activate_account:''
                }
            }
            this.$http({
                url: api.member,
                data: postActivationData,
                method: 'POST'
            }).then(function (res) {
                if (res.data.event.success || res.data.event.messages[0].message === 'Member is already activated.') {
                    this.getMember()
                } else {
                    this.res = res.data.event
                    this.display = true
                    this.postRegenerateActivationLink()
                }
            }, function (err) {
                console.log(err)
            });
        },
        getMember() {
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
                    this.res = res.data.event
                }
            }, function (err) {
                console.log(err)
            });
        },
        postRegenerateActivationLink(){
            var postRegenerateActivationLinkData = {
                members_section_id: api.memberSection,
                fields: {
                    email: this.$route.params.email
                },
                action: {
                    members_regenerate_activation_code:''
                }
            }
            this.$http({
                url: api.member,
                data: postRegenerateActivationLinkData,
                method: 'POST'
            }).then(function (res) {
                for (var i = 0; i < res.data.event.messages.length; i++) {
                    this.res.messages.push(res.data.event.messages[i])
                }
            }, function (err) {
                console.log(err)
            });
        }
    },
    created() {
        this.postActivation()
    }
}
</script>

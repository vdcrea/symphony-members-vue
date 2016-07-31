<template lang="html">
    <div class="reset-password">
        <div v-if="display"
            class="columns">
            <div class="column is-6-tablet is-offset-3-tablet is-4-desktop is-offset-4-desktop">
                <div class="padding">

                    <h1 class="title is-3"
                        v-text="$route.name"></h1>

                    <form @submit.prevent="postResetPassword"
                        class="padding-bottom"
                        v-if="!blocked">
                        <p class="control">
                            <input class="input"
                                :type="[fields.checkPassword ? 'text' : 'password']"
                                placeholder="New password"
                                v-model="fields.password" />
                        </p>
                        <p class="control">
                            <label class="checkbox"
                                :class="{ 'is-disabled': !passwordTyped ">
                                <input type="checkbox"
                                    v-model="fields.checkPassword">
                                Show password
                            </label>
                        </p>
                        <p class="control">
                            <button class="button is-primary is-fullwidth"
                                :class="{ 'is-disabled': !enableSubmit, 'is-loading': apiCall }"
                                type="submit">Reset Password and log in</button>
                        </p>
                    </form>

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
import mixinGetAccess from '../../mixins/getAccess'
import mixinPasswordTyped from '../../mixins/passwordTyped'
import {
    setUser
} from '../../vuex/actions'

export default {
    data() {
        return {
            apiCall: false,
            blocked: false,
            res: {
                messages: []
            },
            fields: {
                password: ''
            }
        }
    },
    computed: {
        enableSubmit() {
            if (this.fields.password
                && !this.apiCall) {
                return true
            } else {
                return false
            }
        }
    },
    vuex: {
        actions: {
            setUser: setUser
        }
    },
    mixins: [mixinGetAccess, mixinPasswordTyped],
    methods: {
        closeAlert(i) {
            this.res.messages.splice(i,1);
        },
        toggleApiCall() {
            this.apiCall = !this.apiCall
        },
        postResetPassword() {
            var postResetPasswordData = {
                members_section_id: api.memberSection,
                fields: {
                    email: this.$route.params.email,
                    password: {
                        recovery_code: this.$route.params.code,
                        password: this.fields.password,
                        confirm: this.fields.password
                    }
                },
                action: {
                    members_reset_password: ''
                }
            }
            if (this.enableSubmit) {
                this.$http({
                    url: api.member,
                    data: postResetPasswordData,
                    method: 'POST',
                    beforeSend: this.toggleApiCall()
                }).then(function (res) {
                    if (res.data.event.success) {
                        this.getMember()
                    } else {
                        if (res.data.user && (res.data.user.banned || res.data.user.blacklisted) ) {
                            this.blocked = true
                        }
                        this.toggleApiCall()
                        this.res = res.data.event
                    }
                }, function (err) {
                    this.toggleApiCall()
                    console.log(err)
                });
            }
        },
        getMember() {
            this.$http({
                url: api.member,
                method: 'GET'
            }).then(function (res) {
                this.toggleApiCall()
                if (res.data.event.success) {
                    this.setUser(res.data.user)
                    localStorage.setItem('email', res.data.user.email)
                    this.$router.go({ name: api.loginRoute })
                } else {
                    if (res.data.user && (res.data.user.banned || res.data.user.blacklisted) ) {
                        this.blocked = true
                    }
                    this.res = res.data.event
                }
            }, function (err) {
                this.toggleApiCall()
                console.log(err)
            });
        }
    }
}
</script>

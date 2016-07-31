<template lang="html">
    <div class="login">
        <div v-if="display"
            class="columns">
            <div class="column is-6-tablet is-offset-3-tablet is-4-desktop is-offset-4-desktop">
                <div class="padding">

                    <h1 class="title is-3"
                        v-text="$route.name"></h1>

                    <form v-if="!user.id && !blocked"
                        class="padding-bottom"
                        @submit.prevent="postLogin">
                        <p class="control">
                            <input class="input"
                                type="email"
                                placeholder="Email"
                                v-model="fields.email"
                                autocomplete='off'
                                autofocus />
                        </p>
                        <p class="control">
                            <input class="input"
                                :type="[fields.checkPassword ? 'text' : 'password']"
                                placeholder="Password"
                                v-model="fields.password"
                                autocomplete='off' />
                        </p>
                        <p class="control">
                            <label class="checkbox"
                                :class="{ 'is-disabled': !passwordTyped }">
                                <input type="checkbox"
                                    v-model="fields.checkPassword">
                                Show password
                            </label>
                        </p>
                        <p class="control">
                            <button class="button is-primary is-fullwidth"
                                :class="{ 'is-disabled': !enableSubmit, 'is-loading': apiCall }"
                                type="submit">Log in</button>
                        </p>
                        <p class="control">
                            <a class="button is-link is-small"
                                v-link="{ name: 'Forgot Password', params: { email: forgotPasswordParam } }">Forgot password?</a>
                            <a class="button is-link is-small is-pulled-right"
                                v-link="{ name: 'Register' }">Not yet registered?</a>
                        </p>
                    </form>

                    <div v-if="user.id">
                        <p>
                            You are already logged in {{ user.alias | capitalize }}.
                        </p>
                        <member-logout></member-logout>
                    </div>

                    <div class="notification is-primary"
                        v-for="err in res.messages"
                        transition="alert"
                        stagger="200">
                        <button class="delete"
                            @click="closeAlert($index)"></button>
                        <span v-text="err.message"></span>
                    </div>

                </div>
            </div>
        </div>
    </div>
</template>



<script>
import api from '../../Api'
import MemberLogout from './MemberLogout'
import {
    setUser
} from '../../vuex/actions'

export default {
    data () {
        return {
            display: false,
            apiCall: false,
            blocked: false,
            res: {},
            fields: {
                email: '',
                checkPassword: false,
                password: ''
            }
        }
    },
    computed: {
        enableSubmit() {
            if (this.fields.email
                && this.fields.password
                && !this.apiCall
                && !this.blocked) {
                return true
            } else {
                return false
            }
        },
        passwordTyped() {
            if (this.fields.password) {
                return true
            } else {
                this.fields.checkPassword = false
                return false
            }
        },
        forgotPasswordParam() {
            if (this.fields.email) {
                return this.fields.email
            } else {
                return 'guest'
            }
        }
    },
    vuex: {
        actions: {
            setUser: setUser
        },
        getters: {
            user: state => state.user
        }
    },
    components: {
        MemberLogout
    },
    methods: {
        closeAlert(i) {
            this.res.messages.splice(i,1);
        },
        toggleApiCall() {
            this.apiCall = !this.apiCall
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
                    if (res.data.user && (res.data.user.banned || res.data.user.blacklisted) ) {
                        this.blocked = true
                    } else {
                        var localStorageEmail = localStorage.getItem('email')
                        if (localStorageEmail) {
                            this.fields.email = localStorageEmail
                        }
                    }
                    this.res = res.data.event
                }
            }, function (err) {
                console.log(err)
            });
        },
        postLogin() {
            var postLoginData = {
                members_section_id: api.memberSection,
                fields: {
                    email: this.fields.email,
                    password: this.fields.password
                },
                member_action: {
                    login: ''
                }
            }
            if (this.enableSubmit) {
                this.$http({
                    url: api.member,
                    data: postLoginData,
                    method: 'POST',
                    beforeSend: this.toggleApiCall()
                }).then(function (res) {
                    this.toggleApiCall()
                    if (res.data.event.success) {
                        this.setUser(res.data.user)
                        localStorage.setItem('email', res.data.user.email)
                        this.$router.go({ name: 'Dashboard'})
                    } else {
                        if (res.data.user && (res.data.user.banned || res.data.user.blacklisted) ) {
                            this.blocked = true
                        }
                        this.res = res.data.event
                    }
                }, function (err) {
                    console.log(err)
                    this.toggleApiCall()
                    this.getMember()
                });
            }
        }
    },
    created() {
        this.getMember()
    }
}
</script>

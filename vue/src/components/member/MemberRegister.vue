<template lang="html">
    <div class="register">
        <div v-if="display"
            class="columns">
            <div class="column is-6-tablet is-offset-3-tablet is-4-desktop is-offset-4-desktop">
                <div class="padding">

                    <h1 class="title is-3"
                        v-text="$route.name"></h1>

                    <form @submit.prevent="postNewMember"
                        class="padding-bottom"
                        v-if="!res.success && !blocked">
                        <p class="control">
                            <input class="input"
                                type="email"
                                placeholder="Email"
                                v-model="fields.email"
                                autofocus />
                        </p>
                        <p class="control">
                            <input class="input"
                                :type="[fields.checkPassword ? 'text' : 'password']"
                                placeholder="Password"
                                v-model="fields.password" />
                        </p>
                        <p class="control">
                            <label class="checkbox"
                                :class="{ 'is-disabled': !passwordTyped && !fields.checkPassword }">
                                <input type="checkbox"
                                    v-model="fields.checkPassword">
                                Show password
                            </label>
                        </p>
                        <p class="control">
                            <button class="button is-primary is-fullwidth"
                                :class="{ 'is-disabled': !enableSubmit, 'is-loading': apiCall }"
                                type="submit">Register</button>
                        </p>
                        <p class="control">
                            <a class="button is-link is-small"
                                v-link="{ name: 'Login' }">Already registered? Login</a>
                        </p>
                    </form>

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
import getAccess from '../../mixins/getAccess'

export default {
    data () {
        return {
            apiCall: false,
            res: {
                success: false
            },
            fields: {
                email: '',
                password: '',
                checkPassword: false,
            }
        }
    },
    mixins: [getAccess],
    computed: {
        passwordTyped() {
            if (this.fields.password) {
                return true
            } else {
                return false
            }
        },
        enableSubmit() {
            if (this.fields.email
                && this.fields.password
                && !this.apiCall) {
                return true
            } else {
                return false
            }
        }
    },
    methods: {
        closeAlert(i) {
            this.res.messages.splice(i,1);
        },
        toggleApiCall() {
            this.apiCall = !this.apiCall
        },
        postNewMember() {
            var postNewMemberData = {
                members_section_id: api.memberSection,
                fields: {
                    email: this.fields.email,
                    password: {
                        password: this.fields.password,
                        confirm: this.fields.password
                    }
                },
                action: {
                    membersnew: ''
                }
            }
            if (this.enableSubmit) {
                this.$http({
                    url: api.member,
                    data: postNewMemberData,
                    method: 'POST',
                    beforeSend: this.toggleApiCall()
                }).then(function (res) {
                    this.res = res.data.event
                    this.toggleApiCall()
                }, function (err) {
                    console.log(err)
                    this.toggleApiCall()
                });
            }
        }
    }
}
</script>

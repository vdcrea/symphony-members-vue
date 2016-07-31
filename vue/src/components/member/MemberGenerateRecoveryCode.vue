<template lang="html">
    <div class="generate-recovery-code">
        <div class="columns">
            <div class="column is-6-tablet is-offset-3-tablet is-4-desktop is-offset-4-desktop">
                <div class="padding">

                    <h1 class="title is-3"
                        v-text="$route.name"></h1>

                    <form @submit.prevent="postGenerateRecoveryCode"
                        class="padding-bottom"
                        v-if="!res.success">
                        <p class="control">
                            <input class="input"
                                type="email"
                                placeholder="Email"
                                v-model="fields.email"
                                autocomplete/>
                        </p>
                        <p class="control">
                            <button class="button is-primary is-fullwidth"
                                :class="{ 'is-disabled': !enableSubmit, 'is-loading': apiCall }"
                                type="submit">Send me a link to reset my password</button>
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
import mixinGetAccess from '../../mixins/getAccess'

export default {
    data() {
        return {
            apiCall: false,
            res: {
                status: false
            },
            fields: {
                email: ''
            }
        }
    },
    computed: {
        enableSubmit() {
            if (this.fields.email
                && !this.apiCall) {
                return true
            } else {
                return false
            }
        }
    },
    mixins: [mixinGetAccess],
    methods: {
        closeAlert(i) {
            this.res.messages.splice(i,1);
        },
        toggleApiCall() {
            this.apiCall = !this.apiCall
        },
        postGenerateRecoveryCode() {
            var postGenerateRecoveryCodeData = {
                members_section_id: api.memberSection,
                fields: {
                    email: this.fields.email
                },
                action: {
                    members_generate_recovery_code: ''
                }
            }
            if (this.enableSubmit) {
                this.$http({
                    url: api.member,
                    data: postGenerateRecoveryCodeData,
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
    },
    created() {
        if (this.$route.params.email != 'guest') {
            this.fields.email = this.$route.params.email
        }
    }
}
</script>

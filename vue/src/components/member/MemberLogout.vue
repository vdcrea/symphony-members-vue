<template lang="html">
    <div class="logout padding-top">
        <a class="button is-primary"
            v-if="user.logged"
            @click.prevent="logout">Log out</a>
    </div>
</template>


<script>
import api from '../../Api'
import {
    setUser
} from '../../vuex/actions'

export default {
    methods: {
        logout() {
            window.location = api.root + '?member_action=logout&redirect=' + window.location.origin
        }
    },
    vuex: {
        getters: {
            user: state => state.user
        }
    }
}
</script>

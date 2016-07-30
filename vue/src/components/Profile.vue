<template lang="html">
    <div class="profile">
        <div class="columns">
            <div class="column">
                <div class="padding">
                    <h1 class="title is-1"
                        v-text="$route.name"></h1>
                    <h3 class="subtitle is-3">Private</h3>
                    <p>{{ user.alias | capitalize }}</p>
                    <p>
                        <a href="mailto:{{user.email}}" v-text="user.email"></a>
                    </p>
                    <member-logout></member-logout>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import MemberLogout from './member/MemberLogout'
export default {
    components: {
        MemberLogout
    },
    vuex: {
        getters: {
            user: state => state.user
        }
    },
}
</script>

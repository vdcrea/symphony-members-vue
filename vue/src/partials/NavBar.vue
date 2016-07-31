<template>
 <nav class="nav">

    <div class="nav-left">
        <a class="nav-item"
            v-link="{ name: 'Home' }">
            Symphony Members
        </a>
    </div>

    <div class="nav-center"
        v-if="user.logged">
        <a class="nav-item is-tab"
            v-link="{ name: 'Dashboard' }"
            @click="closeMenu()">
            Dashboard
        </a>
    </div>

    <span class="nav-toggle"
        v-if="user.logged"
        @click="toggleMenu()"
        :class="mobileMenu ? 'is-active' : ''">
        <span></span>
        <span></span>
        <span></span>
    </span>

    <div class="nav-right nav-menu"
        v-if="user.logged"
        :class="mobileMenu ? 'is-active' : ''">
        <a  class="nav-item is-tab"
            v-link="{ name: 'Profile' }"
            @click="closeMenu()">
            {{ user.alias | capitalize }}
        </a>
    </div>

    <div class="nav-center"
        v-if="!user.logged">
        <a  class="nav-item is-tab"
            v-link="{ name: 'Register' }">
            Register
        </a>
        <a  class="nav-item is-tab"
            v-link="{ name: 'Log in' }">
            Log in
        </a>
    </div>

 </nav>
</template>

<script>
export default {
  data() {
    return {
        mobileMenu: false
    }
  },
  vuex: {
      getters: {
          user: state => state.user
      }
  },
  methods: {
      toggleMenu() {
          this.mobileMenu = !this.mobileMenu
      },
      closeMenu() {
          this.mobileMenu = false
      }
  }
}
</script>

<style lang="scss">
nav {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 50px;
}
</style>

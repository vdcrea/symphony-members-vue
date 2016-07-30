<template>
    <div id="app">
        <nav-bar></nav-bar>
        <router-view class="view"
            transition="view"
            transition-mode="out-in">
        </router-view>
    </div>
</template>


<script>
import NavBar from './partials/NavBar'
export default {
    components: {
        NavBar
    }
}
</script>


<style lang="scss">
@import 'assets/bulma';
html,
body {
    position: relative;
    height: 100%;
    margin: 0;
    padding: 0;
}

#app {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    a, input, button {
        transition: all .2s ease-in-out;
    }
}

.padding {
    padding: 20px;
    &-top {
        padding: 0;
        padding-top: 20px;
    }
    &-bottom {
        padding: 0;
        padding-bottom: 20px;
    }
}



// debug
pre {
    background:#000;
    color:#FFF;
    font-family: monospace;
    padding:20px;
    margin: 0;
    text-align: left;
}



// transitions

.view {
    position: absolute;
    top: 50px;
    left: 0px;
    right: 0px;
    bottom: 0px;
    overflow-x: hidden;
    &-transition {
        transition: all .3s ease-in-out;
    }
    &-enter, &-leave {
        opacity: 0;
    }
}

.alert {
    &-transition {
        position: relative;
        transition: all .5s ease-in-out;
    }
    &-enter {
        transform: translateY(50px);
        opacity: 0;
    }
    &-leave {
        opacity: 0;
    }
}
</style>

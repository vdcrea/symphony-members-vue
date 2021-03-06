import Vue from 'vue'
import Vuex from './src'
import mutations from './mutations'
import middlewares from './middlewares'

Vue.use(Vuex)

// state/store
const state = {
    user: {}
}

const store = new Vuex.Store({
    state,
    mutations
})


if (module.hot) {
    module.hot.accept(['./actions', './mutations'], () => {
        const newActions = require('./actions').default
        const newMutations = require('./mutations').default
        store.hotUpdate({
            actions: newActions,
            mutations: newMutations
        })
    })
}


export default store

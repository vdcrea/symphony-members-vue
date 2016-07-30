import Vue from 'vue'
import VueRouter from 'vue-router'
import store from './vuex/store'

Vue.use(VueRouter)

// Components
import Home from './components/Home'
import Dashboard from './components/Dashboard'
import Profile from './components/Profile'

import MemberLogin from './components/member/MemberLogin'
import MemberRegister from './components/member/MemberRegister'
import MemberActivateAccount from './components/member/MemberActivateAccount'
import MemberGenerateRecoveryCode from './components/member/MemberGenerateRecoveryCode'
import MemberResetPassword from './components/member/MemberResetPassword'

// Router options
var router = new VueRouter({
	history: true,
	saveScrollPosition: true,
	linkActiveClass: 'is-active'
})

// Set up routing and match routes to components
router.map({
	'/': {
		name: 'Home',
		component: Home
    },
	'/dashboard': {
		name: 'Dashboard',
		component: Dashboard,
		auth: true
	},

	// members routers
	'/profile': {
		name: 'Profile',
		component: Profile,
		auth: true
	},
	'/login': {
	    name:'Login',
	    component: MemberLogin
	},
	'/register': {
		name:'Register',
		component: MemberRegister
	},
	'/activation/:email/:code': {
		name:'Activation',
		component: MemberActivateAccount
	},
	'/forgot-password/:email': {
		name:'Forgot Password',
		component: MemberGenerateRecoveryCode
	},
	'/reset-password/:email/:code': {
		name:'Reset Password',
		component: MemberResetPassword
	},
    '*': {
        component: Home
    }
})

router.beforeEach(function (transition) {
	if (transition.to.auth && !store.state.user.logged) {
		transition.redirect('/login')
	} else {
		transition.next()
	}
})

export default router

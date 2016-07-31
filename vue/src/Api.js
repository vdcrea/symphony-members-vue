var root = 'http://yourdomain.com/'
var api = root + 'api/'

export default {
    root: root,
    memberSection: 1,
    // api endpoints
    member: api + 'member/',
    access: api + 'access/',
    // login redirect route
    loginRoute: 'Dashboard'
}

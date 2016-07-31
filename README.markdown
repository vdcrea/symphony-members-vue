# Symphony Members Vue

Install
---

Check out how to install [Symphony CMS](https://github.com/symphonycms/symphony-2)

Pages from Symphony are used as an API response, so page type is `JSON` (add `alloworigins` to all your pages only during dev, to let webpack server access your local install, remove this type for production).

Fill in all symphony preferences needed (email gateway, members).

Open `vue` folder with terminal. Type `npm install` then `npm run build`. Type `npm run dev` for front end dev with webpack.

Open `vue/src/Api.js` with a code editor and change your root and member sections.

Notes
---

User infos are saved in Vuex store to be accessible to any component.

Symphony Export Ensemble don't save the `vue` folder (as it is out of workspace).

Members and Members Anti Brute Force Extension modified:

- Member events names renamed to be compatible with `vue-ressources` ( - replaced by _ )
- Field `recovery-code` renamed `recovery_code` for forms for the same reason
- As forms are submitted via ajax, Members Anti Brute Force do not redirect

Issues with webpack server (only dev, no issue with built version):

- `@` in url sometimes fails, so 3 routes using emails in parameters needs to be tested with built version, not webpack dev server.

Check if `manifest/config.php` `'http-response-header-mappings'` contains `'alloworigins' => 'Access-Control-Allow-Origin: *'` for dev with webpack.

Vue Plugins
---
- vue-router
- vue-resources
- vuex


Symphony Extensions
---
- Anti Brute Force
- Debug DevKit
- ETM
- Export Ensemble
- HTML5 Doctype
- HTTP Response Header Mapping
- Maintenance Mode
- Members (modified)
- Members Anti Brute Force (modified)
- Profile DevKit
- xssFilter

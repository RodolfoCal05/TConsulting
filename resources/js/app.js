/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require("./bootstrap");
import Vue from "vue";

window.Vue = require("vue");
import VueSweetalert2 from 'vue-sweetalert2';
import { VuePivottableUi, VuePivottable } from 'vue-pivottable'
import { BootstrapVue, BootstrapVueIcons } from 'bootstrap-vue'

Vue.use(VueSweetalert2);
Vue.use(VuePivottable);
Vue.use(VuePivottableUi);
Vue.use(BootstrapVue)
Vue.use(BootstrapVueIcons)

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

const files = require.context("./", true, /\.vue$/i);
files.keys().map(key =>
    Vue.component(
        key
            .split("/")
            .pop()
            .split(".")[0],
        files(key).default
    )
);

Vue.component(
    "catalogs-roles-edit",
    require("../../vendor/csgt/utils/src/resources/views/catalogs/RolesEdit.vue")
        .default
);
Vue.component(
    "catalogs-rolemodule",
    require("../../vendor/csgt/utils/src/resources/views/catalogs/RoleModule.vue")
        .default
);
//Vue.component('catalogs-users-edit', require('../../vendor/csgt/utils/src/resources/views/catalogs/UsersEdit.vue').default)
Vue.component(
    "InputField",
    require("../../vendor/csgt/utils/src/resources/components/InputField.vue")
        .default
);

Vue.component(
    "profile",
    require("../../vendor/csgt/utils/src/resources/views/Profile.vue").default
);

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

const app = new Vue({
    el: "#app"
});

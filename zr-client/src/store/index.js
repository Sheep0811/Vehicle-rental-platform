import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

//使用Vuex插件
Vue.use(Vuex)

export default new Vuex.Store({
  //使用Vuex插件
  state: {
    //用户身份令牌
    token: '',
    //当前登录用户名
    loginUserName: '',
    //激活的菜单
    menuIndex: '',
    //一级菜单
    breadcrumbTitle: '',
    //二级菜单
    breadcrumbIndex: '',
    //头像地址
    headImgUrl: '',
    //权限列表
    authUrlsList: '',
    //车辆图片地址
    carImgUrl: '',
  },
  //使用Vuex插件
  mutations: {
    token(state, param) {
      state.token = param
    },
    loginUserName(state, param) {
      state.loginUserName = param
    },
    menuIndex(state, param) {
      state.menuIndex = param
    },
    breadcrumbTitle(state, param) {
      state.breadcrumbTitle = param
    },
    breadcrumbIndex(state, param) {
      state.breadcrumbIndex = param
    },
    carImgUrl(state, param) {
      state.carImgUrl = param
    },
    authUrlsList(state, param) {
      state.authUrlsList = param
    }
  },
  //使用Vuex插件
  plugins: [createPersistedState()]
});

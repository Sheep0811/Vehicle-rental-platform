import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/components/Login'
import NoAuth from '@/components/NoAuth'
import Home from '@/components/Home'
import SysUser from '@/components/sys/User'
import SysProfile from '@/components/sys/Profile'
import CarCar from '@/components/car/Car'
import CarWork from '@/components/car/Work'
import SysAuth from '@/components/sys/Auth'
import ShopCity from '@/components/shop/City'
import ShopShop from '@/components/shop/Shop'
import SysRole from '@/components/sys/Role'
import ReportCar from '@/components/charts/Cartype'
import ReportMoney from '@/components/charts/Money'
import LeaseCustomer from '@/components/lease/Customer'
import LeaseAgreement from '@/components/lease/Agreement'
import LeaseOrder from '@/components/lease/Order'


Vue.use(Router)


export default new Router({
  routes: [
    {
      path: '/',
      redirect: 'Login'
    },
    {
      path: '/Login',
      name: 'Login',
      component: Login
    },
    {
      path: '/Home',
      name: 'Home',
      component: Home,
      children: [{
        path: '/NoAuth',
        name: 'NoAuth',
        component: NoAuth
      },
      {
        path: '/SysUser',
        name: 'SysUser',
        component: SysUser
      },
      {
        path: '/SysProfile',
        name: 'SysProfile',
        component: SysProfile
      },
      {
        path: '/SysRole',
        name: 'SysRole',
        component: SysRole,
      },
      {
        path: '/SysAuth',
        name: 'SysAuth',
        component: SysAuth
      },    
      {
        path: '/ReportMoney',
        name: 'ReportMoney',
        component: ReportMoney
      },
      {
        path: '/ReportCar',
        name: 'ReportCar',
        component: ReportCar
      },
      {
        path: '/LeaseCustomer',
        name: 'LeaseCustomer',
        component: LeaseCustomer
      },
      {
        path: '/LeaseOrder',
        name: 'LeaseOrder',
        component: LeaseOrder
      },
      {
        path: '/LeaseAgreement',
        name: 'LeaseAgreement',
        component: LeaseAgreement
      },
      {
        path: '/CarCar',
        name: 'CarCar',
        component: CarCar,

      },
      {
        path: '/CarWork',
        name: 'CarWork',
        component: CarWork
      },
      {
        path: '/ShopCity',
        name: 'ShopCity',
        component: ShopCity
      },
      {
        path: '/ShopShop',
        name: 'ShopShop',
        component: ShopShop
      },
      ]
    }
  ]
})

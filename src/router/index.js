import { createRouter, createWebHistory } from 'vue-router'
import HomeView    from '../views/HomeView.vue'
import ProjectsView from '../views/ProjectsView.vue'
import AboutView   from '../views/AboutView.vue'
import ContactView from '../views/ContactView.vue'

const routes = [
  { path: '/',         name: 'home',     component: HomeView },
  { path: '/projects', name: 'projects', component: ProjectsView },
  { path: '/about',    name: 'about',    component: AboutView },
  { path: '/contact',  name: 'contact',  component: ContactView },
]

export const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior() { return { top: 0 } },
})

<template>
  <NavBar />
  <RouterView v-slot="{ Component }">
    <Transition name="page" mode="out-in">
      <component :is="Component" />
    </Transition>
  </RouterView>
  <SiteFooter />
</template>

<script setup>
import { RouterView } from 'vue-router'
import NavBar    from './components/NavBar.vue'
import SiteFooter from './components/SiteFooter.vue'
</script>
